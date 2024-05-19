from flask import Flask, render_template, request
import random
import json
from flask import Flask, request, jsonify
import torch
from model import NeuralNet
from nltk_utils import bag_of_words, tokenize

app = Flask(__name__)

with open('intents.json', 'r', encoding='utf-8') as json_data:
    intents = json.load(json_data)


FILE = "data.pth"
data = torch.load(FILE)

input_size = data["input_size"]
hidden_size = data["hidden_size"]
output_size = data["output_size"]
all_words = data['all_words']
tags = data['tags']
model_state = data["model_state"]

model = NeuralNet(input_size, hidden_size, output_size)
model.load_state_dict(model_state)
model.eval()    

def get_response(user_input):
    sentence = tokenize(user_input.lower())  # convert input to lowercase
    X = bag_of_words(sentence, all_words)
    X = X.reshape(1, X.shape[0])
    X = torch.from_numpy(X)
    output = model(X)
    _, predicted = torch.max(output, dim=1)
    tag = tags[predicted.item()]
    probs = torch.softmax(output, dim=1)
    prob = probs[0][predicted.item()]
    if prob.item() > 0.75:
        for intent in intents['intents']:
            if tag == intent["tag"]:
                return random.choice(intent['responses'])
    else:
        return "I do not understand..."
    
def add_intent(tag, patterns, responses):
    # Load the existing intents from the intents.json file
    with open('intents.json', 'r', encoding='utf-8') as f:
        intents = json.load(f)
    # Add the new intent to the intents list
    intent = {
        'tag': tag,
        'patterns': patterns,
        'responses': responses
    }
    intents['intents'].append(intent)
    # Write the updated intents to the intents.json file
    with open('intents.json', 'w', encoding='utf-8') as f:
        json.dump(intents, f, indent=4, ensure_ascii=False) 
    

@app.route("/")
def chat():
    return render_template("chat.html")    

@app.route("/get")
def get_bot_response():
    user_input = request.args.get('msg')
    return str(get_response(user_input))

@app.route('/post', methods=['POST'])
def handle_post_request():
    data = request.json
    tag = data['tag']
    patterns = data['patterns']
    responses = data['responses']

    # Add the intent to the dataset
    add_intent(tag, patterns, responses)

    # Return a success message
    return jsonify({'message': 'Intent added successfully'})

@app.route('/put', methods=['PUT'])
def handle_update_request():
    updated_intent = request.json
    if updated_intent is None:
        return jsonify({'error': 'Request body must be a valid JSON object with properties "tag", "patterns", and "responses"'}), 400

    with open('intents.json', 'r', encoding='utf-8') as json_data:
        intents = json.load(json_data)

    # find the intent in the list of intents and update it
    for intent in intents['intents']:
        if intent['tag'] == updated_intent.get('tag'):
            intent['patterns'] = updated_intent.get('patterns')
            intent['responses'] = updated_intent.get('responses')
            break
    else:
        return jsonify({'error': f'Intent with tag "{updated_intent.get("tag")}" not found'}), 404

    # write the updated intents back to the file
    with open('intents.json', 'w', encoding='utf-8') as f:
        json.dump(intents, f, indent=4, ensure_ascii=False)

    return jsonify({'message': 'Intent updated successfully'})

if __name__ == "__main__":
    app.run()




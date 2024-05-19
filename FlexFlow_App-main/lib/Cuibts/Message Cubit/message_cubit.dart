import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import '../../Data/Models/chatbot_model.dart';
import '../../Data/Services/chatbot_service.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit._() : super(MessageInitial());

  static final MessageCubit _singleton = MessageCubit._();

  factory MessageCubit.getInstance() {
    return _singleton;
  }

  List<String> userMessages = [];
  List<String> botMessages = [];
  List<MessageModel> chatMessages = [];
  final TextEditingController messageController = TextEditingController();

  final StreamController<List<MessageModel>> _messageStreamController =
      StreamController<List<MessageModel>>();

  Stream<List<MessageModel>> get _messageStream =>
      _messageStreamController.stream;

  Future<void> sendMessage() async {
    final userMessage = messageController.text;
    if (userMessage.isNotEmpty) {
      final newUserMessage = MessageModel(text: userMessage, sender: 'user');
      userMessages.add(newUserMessage.text); // Add user message to the list

      final botResponse = await getChatbotResponse(userMessage);
      final newBotMessage = MessageModel(text: botResponse, sender: 'bot');
      botMessages.add(newBotMessage.text); // Add bot response to the list

      // Combine userMessages and botMessages into chatMessages list
      chatMessages = [];
      for (int i = 0; i < userMessages.length; i++) {
        chatMessages.add(MessageModel(text: userMessages[i], sender: 'user'));
        if (i < botMessages.length) {
          chatMessages.add(MessageModel(text: botMessages[i], sender: 'bot'));
        }
      }

      emit(MessagesLoaded(chatMessages));
      messageController.text = '';
    }
  }

  void getMessages() {
    emit(MessageLoading());
    _messageStream.listen((event) {
      emit(MessagesLoaded(event.cast<MessageModel>()));
    });
  }
}

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Themes/themes_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Cuibts/Message Cubit/message_cubit.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    // ignore: no_leading_underscores_for_local_identifiers
    final _messageCubit = BlocProvider.of<MessageCubit>(context);
    // ignore: no_leading_underscores_for_local_identifiers
    final ScrollController _scrollController =
        ScrollController(); // Get the MessageCubit instance from the context

    return Scaffold(
      backgroundColor: themeProvider.currentTheme == AppTheme.Light
          ? Colors.white
          : Colors.grey[900],
      appBar: AppBar(
        backgroundColor: themeProvider.currentTheme == AppTheme.Light
            ? const Color(0xffFFBE0B)
            : const Color.fromARGB(255, 77, 76, 74),
        elevation: 6,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
        actions: [
          IconButton(
            icon: themeProvider.currentTheme == AppTheme.Light
                ? const Icon(Icons.light_mode)
                : const Icon(Icons.dark_mode),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
        title: const Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/Logo.jpg'),
              radius: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Spacer(
              flex: 1,
            ),
            Text(
              'FlexFlow',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'KaushanScript',
                color: Colors.black,
              ),
            ),
            Spacer(
              flex: 4,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: BlocBuilder<MessageCubit, MessageState>(
                builder: (context, state) {
                  if (state is MessagesLoaded) {
                    final chatMessages = state.messages;
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    });
                    return ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(8.0),
                      itemCount: chatMessages.length,
                      itemBuilder: (BuildContext context, int index) {
                        final message = chatMessages[index];
                        final isUser = message.sender == 'user';
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4.0,
                          ),
                          child: Bubble(
                            alignment:
                                isUser ? Alignment.topRight : Alignment.topLeft,
                            nip: isUser
                                ? BubbleNip.rightBottom
                                : BubbleNip.leftBottom,
                            color: isUser
                                ? const Color.fromARGB(255, 246, 207, 123)
                                : const Color(0xffE6E6FA),
                            child: Text(
                              message.text,
                              style: TextStyle(
                                color: isUser
                                    ? Colors.black
                                    : const Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageCubit.messageController,
                      onChanged: (data) {
                        // _messageController.text = data;
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 20.0,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 241, 223, 186),
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0),
                          borderSide: const BorderSide(
                            color: Color(0xffC89116),
                            width: 2.0,
                          ),
                        ),
                        hintText: 'Type your message here...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      final userMessage =
                          _messageCubit.messageController.text.trim();
                      if (userMessage.isNotEmpty) {
                        await _messageCubit.sendMessage();
                        _messageCubit.messageController.clear();
                      }
                    },
                    icon: const Icon(
                      Icons.send,
                      color: Color.fromARGB(255, 234, 177, 54),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

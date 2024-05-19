part of 'message_cubit.dart';

@immutable
abstract class MessageState {}

class MessageInitial extends MessageState {}

class MessageLoading extends MessageState {}

class MessagesLoaded extends MessageState {
  final List<MessageModel> messages;

  MessagesLoaded(this.messages);
}

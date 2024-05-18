import 'package:learn_teacher_bloc/common/entities/message.dart';

class MessageState {
  final List<Message> message;
  final bool loadStatus;

  MessageState({this.message = const <Message>[], this.loadStatus = true});
  MessageState copyWith({List<Message>? message, bool? loadStatus}) {
    return MessageState(
        loadStatus: loadStatus ?? this.loadStatus,
        message: message ?? this.message);
  }
}

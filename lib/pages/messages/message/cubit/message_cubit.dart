import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_teacher_bloc/common/entities/message.dart';
import 'package:learn_teacher_bloc/pages/messages/message/cubit/message_states.dart';

class MessageCubits extends Cubit<MessageState> {
  MessageCubits() : super(MessageState());
  void loadStatusChanged(bool loadStatus) {
    emit(state.copyWith(loadStatus: loadStatus));
  }

  void messageChanged(List<Message> message) {
    emit(state.copyWith(message: message));
  }
}

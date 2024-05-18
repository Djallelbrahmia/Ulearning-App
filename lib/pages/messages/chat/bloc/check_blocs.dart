import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_teacher_bloc/pages/messages/chat/bloc/chat_events.dart';
import 'package:learn_teacher_bloc/pages/messages/chat/bloc/chat_states.dart';

class ChatBloc extends Bloc<ChatEvents, ChatState> {
  ChatBloc() : super(const ChatState()) {
    on<TriggerMsgContentList>(_triggerMsgContentList);
    on<TriggerAddMsgContent>(_triggerAddMsgContent);
    on<TriggerMoreStatus>(_triggerMoreStatus);
    on<TriggerClearMsgList>(_triggerClearMessageList);
    on<TriggerMsgLoadData>(_triggerMsgLoadData);
  }
  _triggerMsgContentList(TriggerMsgContentList event, Emitter<ChatState> emit) {
    var res = List.of(state.msgcontentList);
    res.insert(0, event.msgContentList);
    emit(state.copyWith(msgcontentList: res));
  }

  _triggerMsgLoadData(TriggerMsgLoadData event, Emitter<ChatState> emit) {
    emit(state.copyWith(isloading: event.isLoadMore));
  }

  _triggerAddMsgContent(TriggerAddMsgContent event, Emitter<ChatState> emit) {
    var res = List.of(state.msgcontentList);
    res.add(event.msgContent);
    emit(state.copyWith(msgcontentList: res));
  }

  _triggerMoreStatus(TriggerMoreStatus event, Emitter<ChatState> emit) {
    emit(state.copyWith(more_status: event.moreStatus));
  }

  _triggerClearMessageList(TriggerClearMsgList event, Emitter<ChatState> emit) {
    emit(state.copyWith(msgcontentList: []));
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_teacher_bloc/common/entities/entities.dart';
import 'package:learn_teacher_bloc/common/widgets/toast.dart';
import 'package:learn_teacher_bloc/global.dart';
import 'package:learn_teacher_bloc/pages/messages/chat/bloc/chat_events.dart';
import 'package:learn_teacher_bloc/pages/messages/chat/bloc/check_blocs.dart';

class ChatController {
  late BuildContext context;
  ChatController({required this.context});
  TextEditingController textEditingController = TextEditingController();
  UserItem? userProfile = Global.storageService.getUserProfile();
  ScrollController appScrollController = ScrollController();
  final db = FirebaseFirestore.instance;
  late var doc_id;
  late StreamSubscription<QuerySnapshot<Msgcontent>> listener;
  bool isloadMore = true;
  void dispose() {
    textEditingController.dispose();
    listener.cancel();
    _clearMsgNum(doc_id);
  }

  void init() {
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    doc_id = data["doc_id"];
    _chatSnapShots();
    _clearMsgNum(doc_id);
  }

  _clearMsgNum(String docId) async {
    var messageRes = await db
        .collection("message")
        .doc(docId)
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .get();
    if (messageRes.data() != null) {
      var item = messageRes.data();
      int to_msg_num = item?.to_msg_num ?? 0;
      int from_msg_num = item?.to_msg_num ?? 0;

      if (item?.from_token == userProfile?.token) {
        to_msg_num = 0;
      } else {
        from_msg_num = 0;
      }
      await db
          .collection("message")
          .doc(docId)
          .update({"to_msg_num": to_msg_num, "from_msg_num": from_msg_num});
    }
  }

  void _chatSnapShots() async {
    var chatContext = context;
    chatContext.read<ChatBloc>().add(const TriggerClearMsgList());
    var messages = db
        .collection("message")
        .doc(doc_id)
        .collection("msglist")
        .withConverter(
            fromFirestore: Msgcontent.fromFirestore,
            toFirestore: (Msgcontent msg, options) => msg.toFirestore())
        .orderBy("addtime", descending: true)
        .limit(14);
    listener = messages.snapshots().listen((event) {
      List<Msgcontent> tempMsgList = [];
      for (var change in event.docChanges) {
        switch (change.type) {
          case DocumentChangeType.added:
            if (change.doc.data() != null) {
              tempMsgList.add(change.doc.data()!);
            }
          default:
            break;
        }
      }
      for (var element in tempMsgList.reversed) {
        chatContext.read<ChatBloc>().add(TriggerMsgContentList(element));
      }
    }, onError: (error) => toastInfo(msg: "Failed to load messages $error"));
    appScrollController.addListener(() {
      if (appScrollController.offset + 10 >
          appScrollController.position.maxScrollExtent) {
        if (isloadMore) {
          chatContext.read<ChatBloc>().add(TriggerMsgLoadData(isloadMore));
          isloadMore = false;
          _asyncLoadMoreData();
        }
      }
    });
  }

  void _asyncLoadMoreData() async {
    var state = context.read<ChatBloc>().state;
    var moreMessages = await db
        .collection("message")
        .doc(doc_id)
        .collection("msglist")
        .withConverter(
            fromFirestore: Msgcontent.fromFirestore,
            toFirestore: (Msgcontent msg, options) => msg.toFirestore())
        .orderBy("addtime", descending: true)
        .where("addtime", isLessThan: state.msgcontentList.last.addtime)
        .limit(10)
        .get();
    if (moreMessages.docs.isNotEmpty) {
      moreMessages.docs.forEach((element) {
        var data = element.data();
        context.read<ChatBloc>().add(TriggerAddMsgContent(data));
      });
    }
    SchedulerBinding.instance.addPostFrameCallback((_) {
      isloadMore = true;
    });
  }

  sendMessage() async {
    if (textEditingController.text.isEmpty) {
      toastInfo(msg: "You can not send an empty message");
    } else {
      String sendContent = textEditingController.text.trim();
      textEditingController.clear();
      final content = Msgcontent(
        token: userProfile?.token,
        content: sendContent,
        addtime: Timestamp.now(),
        type: "text",
      );
      await db
          .collection("message")
          .doc(doc_id)
          .collection("msglist")
          .withConverter(
              fromFirestore: Msgcontent.fromFirestore,
              toFirestore: (Msgcontent msg, options) => msg.toFirestore())
          .add(content);
      var messageRes = await db
          .collection("message")
          .doc(doc_id)
          .withConverter(
              fromFirestore: Msg.fromFirestore,
              toFirestore: (Msg msg, options) => msg.toFirestore())
          .get();
      if (messageRes.data() != null) {
        var item = messageRes.data()!;
        int to_msg_num = item.to_msg_num ?? 0;
        int from_msg_num = item.from_msg_num ?? 0;
        if (item.from_token == userProfile!.token) {
          from_msg_num++;
        } else {
          to_msg_num++;
        }
        await db.collection("message").doc(doc_id).update({
          "to_msg_num": to_msg_num,
          "from_msg_num": from_msg_num,
          "last_msg": sendContent,
          "last_time": Timestamp.now()
        });
      }
    }
  }
}

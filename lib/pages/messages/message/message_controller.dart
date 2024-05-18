import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_teacher_bloc/common/entities/entities.dart';
import 'package:learn_teacher_bloc/common/routes/routes.dart';
import 'package:learn_teacher_bloc/global.dart';
import 'package:learn_teacher_bloc/pages/messages/message/cubit/message_cubit.dart';

class MessagesController {
  late BuildContext context;
  MessagesController({required this.context});
  final db = FirebaseFirestore.instance;
  final UserItem? userProfile = Global.storageService.getUserProfile();
  late StreamSubscription<QuerySnapshot<Msg>>? listenerFrom;
  late StreamSubscription<QuerySnapshot<Msg>>? listenerTo;

  void init() {
    _snapShots();
  }

  void goChat(Message item) async {
    print({
      "to_token": item.token,
      "to_avatar": item.avatar,
      "to_online": item.online
    });
    var nav = Navigator.of(context);
    if (item.doc_id != null) {
      if (listenerFrom != null || listenerTo != null) {
        await listenerFrom?.cancel();
        await listenerTo?.cancel();
      }
    }
    nav.pushNamed(AppRoutes.Chat, arguments: {
      "doc_id": item.doc_id,
      "to_token": item.token!,
      "to_avatar": item.avatar!,
      "to_online": item.online!,
    }).then((value) => _snapShots());
  }

  void _snapShots() async {
    var token = userProfile?.token;
    final toMessageRef = db
        .collection("message")
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where("to_token", isEqualTo: token);
    final fromMessageRef = db
        .collection("message")
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where("from_token", isEqualTo: token);
    listenerFrom = fromMessageRef.snapshots().listen((event) async {
      await _asyncLoadMsgData();
    });
    listenerTo = toMessageRef.snapshots().listen((event) async {
      await _asyncLoadMsgData();
    });
  }

  _asyncLoadMsgData() async {
    var token = userProfile?.token;

    final fromMessageRef = await db
        .collection("message")
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where("from_token", isEqualTo: token)
        .get();
    final toMessageRef = await db
        .collection("message")
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where("to_token", isEqualTo: token)
        .get();
    List<Message> messageList = <Message>[];
    if (fromMessageRef.docs.isNotEmpty) {
      var message = await _addMessage(fromMessageRef.docs);
      messageList.addAll(message);
    }
    if (toMessageRef.docs.isNotEmpty) {
      var message = await _addMessage(toMessageRef.docs);
      messageList.addAll(message);
    }
    // messageList.sort((a, b) {
    //   if (b.last_time == null) return 0;
    //   if (a.last_time == null) return 0;
    //   return b.last_time!.compareTo(a.last_time!);
    // });
    if (context.mounted) {
      context.read<MessageCubits>().messageChanged(messageList);
      context.read<MessageCubits>().loadStatusChanged(false);
    }
  }

  Future<List<Message>> _addMessage(
      List<QueryDocumentSnapshot<Msg>> data) async {
    List<Message> messageList = <Message>[];
    data.forEach((element) {
      var item = element.data();

      Message message = Message();
      message.doc_id = element.id;
      message.last_time = item.last_time;
      message.msg_num = item.msg_num;
      message.last_msg = item.last_msg;
      if (item.from_token == userProfile?.token) {
        message.name = item.to_name;
        message.avatar = item.to_avatar;
        message.online = item.to_online ?? 0;
        message.msg_num = item.to_msg_num ?? 0;
        message.token = item.to_token;
      } else {
        message.name = item.from_name;
        message.avatar = item.from_avatar;
        message.online = item.from_online ?? 0;
        message.msg_num = item.from_msg_num ?? 0;
        message.token = item.to_token;
      }
      messageList.add(message);
    });
    return messageList;
  }
}

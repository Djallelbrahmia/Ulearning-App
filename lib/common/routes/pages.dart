import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_teacher_bloc/common/entities/entities.dart';
import 'package:learn_teacher_bloc/common/routes/observers.dart';
import 'package:learn_teacher_bloc/common/services/storage.dart';
import 'package:learn_teacher_bloc/global.dart';
import 'package:learn_teacher_bloc/pages/messages/chat/bloc/check_blocs.dart';
import 'package:learn_teacher_bloc/pages/messages/chat/chat.dart';
import 'package:learn_teacher_bloc/pages/messages/message/cubit/message_cubit.dart';
import 'package:learn_teacher_bloc/pages/messages/message/message.dart';
import 'package:learn_teacher_bloc/pages/sign-in/bloc/signin_bloc.dart';
import 'package:learn_teacher_bloc/pages/sign-in/sign_in.dart';
import 'package:learn_teacher_bloc/pages/welcome/bloc/welcome_bloc.dart';
import 'package:learn_teacher_bloc/pages/welcome/welcome.dart';

import 'routes.dart';

class AppPages {
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  static List<PageEntity> Routes() {
    return [
      PageEntity(
          path: AppRoutes.INITIAL,
          page: const Welcome(),
          bloc: BlocProvider(create: (_) => WelcomeBloc())),
      PageEntity(
          path: AppRoutes.Sign_in,
          page: const SignInView(),
          bloc: BlocProvider(create: (_) => SignInBloc())),
      PageEntity(
          path: AppRoutes.Message,
          page: const MessagePage(),
          bloc: BlocProvider(create: (_) => MessageCubits())),
      PageEntity(
          path: AppRoutes.Chat,
          page: const ChatPage(),
          bloc: BlocProvider(create: (_) => ChatBloc())),
/*
      PageEntity(
          path:AppRoutes.Profile,
          page:Profile(),
          bloc:BlocProvider(create: (_) => ProfileBloc())
      ),*/
    ];
  }

  static List<dynamic> Blocer(BuildContext context) {
    List<dynamic> blocerList = <dynamic>[];
    for (var blocer in Routes()) {
      blocerList.add(blocer.bloc);
    }
    return blocerList;
  }

  static MaterialPageRoute GenerateRouteSettings(RouteSettings settings) {
    if (settings.name != null) {
      var result = Routes().where((element) => element.path == settings.name);
      if (result.isNotEmpty) {
        // first open App
        bool deviceFirstOpen = Global.storageService.getDeviceFirstOpen();
        if (result.first.path == AppRoutes.INITIAL && deviceFirstOpen) {
          bool isLogin = Global.storageService.getIsLogin();
          //is login
          if (isLogin) {
            return MaterialPageRoute<void>(
                builder: (_) => MessagePage(), settings: settings);
          }
          return MaterialPageRoute<void>(
              builder: (_) => SignInView(), settings: settings);
        }
        return MaterialPageRoute<void>(
            builder: (_) => result.first.page, settings: settings);
      }
    }

    return MaterialPageRoute<void>(
        builder: (_) => SignInView(), settings: settings);
  }
}

class PageEntity<T> {
  String path;
  Widget page;
  dynamic bloc;

  PageEntity({
    required this.path,
    required this.page,
    required this.bloc,
  });
}

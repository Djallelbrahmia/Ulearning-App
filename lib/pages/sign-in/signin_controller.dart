import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:learn_teacher_bloc/common/apis/apis.dart';
import 'package:learn_teacher_bloc/common/entities/entities.dart';
import 'package:learn_teacher_bloc/common/routes/routes.dart';
import 'package:learn_teacher_bloc/common/values/constants.dart';
import 'package:learn_teacher_bloc/common/widgets/toast.dart';
import 'package:learn_teacher_bloc/global.dart';
import 'package:learn_teacher_bloc/pages/sign-in/bloc/signin_bloc.dart';

class SignInController {
  final BuildContext context;
  const SignInController({required this.context});
  void handleSignIn(String type) async {
    final state = context.read<SignInBloc>().state;
    String username = state.username;
    String password = state.password;

    LoginRequestEntity loginRequestEntity = LoginRequestEntity();
    loginRequestEntity.username = username;
    loginRequestEntity.password = password;
    asyncPostAllData(loginRequestEntity);
  }

  void asyncPostAllData(LoginRequestEntity loginRequestEntity) async {
    EasyLoading.show(
      indicator: const CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true,
    );
    var result = await UserAPI.Login(params: loginRequestEntity);

    if (result.code == 0) {
      try {
        Global.storageService.setString(
            AppConstants.STORAGE_USER_PROFILE_KEY, jsonEncode(result.data!));
        Global.storageService.setString(
            AppConstants.STORAGE_USER_TOKEN_KEY, result.data!.access_token!);
        EasyLoading.dismiss();
        if (context.mounted) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(AppRoutes.Message, (route) => false);
        }
      } catch (e) {
        toastInfo(msg: "Something went wrong");
        EasyLoading.dismiss();
      }
    } else {
      toastInfo(msg: "Something went wrong");

      EasyLoading.dismiss();
    }
  }
}

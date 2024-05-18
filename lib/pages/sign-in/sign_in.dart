import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learn_teacher_bloc/common/values/colors.dart';
import 'package:learn_teacher_bloc/common/widgets/base_text_widget.dart';
import 'package:learn_teacher_bloc/pages/sign-in/bloc/signin_bloc.dart';
import 'package:learn_teacher_bloc/pages/sign-in/bloc/signin_events.dart';
import 'package:learn_teacher_bloc/pages/sign-in/bloc/signin_states.dart';
import 'package:learn_teacher_bloc/pages/sign-in/signin_controller.dart';
import 'package:learn_teacher_bloc/pages/sign-in/sing_in_widgets.dart';
import 'package:learn_teacher_bloc/pages/sign-in/widgets/app_bar.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        return Container(
          color: Colors.white,
          child: SafeArea(
              child: Scaffold(
            backgroundColor: Colors.white,
            appBar: buildAppBar("Login"),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 70.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: reusableSubtitleText(
                        " Use your username and password to login",
                        fontSize: 13.sp),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30.h),
                    padding: EdgeInsets.only(left: 25.w, right: 25.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        reusbaleText("Username"),
                        SizedBox(
                          height: 5.h,
                        ),
                        buildTextField(
                            "Enter your Username adress", "email", "user",
                            (value) {
                          context.read<SignInBloc>().add(UsernameEvent(value));
                        }),
                        reusbaleText("Password"),
                        SizedBox(
                          height: 5.h,
                        ),
                        buildTextField(
                            "Enter your password", "password", "lock", (value) {
                          context.read<SignInBloc>().add(PasswordEvent(value));
                        })
                      ],
                    ),
                  ),
                  buildLogInButton("Login", "login", () {
                    SignInController(context: context).handleSignIn("email");
                  }),
                  buildLogInButton("Sign up", "Register", () {
                    Navigator.of(context).pushNamed("/register");
                  })
                ],
              ),
            ),
          )),
        );
      },
    );
  }
}

Widget buildTextField(String hintText, String textType, String iconName,
    void Function(String data)? func) {
  return Container(
    width: 325.w,
    height: 50.h,
    margin: EdgeInsets.only(bottom: 16.h),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15.w),
        ),
        border: Border.all(color: AppColors.primaryFourThElementText)),
    child: Row(
      children: [
        Container(
            width: 16.w,
            height: 16.w,
            margin: EdgeInsets.only(left: 17.w),
            child: Image.asset("assets/icons/${iconName}.png")),
        Container(
          width: 200.w,
          height: 50.h,
          child: TextField(
            onChanged: func,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
                hintText: hintText,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                hintStyle: const TextStyle(
                    color: AppColors.primarySecondaryElementText)),
            style: TextStyle(
                color: AppColors.primaryText,
                fontFamily: "Avenir",
                fontWeight: FontWeight.normal,
                fontSize: 14.sp),
            autocorrect: false,
            obscureText: textType == "password",
          ),
        )
      ],
    ),
  );
}

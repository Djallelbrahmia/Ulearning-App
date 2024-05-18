import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learn_teacher_bloc/common/values/colors.dart';
import 'package:learn_teacher_bloc/pages/sign-in/signin_controller.dart';

Widget buildThirdPartyLogin(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(top: 40.h, bottom: 20.h),
    padding: EdgeInsets.only(left: 25.h, right: 25.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _reusableIcons("google", context),
        _reusableIcons("facebook", context),
        _reusableIcons("apple", context)
      ],
    ),
  );
}

Widget _reusableIcons(String iconName, BuildContext context) {
  return GestureDetector(
    onTap: () {
      SignInController(context: context).handleSignIn("google");
    },
    child: SizedBox(
      width: 40.w,
      height: 40.w,
      child: Image.asset("assets/icons/${iconName}.png"),
    ),
  );
}

Widget reusbaleText(String text) {
  return Container(
    margin: EdgeInsets.only(bottom: 5.h),
    child: Text(
      text,
      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
    ),
  );
}

Widget buildLogInButton(String buttonName, String type, Function()? func) {
  return GestureDetector(
      onTap: func,
      child: Container(
        margin: EdgeInsets.only(
            left: 25.w, right: 25.w, top: type == "login" ? 25.h : 15.h),
        width: 325.w,
        height: 50.h,
        decoration: BoxDecoration(
            border: Border.all(
                color: type == "login"
                    ? Colors.transparent
                    : AppColors.primaryFourThElementText),
            color: type == "login"
                ? AppColors.primaryElement
                : AppColors.primaryBackground,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 1),
                  color: Colors.grey.withOpacity(0.1))
            ]),
        child: Center(
            child: Text(
          buttonName,
          style: TextStyle(
              fontSize: 16.sp,
              color: type == "login"
                  ? AppColors.primaryBackground
                  : AppColors.primaryText),
        )),
      ));
}

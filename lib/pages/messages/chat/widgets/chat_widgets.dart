import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learn_teacher_bloc/common/entities/entities.dart';
import 'package:learn_teacher_bloc/common/values/colors.dart';

Widget chatFileButtons(String iconPath) {
  return GestureDetector(
    child: Container(
      height: 40.h,
      width: 40.h,
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
          color: AppColors.primaryBackground,
          borderRadius: BorderRadius.circular(40.w),
          boxShadow: [
            BoxShadow(
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(1, 1),
                color: Colors.grey.withOpacity(0.2))
          ]),
      child: Image.asset(iconPath),
    ),
  );
}

Widget chatWidget(Msgcontent content) {
  return Container(
      child: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 250.w,
          minHeight: 40.h,
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(right: 0.w, top: 5.w),
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: AppColors.primaryElement,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(0.w),
                  topLeft: Radius.circular(20.w),
                  bottomLeft: Radius.circular(20.w),
                  bottomRight: Radius.circular(20.w),
                ),
              ),
              child: Text(
                content.content ?? "",
                style: TextStyle(
                    fontSize: 14.sp, color: AppColors.primaryElementText),
              ),
            )
          ],
        ),
      )
    ],
  ));
}

Widget chatRightWidget(Msgcontent content) {
  return Container(
      child: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 250.w,
          minHeight: 40.h,
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(right: 0.w, top: 5.w),
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: AppColors.primaryElement,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(0.w),
                  topLeft: Radius.circular(20.w),
                  bottomLeft: Radius.circular(20.w),
                  bottomRight: Radius.circular(20.w),
                ),
              ),
              child: Text(
                content.content ?? "",
                style: TextStyle(
                    fontSize: 14.sp, color: AppColors.primaryElementText),
              ),
            )
          ],
        ),
      )
    ],
  ));
}

Widget chatLefttWidget(Msgcontent content) {
  return Container(
      child: Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 250.w,
          minHeight: 40.h,
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(right: 0.w, top: 5.w),
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: AppColors.primarySecondaryBackground,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(0.w),
                  topLeft: Radius.circular(20.w),
                  bottomLeft: Radius.circular(20.w),
                  bottomRight: Radius.circular(20.w),
                ),
              ),
              child: Text(
                content.content ?? "",
                style: TextStyle(fontSize: 14.sp, color: AppColors.primaryText),
              ),
            )
          ],
        ),
      )
    ],
  ));
}

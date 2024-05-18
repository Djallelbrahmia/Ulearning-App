import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learn_teacher_bloc/common/values/colors.dart';

Widget listContainer(String name,
    {double fontSize = 13,
    Color color = AppColors.primaryText,
    FontWeight fontWeight = FontWeight.bold}) {
  return Container(
    margin: EdgeInsets.only(left: 6.w),
    width: 180.w,
    child: Text(
      name,
      overflow: TextOverflow.clip,
      maxLines: 1,
      style: TextStyle(
          color: color, fontSize: fontSize.sp, fontWeight: fontWeight),
    ),
  );
}

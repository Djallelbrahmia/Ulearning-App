import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learn_teacher_bloc/common/entities/message.dart';
import 'package:learn_teacher_bloc/common/utils/date.dart';
import 'package:learn_teacher_bloc/common/values/colors.dart';
import 'package:learn_teacher_bloc/common/widgets/base_text_widget.dart';
import 'package:learn_teacher_bloc/pages/messages/message/message_controller.dart';

Widget buildChatList(
    BuildContext context, Message item, MessagesController controller) {
  return Container(
    width: 325.w,
    height: 80.h,
    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 0.w),
    child: GestureDetector(
      onTap: () {
        controller.goChat(item);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 60.h,
                width: 60.h,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage("${item.avatar}"),
                        fit: BoxFit.fitHeight),
                    borderRadius: BorderRadius.circular(15.h)),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10.w),
                    width: 210.w,
                    child: reusableSubtitleText(item.name ?? "",
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.w700,
                        fontSize: 12.sp),
                  ),
                  Container(
                    width: 210.w,
                    margin: EdgeInsets.only(left: 10.w, top: 10.h),
                    child: reusableSubtitleText(item.last_msg ?? "",
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.normal,
                        fontSize: 10.sp),
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            width: 5,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  item.last_time == null
                      ? ""
                      : duTimeLineFormat(
                          item.last_time!.toDate(),
                        ),
                  style: TextStyle(
                      fontSize: 8.sp,
                      color: AppColors.primaryThirdElementText,
                      fontWeight: FontWeight.normal),
                ),
              ),
              item.msg_num == 0
                  ? Container()
                  : Container(
                      height: 15.h,
                      decoration: BoxDecoration(
                        color: AppColors.primaryElement,
                        borderRadius: BorderRadius.circular(5.h),
                      ),
                      child: Text(
                        "${item.msg_num}",
                        style: TextStyle(
                            color: AppColors.primaryElementText,
                            fontWeight: FontWeight.normal),
                      ),
                    )
            ],
          )
        ],
      ),
    ),
  );
}

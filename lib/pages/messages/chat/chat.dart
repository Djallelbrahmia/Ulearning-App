import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learn_teacher_bloc/common/values/colors.dart';
import 'package:learn_teacher_bloc/common/widgets/text_field.dart';
import 'package:learn_teacher_bloc/pages/messages/chat/bloc/chat_events.dart';
import 'package:learn_teacher_bloc/pages/messages/chat/bloc/chat_states.dart';
import 'package:learn_teacher_bloc/pages/messages/chat/bloc/check_blocs.dart';
import 'package:learn_teacher_bloc/pages/messages/chat/chat_controller.dart';
import 'package:learn_teacher_bloc/pages/messages/chat/widgets/chat_widgets.dart';
import 'package:learn_teacher_bloc/pages/sign-in/widgets/app_bar.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late ChatController _chatController;
  @override
  void didChangeDependencies() {
    _chatController = ChatController(context: context);
    _chatController.init();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar("Chat"),
        body: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 120.h),
                    child: CustomScrollView(
                      controller: _chatController.appScrollController,
                      reverse: true,
                      slivers: [
                        SliverPadding(
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                                childCount: state.msgcontentList.length,
                                (context, index) {
                              return _chatController.userProfile?.token ==
                                      state.msgcontentList[index].token
                                  ? chatRightWidget(state.msgcontentList[index])
                                  : chatLefttWidget(
                                      state.msgcontentList[index]);
                            }),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                    bottom: 0.h,
                    child: Container(
                      color: AppColors.primaryBackground,
                      width: 360.w,
                      constraints:
                          BoxConstraints(maxHeight: 100.h, minHeight: 70.h),
                      padding: EdgeInsets.only(
                          left: 20.w, right: 20.w, bottom: 0.h, top: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 270.w,
                            constraints: BoxConstraints(
                                maxHeight: 100.h, minHeight: 70.h),
                            decoration: BoxDecoration(
                                color: AppColors.primaryBackground,
                                border: Border.all(
                                    color: AppColors.primaryFourThElementText),
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              children: [
                                Container(
                                  width: 220.w,
                                  constraints: BoxConstraints(
                                      maxHeight: 100.h, minHeight: 30.h),
                                  padding: EdgeInsets.only(left: 5.w),
                                  child: appTextField(
                                      "Message", "text", (data) {},
                                      maxLines: 3,
                                      controller: _chatController
                                          .textEditingController),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    context.read<ChatBloc>().add(
                                        TriggerMoreStatus(!state.more_status));
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 40.w,
                                    height: 40.h,
                                    child: Image.asset("assets/icons/05.png"),
                                  ),
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _chatController.sendMessage();
                            },
                            child: Container(
                              width: 40.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                  color: AppColors.primaryElement,
                                  borderRadius: BorderRadius.circular(40.w),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        offset: const Offset(1, 1))
                                  ]),
                              child: Image.asset("assets/icons/send2.png"),
                            ),
                          )
                        ],
                      ),
                    )),
                state.more_status
                    ? Positioned(
                        right: 86.w,
                        bottom: 70.h,
                        height: 100.h,
                        width: 40.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            chatFileButtons("assets/icons/file.png"),
                            chatFileButtons("assets/icons/photo.png"),
                          ],
                        ))
                    : Container()
              ],
            );
          },
        ),
      ),
    );
  }
}

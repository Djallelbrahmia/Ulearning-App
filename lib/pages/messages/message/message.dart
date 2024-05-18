import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learn_teacher_bloc/common/values/colors.dart';
import 'package:learn_teacher_bloc/pages/messages/message/cubit/message_cubit.dart';
import 'package:learn_teacher_bloc/pages/messages/message/cubit/message_states.dart';
import 'package:learn_teacher_bloc/pages/messages/message/message_controller.dart';
import 'package:learn_teacher_bloc/pages/messages/message/widgets/message_widget.dart';
import 'package:learn_teacher_bloc/pages/sign-in/widgets/app_bar.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  late MessagesController _messagesController;
  @override
  void didChangeDependencies() {
    _messagesController = MessagesController(context: context);
    _messagesController.init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: BlocBuilder<MessageCubits, MessageState>(
          builder: (context, state) {
            return Scaffold(
                backgroundColor: Colors.white,
                appBar: buildAppBar("Messages"),
                body: state.loadStatus
                    ? const Center(
                        child: CircularProgressIndicator(
                            color: AppColors.primaryElement),
                      )
                    : CustomScrollView(
                        slivers: [
                          SliverPadding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25.w, vertical: 0.h),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                childCount: state.message.length,
                                (context, index) {
                                  var item = state.message.elementAt(index);
                                  return buildChatList(
                                      context, item, _messagesController);
                                },
                              ),
                            ),
                          ),
                        ],
                      ));
          },
        ),
      ),
    );
  }
}

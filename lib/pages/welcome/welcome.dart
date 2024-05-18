import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learn_teacher_bloc/common/values/colors.dart';
import 'package:learn_teacher_bloc/common/values/constants.dart';
import 'package:learn_teacher_bloc/global.dart';
import 'package:learn_teacher_bloc/pages/welcome/bloc/welcome_bloc.dart';
import 'package:learn_teacher_bloc/pages/welcome/bloc/welcome_events.dart';
import 'package:learn_teacher_bloc/pages/welcome/bloc/welcome_states.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        body: BlocBuilder<WelcomeBloc, WelcomeState>(
          builder: (context, state) {
            return Container(
              margin: EdgeInsets.only(top: 34.h),
              width: 375.w,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  PageView(
                    controller: pageController,
                    onPageChanged: (index) {
                      state.page = index;
                      BlocProvider.of<WelcomeBloc>(context)
                          .add(WelcomeEvents());
                    },
                    children: [
                      _page(
                          1,
                          context,
                          "Next",
                          "First See Learning",
                          "Forget about a for of paper all knowledge in one learning",
                          'assets/images/reading.png'),
                      _page(
                          2,
                          context,
                          "Next",
                          "Connect With Everyone",
                          "Always keep in touch with your tutor & friends , lets get connected",
                          'assets/images/boy.png'),
                      _page(
                          3,
                          context,
                          "Get Started",
                          "Always Fascinated learning",
                          "Anywhere , anytime , The time is at your discretion so study whenever you want ",
                          'assets/images/man.png')
                    ],
                  ),
                  Positioned(
                    bottom: 100.h,
                    child: DotsIndicator(
                      position: state.page.toDouble(),
                      dotsCount: 3,
                      mainAxisAlignment: MainAxisAlignment.center,
                      decorator: DotsDecorator(
                          color: AppColors.primaryThirdElementText,
                          activeColor: AppColors.primaryElement,
                          size: const Size.square(8.0),
                          activeSize: const Size(18, 8),
                          activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _page(int index, BuildContext context, String buttonName, String title,
      String subTitle, String imagePath) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            width: 345.w,
            height: 345.w,
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            child: Text(
              title,
              style: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.normal),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            child: Text(
              subTitle,
              style: TextStyle(
                  color: AppColors.primarySecondaryElementText,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (index < 3) {
                pageController.animateToPage(index,
                    duration: Duration(microseconds: 500),
                    curve: Curves.decelerate);
              } else {
                Global.storageService
                    .setBool(AppConstants.STORAGE_DEVICE_OPEN_FIRST_TIME, true);
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("/signIn", (route) => false);
              }
            },
            child: Container(
              margin: EdgeInsets.only(
                top: 100.w,
              ),
              width: 325.w,
              height: 50.h,
              decoration: BoxDecoration(
                  color: AppColors.primaryElement,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.w),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color:
                            AppColors.primaryThirdElementText.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(
                          0,
                          1,
                        ))
                  ]),
              child: Center(
                  child: Text(buttonName,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal))),
            ),
          )
        ],
      ),
    );
  }
}

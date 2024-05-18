import 'package:flutter/material.dart';
import 'package:learn_teacher_bloc/common/widgets/base_text_widget.dart';

AppBar buildBaseAppBar(String title) {
  return AppBar(
    title: reusableSubtitleText(title),
  );
}

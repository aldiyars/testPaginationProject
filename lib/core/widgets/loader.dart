import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_flutter_app/core/constants/styles.dart';

class LoaderWidget extends StatelessWidget {
  final bool isPop;

  // ignore: use_key_in_widget_constructors
  const LoaderWidget({this.isPop = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          height: 60,
          width: 60,
          padding: EdgeInsets.all(15.sp),
          decoration: BoxDecoration(color: isPop ? AppTheme.kWhiteColor : Colors.transparent, borderRadius: BorderRadius.circular(10)),
          child: Platform.isIOS
              ? CupertinoActivityIndicator(
                  radius: 10.sp,
                )
              : CircularProgressIndicator(
                  strokeWidth: 5.0.sp,
                  // color: Styles.primaryColor,
                  backgroundColor: AppTheme.kWhiteColor,
                  // valueColor:
                )),
    );
  }
}

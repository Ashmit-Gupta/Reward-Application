import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import '../res/app_color.dart';
import 'dart:math' as math;

class Utils {
  static void fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.all(15),
        message: message,
        backgroundColor: AppColors.flushBarErrorMessageColor,
        duration: Duration(seconds: 3),
        reverseAnimationCurve: Curves.easeInOut,
        messageColor: AppColors.blackColor,
        flushbarPosition: FlushbarPosition.TOP,
        positionOffset: 20,
        icon: Icon(
          Icons.error,
          size: 28,
          color: AppColors.whiteColor,
        ),
      )..show(context),
    );
  }

  static void flushBarSuccessfullMessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.all(15),
        message: message,
        backgroundColor: AppColors.flushBarSuccessfullMessageColor,
        duration: Duration(seconds: 3),
        reverseAnimationCurve: Curves.easeInOut,
        messageColor: AppColors.blackColor,
        flushbarPosition: FlushbarPosition.TOP,
        positionOffset: 20,
        icon: Icon(
          Icons.check,
          size: 28,
          color: AppColors.whiteColor,
        ),
      )..show(context),
    );
  }

  static void dialogBox(BuildContext context, VoidCallback onPressOk,
      VoidCallback onPressCancel, String title, String desc) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.rightSlide,
      title: title,
      desc: desc,
      btnCancelOnPress: onPressCancel,
      btnOkOnPress: onPressOk,
    ).show();
  }

  static Color getRandomColor() {
    final random = math.Random();
    return Color.fromRGBO(
      random.nextInt(150), // Red
      random.nextInt(150), // Green
      random.nextInt(150), // Blue
      1, // Opacity (1 = fully opaque)
    );
  }
}

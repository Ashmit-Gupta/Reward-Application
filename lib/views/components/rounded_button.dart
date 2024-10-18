import 'package:flutter/material.dart';

import '../../res/app_color.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;

  const RoundedButton({
    super.key,
    required this.title,
    this.loading = false,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading ? null : onPress, // Disable button when loading
      child: Container(
        height: 40,
        width:
            MediaQuery.of(context).size.width * 0.8, // Make the width dynamic
        decoration: BoxDecoration(
          color: loading
              ? Colors.grey // Show grey color when loading
              : AppColors.roundedButtonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child:
              // loading
              //     ? CircularProgressIndicator(
              //         color: AppColors.progressBarColor,
              //       )
              Text(
            title,
            style: TextStyle(color: AppColors.whiteColor),
          ),
        ),
      ),
    );
  }
}

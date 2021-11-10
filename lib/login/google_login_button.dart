import 'package:flutter/material.dart';
import 'package:transcribe/theme/app_images.dart';

class GoogleLoginButton extends StatelessWidget {
  final VoidCallback onTap;
  const GoogleLoginButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 320,
        decoration: BoxDecoration(
          // color: AppColors.shape,
          borderRadius: BorderRadius.circular(5),
          border: const Border.fromBorderSide(
            BorderSide(
                // color: AppColors.stroke,
                ),
          ),
        ),
        child: Row(
          children: [
            Expanded(flex: 1, child: Image.asset(AppImages.google)),
            const Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  'Select your GOOGLE account',
                  // style: AppTextStyles.buttonBoldGrey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

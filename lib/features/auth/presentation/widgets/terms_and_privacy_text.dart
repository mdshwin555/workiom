import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/app_colors.dart';

class TermsAndPrivacyText extends StatelessWidget {
  const TermsAndPrivacyText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.5.h),
      child: Text.rich(
        TextSpan(
          text: 'By signing up, you agree ',
          children: [
            TextSpan(
              text: 'Terms Of Service',
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w500,
              ),
            ),
            const TextSpan(text: '\nAnd '),
            TextSpan(
              text: 'Privacy Policy',
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        style: TextStyle(
          fontSize: 14.5.sp,
          color: AppColors.greyText,
          height: 1.5,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/app_colors.dart';

class HeaderSection extends StatelessWidget {
  final String title;
  final String subtitle;

  const HeaderSection({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 3.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.greyText,
            ),
          ),
        ],
      ),
    );
  }
}

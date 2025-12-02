import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../widgets/footer_brand.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Thank you for choosing Workiom ',
                            ),
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Image.asset(
                                AppImages.logo,
                                width: 22.sp,
                                height: 22.sp,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: FooterBrand(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
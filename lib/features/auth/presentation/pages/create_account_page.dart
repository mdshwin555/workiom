import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../widgets/auth_top_bar.dart';
import '../widgets/sign_in_button.dart';
import '../widgets/language_selector_row.dart';
import '../widgets/footer_brand.dart';
import '../widgets/header_section.dart';
import '../widgets/terms_and_privacy_text.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AuthTopBar(title: 'Sign in'),
              HeaderSection(
                title: 'Create your free account',
                subtitle: "Let's start an amazing journey! 👋",
              ),
              SizedBox(height: 15.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SignInButton(
                        text: 'Continue with Google',
                        imagePath: AppImages.googleIcon,
                        onPressed: () {},
                      ),
                      SizedBox(height: 3.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
                        child: Text(
                          'Or',
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: AppColors.greyText
                          ),
                        ),
                      ),
                      SizedBox(height: 3.h),
                      SignInButton(
                        text: 'Continue with email',
                        showTrailingIcon: true,
                        onPressed: () => context.push('/enter-password'),
                      ),
                      const TermsAndPrivacyText(),
                    ],
                  ),
                ),
              ),
              const LanguageSelectorRow(),
              const FooterBrand(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/custom_snack_bar.dart';
import '../widgets/auth_top_bar.dart';
import '../widgets/header_section.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/footer_brand.dart';
import '../widgets/sign_in_button.dart';
import '../../logic/tenant_form_cubit/tenant_form_cubit.dart';

class EnterCompanyPage extends StatelessWidget {
  final String email;
  final String password;
  final int editionId;

  EnterCompanyPage({
    super.key,
    required this.email,
    required this.password,
    required this.editionId,
  })  : workspaceController = TextEditingController(),
        firstNameController = TextEditingController(),
        lastNameController = TextEditingController();

  final TextEditingController workspaceController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

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
              const AuthTopBar(),
              HeaderSection(
                title: 'Enter your company name',
                subtitle: "Let's start an amazing journey! 👋",
              ),
              SizedBox(height: 10.h),

              Expanded(
                child: SingleChildScrollView(
                  child: BlocConsumer<TenantFormCubit, TenantFormState>(
                    listener: (context, state) {
                      if (state.errorMessage != null) {
                        CustomSnackBar.show(
                          context,
                          message: state.errorMessage!,
                          isError: true,
                        );
                      }

                      if (!state.isSubmitting &&
                          state.isTenantAvailable == true &&
                          state.errorMessage == null) {

                        context.go('/success');
                      }
                    },
                    builder: (context, state) {
                      final cubit = context.read<TenantFormCubit>();

                      final bool canTapButton = state.tenantName.isNotEmpty &&
                          state.isTenantNameFormatValid &&
                          state.firstName.isNotEmpty &&
                          state.isFirstNameValid &&
                          state.lastName.isNotEmpty &&
                          state.isLastNameValid &&
                          !state.isSubmitting;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AuthTextField(
                            label: 'Your company or team name',
                            hintText: 'Workspace name*',
                            fieldType: AuthFieldType.workspace,
                            controller: workspaceController,
                            prefix: Icon(
                              Icons.groups_outlined,
                              size: 18.sp,
                              color: AppColors.greyText,
                            ),
                            onChanged: cubit.onTenantNameChanged,
                          ),
                          SizedBox(height: 3.h),

                          AuthTextField(
                            label: 'Your first name',
                            hintText: 'Enter your First name',
                            fieldType: AuthFieldType.text,
                            controller: firstNameController,
                            prefix: const Icon(Icons.notes_outlined),
                            onChanged: cubit.onFirstNameChanged,
                          ),
                          SizedBox(height: 3.h),

                          AuthTextField(
                            label: 'Your last name',
                            hintText: 'Enter your Last name',
                            fieldType: AuthFieldType.text,
                            controller: lastNameController,
                            prefix: const Icon(Icons.notes_outlined),
                            onChanged: cubit.onLastNameChanged,
                          ),

                          SizedBox(height: 4.h),

                          SignInButton(
                            text: 'Create Workspace',
                            showTrailingIcon: true,
                            isLoading: state.isSubmitting,
                            onPressed: canTapButton
                                ? () {
                              FocusScope.of(context).unfocus();
                              cubit.createWorkspace(
                                email: email,
                                password: password,
                                editionId: editionId,
                              );
                            }
                                : null,
                          ),

                          SizedBox(height: 3.h),
                        ],
                      );
                    },
                  ),
                ),
              ),

              const FooterBrand(),
            ],
          ),
        ),
      ),
    );
  }
}
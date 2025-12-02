import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/password_complexity_model.dart';
import '../../data/services/auth_api_service.dart';

part 'password_state.dart';

class PasswordCubit extends Cubit<PasswordState> {
  PasswordCubit(this._apiService) : super(const PasswordState());

  final AuthApiService _apiService;

  Future<void> loadPasswordRules() async {
    try {
      emit(
        state.copyWith(
          isLoading: true,
          removeError: true,
        ),
      );

      final rules = await _apiService.getPasswordComplexitySetting();

      final editionId = await _apiService.getFirstRegistrableEdition();

      emit(
        state.copyWith(
          rules: rules,
          editionId: editionId,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: 'Failed to load configuration',
        ),
      );
    }
  }

  void onEmailChanged(String value) {
    final trimmed = value.trim();
    final isValid = _validateEmail(trimmed);

    emit(
      state.copyWith(
        email: trimmed,
        isEmailValid: isValid,
      ),
    );
  }

  void onPasswordChanged(String value) {
    final rules = state.rules;
    final pwd = value;

    bool hasMinLength = false;
    bool hasUppercase = false;

    if (rules != null) {
      if (rules.requiredLength > 0) {
        hasMinLength = pwd.length >= rules.requiredLength;
      }
      if (rules.requireUppercase) {
        hasUppercase = RegExp(r'[A-Z]').hasMatch(pwd);
      }
    } else {
      hasUppercase = RegExp(r'[A-Z]').hasMatch(pwd);
    }

    final hasDigit = RegExp(r'\d').hasMatch(pwd);
    final hasLower = RegExp(r'[a-z]').hasMatch(pwd);
    final hasSpecial = RegExp(r'[^A-Za-z0-9]').hasMatch(pwd);

    bool isValid = true;

    if (rules != null) {
      if (rules.requiredLength > 0 && !hasMinLength) isValid = false;
      if (rules.requireUppercase && !hasUppercase) isValid = false;
      if (rules.requireDigit && !hasDigit) isValid = false;
      if (rules.requireLowercase && !hasLower) isValid = false;
      if (rules.requireNonAlphanumeric && !hasSpecial) isValid = false;
    } else {
      isValid = pwd.length >= 7;
    }

    emit(
      state.copyWith(
        password: pwd,
        hasMinLength: hasMinLength,
        hasUppercase: hasUppercase,
        isPasswordValid: isValid,
      ),
    );
  }

  void togglePasswordVisibility() {
    emit(
      state.copyWith(
        isPasswordObscured: !state.isPasswordObscured,
      ),
    );
  }

  bool _validateEmail(String email) {
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return regex.hasMatch(email);
  }
}
part of 'password_cubit.dart';

class PasswordState {
  final String email;
  final String password;
  final PasswordComplexity? rules;
  final int? editionId;
  final bool hasMinLength;
  final bool hasUppercase;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isLoading;
  final String? error;
  final bool isPasswordObscured;

  const PasswordState({
    this.email = '',
    this.password = '',
    this.rules,
    this.editionId,
    this.hasMinLength = false,
    this.hasUppercase = false,
    this.isEmailValid = false,
    this.isPasswordValid = false,
    this.isLoading = false,
    this.error,
    this.isPasswordObscured = true,
  });

  double get strength {
    if (rules == null || password.isEmpty) return 0;

    int score = 0;
    int total = 0;

    if (rules!.requiredLength > 0) {
      total++;
      if (hasMinLength) score++;
    }
    if (rules!.requireUppercase) {
      total++;
      if (hasUppercase) score++;
    }
    if (rules!.requireDigit) {
      total++;
      if (RegExp(r'\d').hasMatch(password)) score++;
    }
    if (rules!.requireLowercase) {
      total++;
      if (RegExp(r'[a-z]').hasMatch(password)) score++;
    }
    if (rules!.requireNonAlphanumeric) {
      total++;
      if (RegExp(r'[^A-Za-z0-9]').hasMatch(password)) score++;
    }

    if (total == 0) return 0;
    return score / total;
  }

  bool get canSubmit => isEmailValid && isPasswordValid && !isLoading && editionId != null;

  PasswordState copyWith({
    String? email,
    String? password,
    PasswordComplexity? rules,
    int? editionId,
    bool? hasMinLength,
    bool? hasUppercase,
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isLoading,
    String? error,
    bool? isPasswordObscured,
    bool removeError = false,
  }) {
    return PasswordState(
      email: email ?? this.email,
      password: password ?? this.password,
      rules: rules ?? this.rules,
      editionId: editionId ?? this.editionId,
      hasMinLength: hasMinLength ?? this.hasMinLength,
      hasUppercase: hasUppercase ?? this.hasUppercase,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isLoading: isLoading ?? this.isLoading,
      error: removeError ? null : (error ?? this.error),
      isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,
    );
  }
}
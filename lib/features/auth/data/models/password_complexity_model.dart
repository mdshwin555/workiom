class PasswordComplexity {
  final bool requireDigit;
  final bool requireLowercase;
  final bool requireUppercase;
  final bool requireNonAlphanumeric;
  final int requiredLength;

  const PasswordComplexity({
    required this.requireDigit,
    required this.requireLowercase,
    required this.requireUppercase,
    required this.requireNonAlphanumeric,
    required this.requiredLength,
  });

  factory PasswordComplexity.fromJson(Map<String, dynamic> json) {
    return PasswordComplexity(
      requireDigit: json['requireDigit'] as bool? ?? false,
      requireLowercase: json['requireLowercase'] as bool? ?? false,
      requireUppercase: json['requireUppercase'] as bool? ?? false,
      requireNonAlphanumeric:
      json['requireNonAlphanumeric'] as bool? ?? false,
      requiredLength: json['requiredLength'] as int? ?? 0,
    );
  }
}

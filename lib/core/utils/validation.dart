import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:linkify/core/constants/constants.dart';

class ValidationUtil {
  static ValidationResult validateString(
    String? input, {
    int maxLength = 1000,
    int minLength = 3,
    FocusNode? node,
  }) {
    if (input == null ||
        input.trim().isEmpty ||
        input.trim().length < minLength ||
        input.length > maxLength) {
      node?.requestFocus();
      return ValidationResult.error(Constants.invalidEntry.tr());
    }
    return ValidationResult.success();
  }

  static ValidationResult validateEmail(String? input, {FocusNode? node}) {
    if (!isValidEmail(input)) {
      node?.requestFocus();
      return ValidationResult.error(Constants.invalidEmail.tr());
    }
    return ValidationResult.success();
  }

  static ValidationResult validateWebsite(String? input) {
    if (input == null || input.length < 4) {
      return ValidationResult.error(Constants.invalidUrl.tr());
    }

    var isValidUrl = Uri.tryParse(input)?.hasScheme ?? false;
    if (!isValidUrl) {
      return ValidationResult.error(Constants.invalidUrl.tr());
    }

    return ValidationResult.success();
  }

  static ValidationResult validateNumber(
    String? input, {
    int minLength = 3,
  }) {
    if (input == null ||
        input.trim().isEmpty ||
        input.trim().length < minLength ||
        input.length > 20) {
      return ValidationResult.error(Constants.invalidNumber.tr());
    }

    if (!input.isNumericOnly) {
      return ValidationResult.error(Constants.invalidNumber.tr());
    }

    if ((double.tryParse(input) ?? 0) <= 0) {
      return ValidationResult.error(Constants.mustBePositive.tr());
    }

    return ValidationResult.success();
  }

  static ValidationResult validatePhoneNumber(String? input) {
    if (input == null || input.trim().isEmpty) {
      return ValidationResult.error(Constants.invalidPhone.tr());
    }

    if (input.startsWith('0')) {
      return ValidationResult.error(Constants.invalidPhone.tr());
    }

    return ValidationResult.success();
  }

  static String arabicNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(arabic[i], english[i]);
    }
    return input;
  }

  static ValidationResult validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return ValidationResult.error(Constants.requiredField.tr());
    }

    if (value.length < 10) {
      return ValidationResult.error(Constants.passwordLength.tr());
    }

    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (!regex.hasMatch(value)) {
      return ValidationResult.error(Constants.passwordComplexity.tr());
    }

    return ValidationResult.success();
  }

  static ValidationResult validateConfirmPassword(
      String? input, String password) {
    if (input == null || input != password) {
      return ValidationResult.error(Constants.passwordMismatch.tr());
    }
    return ValidationResult.success();
  }

  static bool isValidEmail(String? email) {
    if (email == null || email.isEmpty) return false;
    return RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
        .hasMatch(email);
  }

  static ValidationResult validateRating(int input) {
    if (input == 0) {
      return ValidationResult.error(Constants.chooseRating.tr());
    }
    return ValidationResult.success();
  }
}

class ValidationResult {
  final bool isSuccess;
  final String? errorMessage;

  ValidationResult._(this.isSuccess, this.errorMessage);

  factory ValidationResult.success() => ValidationResult._(true, null);
  factory ValidationResult.error(String message) =>
      ValidationResult._(false, message);

  bool get isValid => isSuccess;
  String? get error => errorMessage;

  bool toBoolean() => isSuccess;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ValidationResult &&
        other.isSuccess == isSuccess &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => isSuccess.hashCode ^ errorMessage.hashCode;
}

extension StringExtensions on String {
  bool get isNumericOnly {
    if (isEmpty) return false;
    return RegExp(r'^[0-9]+$').hasMatch(this);
  }
}

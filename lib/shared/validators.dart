import '../generated/l10n.dart';

class Validators {
  static String? cantBeEmpty(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.current.cantBeEmpty;
    }
    return null;
  }

  static String? numericalFieldValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.current.cantBeEmpty;
    }

    if (!AppRegex.numericalField.hasMatch(value)) {
      return AppLocalizations.current.mustBeANumber;
    }
    return null;
  }

  static String? usernameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.current.cantBeEmpty;
    }

    if (value.length < 3) {
      return AppLocalizations.current.atLeast3Characters;
    }

    if (value.length > 20) {
      return AppLocalizations.current.lessThan20Characters;
    }

    if (!AppRegex.username.hasMatch(value)) {
      return AppLocalizations.current.notContainSpecialCharacters;
    }
    return null;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.current.cantBeEmpty;
    }

    if (!AppRegex.email.hasMatch(value)) {
      return AppLocalizations.current.emailNotValid;
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.current.cantBeEmpty;
    }

    if (value.length < 8) {
      return AppLocalizations.current.atLeast8Characters;
    }

    if (!AppRegex.password.hasMatch(value)) {
      return AppLocalizations.current.passwordNotValid;
    }
    return null;
  }
}

class AppRegex {
  static final RegExp numericalField = RegExp(
    r'^[0-9]+$',
  );
  static final RegExp username = RegExp(r'^[a-zA-Z0-9_]+$');

  static final RegExp email = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static final RegExp password = RegExp(
    r'^(?=.*[A-Z])(?=.*[!@#$%^&*(),.?":{}|<>])[A-Za-z0-9!@#$%^&*(),.?":{}|<>]{8,}$',
  );
}

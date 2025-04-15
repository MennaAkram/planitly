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
      return AppLocalizations.current.invalidUsername;
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
      return AppLocalizations.current.invalidPasssword;
    }
    return null;
  }
}

class AppRegex {
  static final RegExp numericalField = RegExp(
    r'^[0-9]+$',
  );
  static final RegExp username = RegExp(r'^(?=.*[A-Za-z])[A-Za-z0-9_.-]+$');

  static final RegExp email = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$',
  );

  static final RegExp password = RegExp(
    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[^A-Za-z0-9]).{8,}$',
  );

}

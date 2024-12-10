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

}

class AppRegex {
    static final RegExp numericalField = RegExp(
    r'^[0-9]+$',
  );
}

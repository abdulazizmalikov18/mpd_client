import 'package:mpd_client/core/extension/context_ext.dart';
import 'package:mpd_client/provider/language.dart';

abstract class Validators {
  static String? empty(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return context.l10n.register_error_code_password_cant_empty;
    }

    return null;
  }

  static String? cardNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Must not be empty';
    } else if (value.length < 19) {
      return 'It is not valid card number';
    }

    return null;
  }

  static String? expiryNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Must not be empty';
    } else if (value.length < 5) {
      return 'It is not valid expiry number';
    }

    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Can\'t be empty';
    }
    if (value.length < 14) {
      return 'It is not valid phone number';
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Can\'t be empty';
    }

    if (value.length < 6) {
      return 'This password is too short. It must contain at least 6 characters.';
    }

    // if (value.length < 8) {
    //   return 'This password is too short. It must contain at least 8 characters.';
    // }
    return null;
  }

  static String? createPassword(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return context.l10n.register_error_code_password_cant_empty;
    }

    if (value.length < 8) {
      return context.l10n.register_error_code_password_mistake;
    }
    return null;
  }

  static String? username(String? value, BuildContext context) {
    // String pattern = r'(^[-a-zA-Z0-9_]+$';
    // RegExp regExp = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return context.l10n.register_error_code_password_cant_empty;
    }
    if (value.length < 6) {
      return context.l10n.register_error_code_text_short;
    }
    // if (!regExp.hasMatch(value)) {
    //   return 'Invalid username';
    // }
    return null;
  }

  static String? usernameOrPhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Can\'t be empty';
    }

    if (!value.contains(RegExp(r'[a-zA-Z]'), 0) && value.length < 19) {
      return 'Invalid phone number';
    }

    if (value.length < 4) {
      return 'Must be at least 4 character';
    }

    return null;
  }

  static String? passportSTIR(String? value) {
    if (value == null || value.isEmpty) {
      return 'Can\'t be empty!';
    }
    if (value.length != 18) {
      return 'Must be 14 character!';
    }

    return null;
  }
}

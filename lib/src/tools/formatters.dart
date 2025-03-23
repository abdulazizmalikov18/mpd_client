import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Formatters {
  static MaskTextInputFormatter pinFormatter = MaskTextInputFormatter(
      mask: '####',
      filter: {'#': RegExp(r'[\+0-9]')},
      type: MaskAutoCompletionType.lazy);
  static MaskTextInputFormatter phoneFormatter = MaskTextInputFormatter(
    mask: '+998 (##) ###-##-##',
    filter: {'#': RegExp(r'[\+0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
  static final cardNumberFormatter = MaskTextInputFormatter(
    mask: '#### #### #### ####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  static final dateFormatter = MaskTextInputFormatter(
    mask: "##/##/####",
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  static final cardExpirationDateFormatter = MaskTextInputFormatter(
    mask: '##/##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
  static final loginFormat = FilteringTextInputFormatter.allow(
    RegExp(r'[a-z0-9]'),
  );
  static final pnflFormat = FilteringTextInputFormatter.allow(
    RegExp(r'[+0-9]'),
  );
  static final innFormat = MaskTextInputFormatter(
    mask: '#########',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
  static final lotinFormat = FilteringTextInputFormatter.allow(
    RegExp(r'[a-zA-Z0-9]'),
  );
  static final lotinFormat2 = FilteringTextInputFormatter.allow(
    RegExp(r'[a-zA-Z0-9 ]'),
  );

  static String capitalize(String value) {
    if (value.isNotEmpty) {
      var result = value[0].toUpperCase();
      bool cap = true;
      for (int i = 1; i < value.length; i++) {
        if (value[i - 1] == " " && cap == true) {
          result = result + value[i].toUpperCase();
        } else {
          result = result + value[i];
          cap = false;
        }
      }
      return result;
    } else {
      return value;
    }
  }
}

class ThousandsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }
    final int selectionIndexFromTheRight =
        newValue.text.length - newValue.selection.end;
    final newText = newValue.text.replaceAll(' ', ''); // Remove existing spaces
    final formattedText =
        _addSpacesToNumericString(newText); // Function to add spaces
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(
        offset: formattedText.length - selectionIndexFromTheRight,
      ),
    );
  }

  String _addSpacesToNumericString(String str) {
    final RegExp regExp = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    return str.replaceAllMapped(regExp, (Match match) => '${match[1]} ').trim();
  }
}

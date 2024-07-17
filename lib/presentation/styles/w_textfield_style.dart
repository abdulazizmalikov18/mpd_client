import 'package:flutter/material.dart';

class WTextFieldStyle extends ThemeExtension<WTextFieldStyle> {
  final Color fillColor;
  final Color borderColor;

  const WTextFieldStyle({required this.fillColor, required this.borderColor});

  @override
  ThemeExtension<WTextFieldStyle> copyWith({Color? fillColor, Color? borderColor}) => WTextFieldStyle(fillColor: fillColor ?? this.fillColor, borderColor: borderColor ?? this.borderColor);

  @override
  ThemeExtension<WTextFieldStyle> lerp(ThemeExtension<WTextFieldStyle>? other, double t) {
    if (other is! WTextFieldStyle) {
      return this;
    }
    return WTextFieldStyle(fillColor: Color.lerp(fillColor, other.fillColor, t) ?? fillColor, borderColor: Color.lerp(borderColor, other.borderColor, t) ?? borderColor);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mpd_client/presentation/styles/colors.dart';

class WTextField extends StatefulWidget {
  final TextEditingController? controller;
  final ValueChanged<String> onChanged;
  final VoidCallback? onTap;
  final EdgeInsets contentPadding;
  final Widget? prefix;
  final Widget? prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffix;
  final Widget? suffixIcon;
  final double prefixMaxWidth;
  final double suffixMaxWidth;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final TextStyle? counterStyle;
  final String? hintText;
  final bool hasError;
  final bool isObscure;
  final InputDecoration? inputDecoration;
  final TextInputType? keyboardType;
  final String title;
  final String greyTexts;
  final double? height;
  final double? width;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool autoFocus;
  final FocusNode? focusNode;
  final TextAlignVertical? textAlignVertical;
  final bool? expands;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final bool showCount;
  final TextInputAction? textInputAction;
  final Color fillColor;
  final Color cursorColor;
  final Color focusColor;
  final Color enabledBorder;
  final bool readOnly;
  final String? Function(String?)? validator;
  final Function(String)? onSubmitted;
  final Function()? onEditingComplete;
  final bool hasSuffixIcon;
  final String? counterText;
  final bool enabled;
  final double? horizontal;
  final double? borderRadius;
  final Color borderColor;
  final TextCapitalization textCapitalization;

  const WTextField({
    this.autoFocus = false,
    this.hasSuffixIcon = true,
    this.showCount = false,
    this.readOnly = false,
    this.enabled = true,
    this.focusNode,
    this.borderRadius = 12,
    this.textInputAction,
    this.maxLengthEnforcement,
    this.validator,
    this.onEditingComplete,
    this.counterText = '',
    this.counterStyle,
    this.controller,
    required this.onChanged,
    this.prefix,
    this.prefixIcon,
    this.title = '',
    this.greyTexts = '',
    this.contentPadding = const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    this.inputFormatters,
    this.suffix,
    this.suffixIcon,
    this.prefixMaxWidth = 60,
    this.suffixMaxWidth = 40,
    this.hintStyle,
    this.hintText,
    this.style,
    this.isObscure = false,
    this.hasError = false,
    this.inputDecoration,
    this.keyboardType,
    this.height,
    this.width,
    this.maxLines = 1,
    this.maxLength,
    this.textAlignVertical,
    this.expands,
    this.fillColor = backGroundColor,
    this.cursorColor = primary,
    this.focusColor = Colors.transparent,
    this.enabledBorder = whiteSmoke,
    this.minLines,
    this.horizontal,
    super.key,
    this.onTap,
    this.onSubmitted,
    this.borderColor = greyText,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  State<WTextField> createState() => _WTextFieldState();
}

class _WTextFieldState extends State<WTextField> with SingleTickerProviderStateMixin {
  bool isObscure = false;
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    animationController.forward();

    super.initState();
    isObscure = widget.isObscure;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      textCapitalization: widget.textCapitalization,
      onEditingComplete: widget.onEditingComplete,
      onTap: widget.onTap ?? () {},
      onSubmitted: (value) {},
      enabled: widget.enabled,
      controller: widget.controller,
      readOnly: widget.readOnly,
      expands: widget.expands ?? false,
      maxLengthEnforcement: widget.maxLengthEnforcement,
      textAlignVertical: widget.textAlignVertical,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      autofocus: widget.autoFocus,
      onChanged: widget.onChanged,
      textInputAction: widget.textInputAction,
      style: widget.style ??
          Theme.of(context).textTheme.displayLarge!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: white.withOpacity(.5),
              ),
      inputFormatters: widget.inputFormatters,
      maxLength: widget.maxLength,
      maxLines: widget.isObscure ? 1 : widget.maxLines,
      minLines: widget.minLines,
      cursorColor: widget.cursorColor,
      cursorWidth: 1,
      decoration: widget.inputDecoration ??
          InputDecoration(
            constraints: BoxConstraints(
              maxHeight: widget.height ?? 48,
              maxWidth: widget.width ?? double.infinity,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius!),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius!),
              borderSide: const BorderSide(color: red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius!),
              borderSide: const BorderSide(color: red),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius!),
              borderSide: BorderSide(
                color: widget.hasError ? red : widget.borderColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius!),
              borderSide: BorderSide(color: widget.hasError ? red : widget.borderColor),
            ),
            hintText: widget.hintText,
            hintStyle: widget.hintStyle ??
                Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: widget.hasError ? red : white.withOpacity(.5),
                    ),
            contentPadding: widget.contentPadding,
            suffixIconConstraints: BoxConstraints(maxWidth: widget.suffixMaxWidth),
            suffixIcon: widget.hasSuffixIcon
                ? widget.suffixIcon ?? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                        if (isObscure) {
                          animationController.forward();
                        } else {
                          animationController.reverse();
                        }
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        alignment: Alignment.center,
                        child: Center(
                          child: AnimatedBuilder(
                            animation: animationController,
                            // child: SvgPicture.asset(AppIcons.eye),
                            builder: (context, child) => SizedBox(
                              width: 24,
                              height: 24,
                              child: CustomPaint(
                                // foregroundPainter: StrokePaint(animationController.value),
                                child: child,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
            suffix: widget.suffix,
            prefix: widget.prefix,
            fillColor: widget.fillColor,
            filled: true,
            prefixIconConstraints: BoxConstraints(maxWidth: widget.prefixMaxWidth),
            prefixIcon: widget.prefixIcon == null
                ? null
                : Padding(
                    padding: const EdgeInsets.only(left: 12, right: 8),
                    child: widget.prefixIcon,
                  ),
            counterText: widget.counterText,
            counterStyle: widget.counterStyle ?? Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 12),
          ),
    );
  }
}

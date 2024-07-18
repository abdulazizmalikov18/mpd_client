import 'package:circle_flags/circle_flags.dart';
import 'package:flutter/material.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_button.dart';

class WSelectLangDialog extends StatefulWidget {
  const WSelectLangDialog({
    super.key,
  });

  @override
  State<WSelectLangDialog> createState() => _WSelectLangDialogState();
}

class _WSelectLangDialogState extends State<WSelectLangDialog> {
  Locale locale = const Locale('uz');

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
      child: SizedBox(
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Center(
                child: Text(
                  'Application language',
                  style: AppTheme.titleSmall.copyWith(
                    color: white,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SelectLangItem(
                langCode: 'uz',
                isActive: locale == const Locale('uz'),
                title: "Uzbek",
                onTap: () => onTapLangItem(const Locale('uz')),
              ),
              SelectLangItem(
                langCode: 'ru',
                isActive: locale == const Locale('ru'),
                title: "Russian",
                onTap: () => onTapLangItem(const Locale('ru')),
              ),
              SelectLangItem(
                langCode: 'us',
                isActive: locale == const Locale('en'),
                title: "English",
                onTap: () => onTapLangItem(const Locale('en')),
              ),
              WButton(
                margin: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 32),
                onTap: onTapSelect,
                text: 'Tanlash',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTapLangItem(Locale newLocale) {
    setState(() {
      locale = newLocale;
    });
  }

  void onTapSelect() {
    Navigator.pop(context);
  }
}

class SelectLangItem extends StatelessWidget {
  final String langCode;
  final String title;
  final bool isActive;
  final void Function() onTap;

  const SelectLangItem({
    super.key,
    required this.langCode,
    required this.isActive,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: isActive ? white.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: isActive ? Border.all(color: white.withOpacity(0.5)) : null,
            boxShadow: [
              if (isActive) BoxShadow(color: primary.withOpacity(0.08), blurRadius: 4, offset: const Offset(0, 4)),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleFlag(langCode, size: 24),
                    const SizedBox(width: 12),
                    Text(
                      title,
                      style: AppTheme.bodyLarge.copyWith(
                        color: white,
                      ),
                    ),
                  ],
                ),
                // (isActive ? AppIcons.radioOn : AppIcons.radioOff).svg(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

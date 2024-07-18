import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_app_bar.dart';

class NotificationSettingsView extends StatefulWidget {
  const NotificationSettingsView({super.key});

  @override
  State<NotificationSettingsView> createState() => _NotificationSettingsViewState();
}

class _NotificationSettingsViewState extends State<NotificationSettingsView> {
  ValueNotifier<bool> switchOne = ValueNotifier(true);
  ValueNotifier<bool> switchTwo = ValueNotifier(true);
  ValueNotifier<bool> switchThree = ValueNotifier(true);

  void onChangeOne(bool newValue) {
    switchOne.value = newValue;
  }

  void onChangeTwo(bool newValue) {
    switchTwo.value = newValue;
  }

  void onChangeThree(bool newValue) {
    switchThree.value = newValue;
  }

  void onPressBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WAppBar(title: Text("Bildirishnomalarni sozlash")),
      body: Column(
        children: [
          WNotificationSettingsItem(
            title: 'Всплывающие напоминания',
            onChange: onChangeOne,
            value: switchOne,
          ),
          WNotificationSettingsItem(
            title: 'Получайте оповещения на свою телефону',
            subTitle: 'Оповещение  и советы ',
            onChange: onChangeTwo,
            value: switchTwo,
          ),
          WNotificationSettingsItem(
            title: 'Новостная рассылка',
            subTitle: 'Новости и рекламная информация',
            onChange: onChangeThree,
            value: switchThree,
          ),
        ],
      ),
    );
  }
}

class WNotificationSettingsItem extends StatelessWidget {
  final String title;
  final String? subTitle;
  final void Function(bool newValue) onChange;
  final ValueNotifier<bool> value;

  const WNotificationSettingsItem({
    super.key,
    required this.title,
    this.subTitle,
    required this.onChange,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.displayLarge,
                ),
                if (subTitle != null)
                  Text(
                    subTitle!,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.labelSmall,
                  ),
              ],
            ),
          ),
          SizedBox(
            height: 48,
            width: 50,
            child: FittedBox(
              fit: BoxFit.contain,
              child: ValueListenableBuilder(
                valueListenable: value,
                builder: (BuildContext context, bool value, Widget? child) {
                  return CupertinoSwitch(
                    activeColor: primary,
                    value: value,
                    onChanged: onChange,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

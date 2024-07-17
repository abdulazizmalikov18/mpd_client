import 'package:flutter/material.dart';

class HomeItemEntity {
  final String icon;
  final String title;
  final String subtitle;
  final Widget? route;

  HomeItemEntity({required this.icon, required this.title, required this.subtitle, this.route});
}

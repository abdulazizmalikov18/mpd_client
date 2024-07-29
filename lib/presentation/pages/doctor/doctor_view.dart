import 'package:flutter/material.dart';
import 'package:mpd_client/presentation/pages/yandex_doctor/doctor_page.dart';

class DoctorView extends StatefulWidget {
  const DoctorView({super.key});

  @override
  State<DoctorView> createState() => _DoctorViewState();
}

class _DoctorViewState extends State<DoctorView> {
  @override
  Widget build(BuildContext context) {
    return const DoctorPage();
  }
}

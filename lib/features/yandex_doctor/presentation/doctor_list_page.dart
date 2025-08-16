import 'package:flutter/material.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/features/yandex_doctor/data/models/searched_specialist_model.dart';
import 'package:mpd_client/features/yandex_doctor/presentation/widgets/doctor_card_iteam.dart';

class DoctorListPage extends StatefulWidget {
  const DoctorListPage({
    super.key,
    required this.specialists,
    required this.title,
  });
  final List<MapSpecialist> specialists;
  final String title;

  @override
  State<DoctorListPage> createState() => _DoctorListPageState();
}

class _DoctorListPageState extends State<DoctorListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: context.color.black),
        backgroundColor: context.color.white,
        elevation: 1,
        title: Text(widget.title, style: TextStyle(color: context.color.black)),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemBuilder: (context, index) =>
            DoctorCardIteam(specialists: widget.specialists[index]),
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemCount: widget.specialists.length,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mpd_client/presentation/pages/appointment/appointment/appoinment.dart';

class RecordView extends StatefulWidget {
  const RecordView({super.key});

  @override
  State<RecordView> createState() => _RecordViewState();
}

class _RecordViewState extends State<RecordView> {
  @override
  Widget build(BuildContext context) {
    return AppointmentPage();
    return const Scaffold(
      body: Placeholder(),
    );
  }
}

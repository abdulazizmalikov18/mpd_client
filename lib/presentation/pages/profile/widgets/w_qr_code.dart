import 'package:flutter/material.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CreateQRCode extends StatelessWidget {
  const CreateQRCode({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: QrImageView(
        data: text,
        version: QrVersions.auto,
        eyeStyle: const QrEyeStyle(color: white, eyeShape: QrEyeShape.square),
        dataModuleStyle: const QrDataModuleStyle(
          color: white,
          dataModuleShape: QrDataModuleShape.square,
        ),
        embeddedImageStyle: const QrEmbeddedImageStyle(color: white),
      ),
    );
  }
}

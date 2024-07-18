import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:image_painter/image_painter.dart';
import 'package:mpd_client/infrastructure/services/log_service.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/widgets/w_button.dart';

class ErrorDrawView extends StatefulWidget {
  final Uint8List data;

  const ErrorDrawView({super.key, required this.data});

  @override
  State<ErrorDrawView> createState() => _ErrorDrawViewState();
}

class _ErrorDrawViewState extends State<ErrorDrawView> {
  final _imageKey = GlobalKey<ImagePainterState>();
  final _imageController = ImagePainterController(strokeWidth: 2, color: Colors.red, mode: PaintMode.rect);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: ImagePainter.memory(
            widget.data,
            key: _imageKey,
            scalable: true,
            textDelegate: TextDelegate(),
            controller: _imageController,
          ),
        ),
      ),
      floatingActionButton: WButton(
        onTap: () async {
          final picture = await _imageController.exportImage();
          if (picture == null) {
            print("Image Null");
            return;
          }
          sendPhotoToTelegram(picture).whenComplete(() {
            context.pop();
          });
        },
        text: "Send",
        margin: const EdgeInsets.symmetric(horizontal: 16),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> sendPhotoToTelegram(Uint8List picture) async {
    final multiPartFile = FormData()
      ..fields.add(
        const MapEntry('chat_id', '@t_med_log'),
      );
    multiPartFile.files.add(
      MapEntry(
        "photo",
        MultipartFile.fromBytes(
          picture,
          filename: 'photo',
        ),
      ),
    );

    const token = '7175999350:AAHnib0ioHi37o9iEpq2CUlr4oe2pcCCQ6k';
    const url = 'https://api.telegram.org/bot$token/sendPhoto';

    final result = await Dio().post(url, data: multiPartFile);
    if ((result.statusCode ?? 0) > 300) {
      Log.e("Data Jo'natilmadi");
    } else {
      Log.e("Error Jo'natildi !");
    }
  }
}

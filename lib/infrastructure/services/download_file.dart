import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mpd_client/infrastructure/services/log_service.dart';
import 'package:open_app_file/open_app_file.dart';
import 'package:path/path.dart' as path;

class DownloadFile {
  final String file;
  final void Function(void Function() fn) setState;

  DownloadFile({required this.file, required this.setState});

  bool dowloading = false;
  bool fileExists = false;
  double progress = 0;
  String fileName = "";
  late String filePath;
  late CancelToken cancelToken = CancelToken();

  Future<void> startDownload() async {
    Log.i("Starting Download : $file");

    try {
      var storePath = await getPath();
      filePath = '$storePath/$fileName';
      setState(() {
        dowloading = true;
        progress = 0;
      });

      await Dio().download(file, filePath, onReceiveProgress: (count, total) {
        setState(() {
          progress = (count / total);
          print(progress);
        });
      }, cancelToken: cancelToken);
      setState(() {
        dowloading = false;
        fileExists = true;
      });
    } catch (e, s) {
      Log.e("Error : $e \nStack : $s");
      setState(() {
        dowloading = false;
      });
    }
  }

  void cancelDownload() async {
    Log.i("Cancel Download");
    cancelToken.cancel();
    setState(() {
      dowloading = false;
    });
  }

  checkFileExit() async {
    final storePath = await getPath();
    filePath = '$storePath/$fileName';
    bool fileExistCheck = await File(filePath).exists();
    setState(() {
      fileExists = fileExistCheck;
    });
  }

  Future<OpenResult> openfile() async {
    Log.i("Open File : $filePath");
    return await OpenAppFile.open(filePath);
  }

  static Future<String> getPath() async {
    final Directory tempDir = Directory.systemTemp;
    final filePath = Directory("${tempDir.path}/files");
    if (await filePath.exists()) {
      return filePath.path;
    } else {
      await filePath.create(recursive: true);
      return filePath.path;
    }
  }

  void initFile() {
    setState(() {
      fileName = path.basename(file);
    });
    checkFileExit();
  }
}

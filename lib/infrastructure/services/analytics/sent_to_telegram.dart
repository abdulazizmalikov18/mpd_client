import 'dart:io';

import 'package:feedback/feedback.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../../../utils/constants.dart';
import 'package:http/http.dart' as http;

import '../log_service.dart';

Future<void> sendToTelegram(UserFeedback feedback) async {
  try {
    Directory appDocDirectory = await getApplicationDocumentsDirectory();

    Directory create =
        await Directory('${appDocDirectory.path}/dir').create(recursive: true);
    File file = await File('${create.path}/${const Uuid().v4()}.png')
        .writeAsBytes(feedback.screenshot);
    Uri url = Uri.parse(
        "https://api.telegram.org/bot${Constants.telegramBotToken}/sendDocument?chat_id=${Constants.telegramBotChatId}");
    http.MultipartRequest request = http.MultipartRequest("POST", url);
    request.files.add(await http.MultipartFile.fromPath('document', file.path));
    request.fields['caption'] = feedback.text;
    http.Response r = await http.Response.fromStream(await request.send());

    LogService.i(r.body);
    file.delete();
  } catch (e) {
    LogService.e(e.toString());
  }
}

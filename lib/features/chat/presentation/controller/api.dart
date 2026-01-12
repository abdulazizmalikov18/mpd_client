import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mpd_client/src/widgets/custom_snackbar.dart';

Future<String> fetchToken(BuildContext context) async {
  if (!dotenv.isInitialized) {
    // Load Environment variables
    await dotenv.load(fileName: ".env");
  }
  final String? authUrl = dotenv.env['AUTH_URL'];
  String? authToken = dotenv.env['AUTH_TOKEN'];

  if ((authToken?.isEmpty ?? true) &&
      (authUrl?.isEmpty ?? true) &&
      context.mounted) {
    CustomSnackbar.show(context, "Please set the environment variables");
    throw Exception("Either AUTH_TOKEN or AUTH_URL is not set in .env file");
  }

  if ((authToken?.isNotEmpty ?? false) &&
      (authUrl?.isNotEmpty ?? false) &&
      context.mounted) {
    CustomSnackbar.show(context, "Please set only one environment variable");
    throw Exception("Either AUTH_TOKEN or AUTH_URL can be set in .env file");
  }

  if (authUrl?.isNotEmpty ?? false) {
    final Uri getTokenUrl = Uri.parse('$authUrl/get-token');
    final http.Response tokenResponse = await http.get(getTokenUrl);
    authToken = json.decode(tokenResponse.body)['token'];
  }

  return authToken ?? "";
}

Future<String> createMeeting(String token) async {
  if (!dotenv.isInitialized) {
    // Load Environment variables
    await dotenv.load(fileName: ".env");
  }
  final String? videosdkApiEndpoint = dotenv.env['VIDEOSDK_API_ENDPOINT'];

  final Uri getMeetingIdUrl = Uri.parse('$videosdkApiEndpoint/rooms');
  final http.Response meetingIdResponse = await http.post(
    getMeetingIdUrl,
    headers: {"Authorization": token},
  );

  if (meetingIdResponse.statusCode != 200) {
    throw Exception(json.decode(meetingIdResponse.body)["error"]);
  }
  var meetingID = json.decode(meetingIdResponse.body)['roomId'];
  return meetingID;
}

Future<bool> validateMeeting(String token, String meetingId) async {
  if (!dotenv.isInitialized) {
    // Load Environment variables
    await dotenv.load(fileName: ".env");
  }
  final String? videosdkApiEndpoint = dotenv.env['VIDEOSDK_API_ENDPOINT'];

  final Uri validateMeetingUrl = Uri.parse(
    '$videosdkApiEndpoint/rooms/validate/$meetingId',
  );
  final http.Response validateMeetingResponse = await http.get(
    validateMeetingUrl,
    headers: {"Authorization": token},
  );

  if (validateMeetingResponse.statusCode != 200) {
    throw Exception(json.decode(validateMeetingResponse.body)["error"]);
  }

  return validateMeetingResponse.statusCode == 200;
}

Future<dynamic> fetchSession(String token, String meetingId) async {
  if (!dotenv.isInitialized) {
    // Load Environment variables
    await dotenv.load(fileName: ".env");
  }
  final String? videosdkApiEndpoint = dotenv.env['VIDEOSDK_API_ENDPOINT'];

  final Uri getMeetingIdUrl = Uri.parse(
    '$videosdkApiEndpoint/sessions?roomId=$meetingId',
  );
  final http.Response meetingIdResponse = await http.get(
    getMeetingIdUrl,
    headers: {"Authorization": token},
  );
  List<dynamic> sessions = jsonDecode(meetingIdResponse.body)['data'];
  return sessions.first;
}

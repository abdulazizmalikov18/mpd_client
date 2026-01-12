import 'package:flutter/material.dart';
import 'package:mpd_client/features/chat/presentation/widgets/video/spacer.dart';

class WaitingToJoin extends StatelessWidget {
  const WaitingToJoin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator.adaptive(),
            ),
            const VerticalSpacer(20),
            const Text(
              "Creating a Room",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

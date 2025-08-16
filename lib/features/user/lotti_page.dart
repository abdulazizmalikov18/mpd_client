import 'package:lottie/lottie.dart';
import 'package:mpd_client/app/app_anim.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/provider/language.dart';

class LottiPage extends StatefulWidget {
  const LottiPage({super.key});

  @override
  State<LottiPage> createState() => _LottiPageState();
}

class _LottiPageState extends State<LottiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: LottieBuilder.asset(AppAnim.anim4)),
    );
  }
}

import 'package:equatable/equatable.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/features/app.dart';

part 'refreshtoken_event.dart';
part 'refreshtoken_state.dart';

class RefreshtokenBloc extends Bloc<RefreshtokenEvent, RefreshtokenState> {
  final AuthRepository repo;
  RefreshtokenBloc(this.repo) : super(RefreshtokenInitial()) {
    on<GetRefreshToken>((event, emit) async {
      final result = await repo.refreshToken();
      if (result.isRight) {
        debugPrint(
          'New token -----------------------> 😏😏😏😏😏😏😏😏  ${result.right.access}',
        );
      } else {
        $navigatorKey.currentState!.popUntil((route) => false);
        $navigatorKey.currentState!.pushReplacementNamed(AppRoutes.auth);
      }
    });
  }
}

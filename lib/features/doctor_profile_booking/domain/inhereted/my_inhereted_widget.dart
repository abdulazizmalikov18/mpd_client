import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/features/doctor_profile_booking/data/models/doctor_profile_model.dart';

class MyInheretedWidget extends InheritedWidget {
  const MyInheretedWidget(this.doctor, {super.key, required super.child});
  final DoctorProfileModel doctor;

  static MyInheretedWidget of(BuildContext context) {
    final MyInheretedWidget? result = context.dependOnInheritedWidgetOfExactType<MyInheretedWidget>();
    assert(result != null, 'No MyInheretedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant MyInheretedWidget oldWidget) {
    return oldWidget.doctor != doctor;
  }
}

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/core/utils/extensions.dart';
import 'package:mpd_client/core/utils/log_service.dart';
import 'package:mpd_client/core/utils/utils.dart';
import 'package:mpd_client/features/doctor_profile_booking/presentation/pages/appointment_date_time/components/appointment_time_widget.dart';

import '../../../../data/models/timetable_by_day.dart';

class TimesListComponent extends StatefulWidget {
  final String startTime;
  final String endTime;
  final int interval;
  final String selectedTime;
  final List<BookedTime> bookedTimes;
  final DateTime selectedDate;
  const TimesListComponent({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.selectedDate,
    required this.interval,
    required this.selectedTime,
    required this.bookedTimes,
  });

  @override
  State<TimesListComponent> createState() => _TimesListComponentState();
}

class _TimesListComponentState extends State<TimesListComponent> {
  final List<String> intervalList = [];

  @override
  void initState() {
    super.initState();
    Log.e(widget.startTime);

    final formattedStart = DateTime.parse('2020-01-02 ${widget.startTime}');
    final now = DateTime.now();

    late DateTime checkedStartTime;
    if (widget.selectedDate.isDateEqual(now) &&
        now.hour == formattedStart.hour &&
        now.minute > formattedStart.minute) {
      checkedStartTime = now;
    } else if (widget.selectedDate.isDateEqual(now) &&
        now.hour > formattedStart.hour) {
      checkedStartTime = now;
    } else {
      checkedStartTime = formattedStart;
    }
    final formattedEnd = DateTime.parse('2020-01-02 ${widget.endTime}');
    DateTime inserted = checkedStartTime;
    intervalList.add(Utils.timeFormat(inserted));
    for (var i = checkedStartTime.hour; i < formattedEnd.hour; i++) {
      do {
        inserted = inserted.add(Duration(minutes: widget.interval));

        intervalList.add(Utils.timeFormat(inserted));
      } while (inserted.hour != i + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: intervalList.length - 1,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      scrollDirection: Axis.horizontal,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 55,
        childAspectRatio: 1 / 2.9,
        mainAxisSpacing: 11.5.w,
        crossAxisSpacing: 12.h,
      ),
      itemBuilder: (context, index) {
        final time = '${intervalList[index]} - ${intervalList[index + 1]}';
        final isBooked = widget.bookedTimes.any(
          (bookedTime) => bookedTime.startTime == intervalList[index],
        );
        return AppointmentTimeWidget(
          isBooked: isBooked,
          time: time,
          selected: widget.selectedTime == time,
          onTap: () {
            context.read<TimetableBloc>().add(SelectTimeEvent(time: time));
          },
        );
      },
    );
  }
}

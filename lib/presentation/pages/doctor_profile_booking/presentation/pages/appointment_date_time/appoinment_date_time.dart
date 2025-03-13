import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mpd_client/application/doctor_booking/add_to_cart/add_to_cart_bloc.dart';
import 'package:mpd_client/application/doctor_booking/timetable_bloc/timetable_bloc.dart';
import 'package:mpd_client/infrastructure/services/local_service.dart';
import 'package:mpd_client/presentation/pages/appointment/widgets/app_bar_widget.dart';
import 'package:mpd_client/presentation/pages/appointment/widgets/loading_widget.dart';
import 'package:mpd_client/presentation/pages/appointment/widgets/pinned_sheet.dart';
import 'package:mpd_client/presentation/pages/doctor_profile_booking/presentation/pages/appointment_date_time/components/comment_input_widget.dart';
import 'package:mpd_client/presentation/pages/doctor_profile_booking/presentation/pages/appointment_date_time/components/times_list_component.dart';
import 'package:mpd_client/presentation/pages/doctor_profile_booking/presentation/pages/appointment_date_time/components/times_loading_component.dart';
import 'package:mpd_client/presentation/pages/doctor_profile_booking/presentation/widgets/w_build_label.dart';
import 'package:mpd_client/presentation/router/routs_contact.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_long_button.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';
import 'package:mpd_client/utils/ui_tools.dart';
import 'package:mpd_client/utils/utils.dart';
import 'package:table_calendar/table_calendar.dart';

class AppoinmentDateTimePage extends StatefulWidget {
  final int id;
  final List<LocalService> localProducts;

  const AppoinmentDateTimePage({
    super.key,
    required this.id,
    required this.localProducts,
  });

  @override
  State<AppoinmentDateTimePage> createState() => _AppoinmentDateTimePageState();
}

class _AppoinmentDateTimePageState extends State<AppoinmentDateTimePage> {
  @override
  void initState() {
    final timeTableBloc = context.read<TimetableBloc>();
    if (timeTableBloc.state.status == Status.initial) {
      timeTableBloc.add(GetTimetableByDay(day: DateTime.now(), id: widget.id));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: context.l10n.book_appointment_date_page),
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            ScreenUtil().setVerticalSpacing(12.h),
            BuildLabel(label: context.l10n.book_appointment_select_date),
            BlocBuilder<TimetableBloc, TimetableState>(
              builder: (context, state) {
                return _buildTableCalendar(
                  selectedDate_: state.datetime,
                  focusedDay_: state.focusedDay,
                  calendarFormat_: state.calendarFormat,
                  context: context,
                );
              },
            ),
            BlocConsumer<TimetableBloc, TimetableState>(
              listener: (context, state) {
                if (state.status == Status.failure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    UiTools.failSnackbar(
                      title: state.failure,
                      context: context,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state.status == Status.failure &&
                    state.failure.contains('Specialist does not work on')) {
                  return Column(
                    children: [
                      SvgPicture.asset(AppIcons.noWorkingDay),
                      ScreenUtil().setVerticalSpacing(23.h),
                      Text(
                        context.l10n.book_appointment_date_error,
                        style: Styles.semiboldTitle.copyWith(fontSize: 22.sp),
                      ),
                      ScreenUtil().setVerticalSpacing(8.h),
                      Text(
                        context.l10n.book_appointment_time_error,
                        style: Styles.descSubtitle.copyWith(color: grey),
                      ),
                    ],
                  );
                }
                return _buildWorkingDay(state);
              },
            )
          ],
        ),
      ),
      // Bottom
      bottomSheet: PinnedSheet(
        verticalPadding: 0,
        widget: BlocListener<AddToCartBloc, AddToCartState>(
          listener: (context, state) {
            if (state is AddToCartLoading) {
              FocusScope.of(context).unfocus();
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const LoadingDialogWidget(),
              );
            } else if (state is AddToCartSuccess) {
              Navigator.pop(context);
              context.pushNamed(
                AppRouteNames.appointmentReview,
                extra: {'product': widget.localProducts},
              );
            } else {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                UiTools.failSnackbar(
                  title: 'Unknown server failure!',
                  context: context,
                ),
              );
            }
          },
          child: BlocBuilder<TimetableBloc, TimetableState>(
            builder: (_, state) {
              return AnimatedCrossFade(
                firstChild: const SizedBox(width: double.maxFinite),
                secondChild: Padding(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  child: LongButton(
                    buttonName: context.l10n.book_appointment_next,
                    onPress: () {
                      final meetDate = Utils.toDateTimeFormat(
                          state.datetime!, state.selectedTime);

                      context.read<AddToCartBloc>().add(
                            AddToCart(
                              localServices: widget.localProducts,
                              responsible: widget.id,
                              meetDate: meetDate,
                            ),
                          );
                    },
                  ),
                ),
                crossFadeState: state.selectedTime != ''
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildWorkingDay(TimetableState state) {
    return Builder(
      builder: (context) {
        if (state.status == Status.loading) {
          return Column(
            children: [
              BuildLabel(label: context.l10n.book_appointment_select_time),
              ScreenUtil().setVerticalSpacing(12.h),
              SizedBox(
                height: 150.h,
                child: const TimesLoadingComponent(),
              ),
            ],
          );
        } else if (state.status == Status.failure) {
          return Padding(
            padding: EdgeInsets.all(12.h),
            child: Center(
              child: Text(
                "Bu kun ish kuni emas",
                style:
                    Styles.boldTopHint.copyWith(fontSize: 18.sp, color: black),
              ),
            ),
          );
        } else {
          return Column(
            children: [
              BuildLabel(label: context.l10n.book_appointment_select_time),
              ScreenUtil().setVerticalSpacing(12.h),
              state.specTimetable!.procInterval.toInt() != 0
                  ? SizedBox(
                      height: 150.h,
                      child: TimesListComponent(
                        selectedDate: state.datetime!,
                        selectedTime: state.selectedTime,
                        bookedTimes: state.specTimetable!.bookedTimes,
                        startTime: state.specTimetable!.startTime,
                        endTime: state.specTimetable!.endTime,
                        interval: state.specTimetable!.procInterval.toInt(),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: RichText(
                        text: TextSpan(
                          text: context.l10n.book_appointment_select_first_come,
                          style: Styles.headline5.copyWith(color: black),
                          children: [
                            TextSpan(
                                text:
                                    '(${context.l10n.book_appointment_select_first_come_stats_last} 44,',
                                style: Styles.headline5
                                    .copyWith(color: gradientBlueOpacity)),
                            TextSpan(
                                text:
                                    ' ${context.l10n.book_appointment_select_first_come_stats_now} 5)',
                                style: Styles.headline5
                                    .copyWith(color: gradientBlueOpacity)),
                          ],
                        ),
                      ),
                    ),
              ScreenUtil().setVerticalSpacing(24.h),
              BuildLabel(label: context.l10n.book_appointment_comment),
              ScreenUtil().setVerticalSpacing(12.h),
              Stack(
                children: [
                  CommentInputWidget(
                    hintText: context.l10n.book_appointment_comment_write,
                    onChanged: (value) => context
                        .read<TimetableBloc>()
                        .add(OnChangedCommentEvent(value: value)),
                  ),
                  Positioned(
                    right: 28.w,
                    bottom: 12.h,
                    child: BlocSelector<TimetableBloc, TimetableState, String>(
                      selector: (state) => state.comment,
                      builder: (context, comment) {
                        return Text(
                          '${comment.length}/200',
                          style: Styles.headline7
                              .copyWith(color: grey, fontSize: 14.sp),
                        );
                      },
                    ),
                  ),
                ],
              ),
              ScreenUtil().setVerticalSpacing(90.h)
            ],
          );
        }
      },
    );
  }

  Container _buildTableCalendar(
      {required DateTime? selectedDate_,
      required DateTime focusedDay_,
      required CalendarFormat calendarFormat_,
      required BuildContext context}) {
    String locale = Localizations.localeOf(context).languageCode;
    return Container(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      child: TableCalendar(
        locale: locale,
        formatAnimationCurve: Curves.fastOutSlowIn,
        formatAnimationDuration: const Duration(milliseconds: 800),
        availableCalendarFormats: const {
          CalendarFormat.month: 'Month',
          CalendarFormat.week: 'Week',
        },
        firstDay: DateTime.now(),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: focusedDay_,
        calendarFormat: calendarFormat_,
        enabledDayPredicate: (day) {
          // if (day.weekday == DateTime.sunday) {
          //   return false;
          // }
          return true;
        },
        selectedDayPredicate: (day) {
          return isSameDay(selectedDate_, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(selectedDate_, selectedDay)) {
            //? For choose and save day, if month changed also
            context
                .read<TimetableBloc>()
                .add(SelectDayEvent(day: selectedDay, focusedDay: focusedDay));
            context
                .read<TimetableBloc>()
                .add(GetTimetableByDay(day: selectedDay, id: widget.id));
          }
        },
        onFormatChanged: (format) {
          //? For change calendar format scroll up and scroll down
          context
              .read<TimetableBloc>()
              .add(OnChangedCalFormatEvent(format: format));
        },
        onPageChanged: (focusedDay) {
          //? For save focused day in month changed
          // context
          //     .read<TimetableBloc>()
          //     .add(SelectDayEvent(day: selectedDate_!, focusedDay: focusedDay));
        },
        rowHeight: 45.h,
        headerStyle: HeaderStyle(
          titleCentered: true,
          leftChevronMargin: EdgeInsets.zero,
          leftChevronPadding: EdgeInsets.zero,
          rightChevronMargin: EdgeInsets.zero,
          rightChevronPadding: EdgeInsets.zero,
          headerPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          leftChevronIcon: SvgPicture.asset(
            AppIcons.back,
            height: 24.h,
            width: 24.h,
            colorFilter: const ColorFilter.mode(white, BlendMode.srcIn),
          ),
          rightChevronIcon: SvgPicture.asset(
            AppIcons.forward,
            height: 24.h,
            width: 24.h,
            colorFilter: const ColorFilter.mode(white, BlendMode.srcIn),
          ),
          formatButtonVisible: false,
          titleTextStyle:
              Styles.boldHeadline6.copyWith(color: white, fontSize: 18.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.r),
                topRight: Radius.circular(10.r)),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [gradientBlueOpacity, gradientBlue],
            ),
          ),
        ),
        calendarStyle: CalendarStyle(
          selectedTextStyle:
              Styles.headline7.copyWith(fontSize: 14.sp, color: white),
          cellMargin: const EdgeInsets.all(4.5),
          defaultTextStyle:
              Styles.headline7.copyWith(fontSize: 14.sp, color: black),
          tablePadding: EdgeInsets.zero,
          isTodayHighlighted: false,
          selectedDecoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [gradientBlueOpacity, gradientBlue],
            ),
          ),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.withValues(alpha: 0.5),
              ),
            ),
          ),
          weekendStyle: Styles.headline7.copyWith(fontSize: 14.sp, color: grey),
          weekdayStyle: Styles.headline7.copyWith(fontSize: 14.sp, color: grey),
        ),
        startingDayOfWeek: StartingDayOfWeek.monday,
        daysOfWeekHeight: 45,
      ),
    );
  }
}

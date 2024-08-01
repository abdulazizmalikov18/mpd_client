import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/application/appointment/canceled_appointment/canceled_appointment_bloc.dart';
import 'package:mpd_client/application/appointment/completed_appointment/completed_appointment_bloc.dart';
import 'package:mpd_client/application/appointment/upcoming_appointment/upcoming_appoinment_bloc.dart';
import 'package:mpd_client/presentation/pages/appointment/appointment/components/appointment_list.dart';
import 'package:mpd_client/presentation/pages/appointment/appointment/components/no_appointment.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';
import 'components/appointment_shimmer.dart';

PageController controller = PageController(initialPage: 0);

enum DrCardInfo { following, pending, completed, cancelled }

bool noAppointment = false;

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    context.read<UpcomingAppoinmentsBloc>().add(const GetUpcomingAppoinmentsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: .0,
          backgroundColor: white,
          automaticallyImplyLeading: false,
          toolbarHeight: 56.h,
          centerTitle: false,
          title: Text(
            context.l10n.appointment_main_page,
            style: Styles.headline4.copyWith(
              color: black,
            ),
          ),
          bottom: PreferredSize(
              preferredSize: Size(double.maxFinite, 56.h),
              child: Container(
                height: 50.h,
                width: double.maxFinite,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: background),
                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: TabBar(
                  isScrollable: true, //context.read<LocalProvider>().locale == const Locale('en') ? false : true,
                  padding: const EdgeInsets.all(4),
                  indicator: BoxDecoration(borderRadius: BorderRadius.circular(8.r), color: white),
                  indicatorColor: Colors.transparent,
                  tabs: [
                    Tab(
                      child: Text(
                        context.l10n.appointment_upcoming,
                        style: Styles.descSubtitle.copyWith(
                          color: black,
                        ),
                      ),
                    ),
                    Tab(
                        child: Text(
                      context.l10n.appointment_complited,
                      style: Styles.descSubtitle.copyWith(color: black),
                    )),
                    Tab(
                        child: Text(
                      context.l10n.appointment_canceled,
                      style: Styles.descSubtitle.copyWith(color: black),
                    ))
                  ],
                ),
              )),
        ),
        body: TabBarView(children: [_buildUpcomingAppointments(), _buildCompletedAppointments(), _buildCanceledAppointments()]),
      ),
    );
  }

  BlocBuilder<UpcomingAppoinmentsBloc, UpcomingAppoinmentsState> _buildUpcomingAppointments() {
    return BlocBuilder<UpcomingAppoinmentsBloc, UpcomingAppoinmentsState>(
      builder: (context, state) {
        if (state is UpcomingAppoinmentsFailure) {
          return NoAppointment(
            title: context.l10n.appointment_server_error,
            subtitle: context.l10n.appointment_server_error_description,
            buttonName: context.l10n.appointment_server_error_reload,
            onPressed: () => context.read<UpcomingAppoinmentsBloc>().add(const GetUpcomingAppoinmentsEvent(isErrorRefresh: true, isRefresh: true)),
            isServer: true,
          );
        } else if (state is UpcomingAppoinmentsSuccess) {
          if (state.appoinments.isEmpty) {
            return NoAppointment(
              onRefresh: () {
                context.read<UpcomingAppoinmentsBloc>().add(const GetUpcomingAppoinmentsEvent(isErrorRefresh: true, isRefresh: true));
              },
              title: context.l10n.appointment_upcoming_title,
              subtitle: context.l10n.appointment_upcoming_subtitle,
              buttonName: context.l10n.appointment_book_appointment,
              onPressed: () => controller.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.fastOutSlowIn),
            );
          }
          return AppointmentList(
            infoIndex: 0,
            onRefresh: () async {
              context.read<UpcomingAppoinmentsBloc>().add(const GetUpcomingAppoinmentsEvent(isRefresh: true));
              await context.read<UpcomingAppoinmentsBloc>().stream.first;
            },
            hasReachedMax: state.hasReachedMax,
            appointments: state.appoinments,
            scrollController: ScrollController(),
            scrollEndFunction: () {
              context.read<UpcomingAppoinmentsBloc>().add(const GetUpcomingAppoinmentsEvent());
            },
          );
        }
        return const AppointmentShimmer();
      },
    );
  }

  BlocBuilder<CompletedAppointmentBloc, CompletedAppointmentState> _buildCompletedAppointments() {
    return BlocBuilder<CompletedAppointmentBloc, CompletedAppointmentState>(
      builder: (context, state) {
        if (state is CompletedAppoinmentsFailure) {
          return NoAppointment(
            title: context.l10n.appointment_server_error,
            subtitle: context.l10n.appointment_server_error_description,
            buttonName: context.l10n.appointment_server_error_reload,
            onPressed: () => context.read<CompletedAppointmentBloc>().add(const GetCompletedAppoinmentsEvent(isErrorRefresh: true)),
            isServer: true,
          );
        } else if (state is CompletedAppoinmentSuccess) {
          if (state.appoinments.isEmpty) {
            return NoAppointment(
              onRefresh: () {
                context.read<CompletedAppointmentBloc>().add(const GetCompletedAppoinmentsEvent(isErrorRefresh: true, isRefresh: true));
              },
              title: context.l10n.appointment_upcoming_title,
              subtitle: context.l10n.appointment_upcoming_subtitle,
              buttonName: context.l10n.appointment_book_appointment,
              onPressed: () => controller.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.fastOutSlowIn),
            );
          }
          return AppointmentList(
            infoIndex: 1,
            onRefresh: () async {
              context.read<CompletedAppointmentBloc>().add(const GetCompletedAppoinmentsEvent(isRefresh: true));
              await context.read<CompletedAppointmentBloc>().stream.first;
            },
            hasReachedMax: state.hasReachedMax,
            appointments: state.appoinments,
            scrollController: ScrollController(),
            scrollEndFunction: () {
              context.read<CompletedAppointmentBloc>().add(const GetCompletedAppoinmentsEvent());
            },
          );
        }
        return const AppointmentShimmer();
      },
    );
  }

  BlocBuilder<CanceledAppointmentBloc, CanceledAppointmentState> _buildCanceledAppointments() {
    return BlocBuilder<CanceledAppointmentBloc, CanceledAppointmentState>(
      builder: (context, state) {
        if (state is CanceledAppoinmentsFailure) {
          return NoAppointment(
            title: context.l10n.appointment_server_error,
            subtitle: context.l10n.appointment_server_error_description,
            buttonName: context.l10n.appointment_server_error_reload,
            onPressed: () => context.read<CanceledAppointmentBloc>().add(const GetCanceledAppoinmentsEvent(isErrorRefresh: true)),
            isServer: true,
          );
        } else if (state is CanceledAppoinmentSuccess) {
          if (state.appoinments.isEmpty) {
            return NoAppointment(
              onRefresh: () {
                context.read<CanceledAppointmentBloc>().add(const GetCanceledAppoinmentsEvent(isErrorRefresh: true, isRefresh: true));
              },
              title: context.l10n.appointment_upcoming_title,
              subtitle: context.l10n.appointment_upcoming_subtitle,
              buttonName: context.l10n.appointment_book_appointment,
              onPressed: () => controller.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.fastOutSlowIn),
            );
          }
          return AppointmentList(
            infoIndex: 2,
            onRefresh: () async {
              context.read<CanceledAppointmentBloc>().add(const GetCanceledAppoinmentsEvent(isRefresh: true));
              await context.read<CanceledAppointmentBloc>().stream.first;
            },
            hasReachedMax: state.hasReachedMax,
            appointments: state.appoinments,
            scrollController: ScrollController(),
            scrollEndFunction: () {
              context.read<CanceledAppointmentBloc>().add(const GetCanceledAppoinmentsEvent());
            },
          );
        }
        return const AppointmentShimmer();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}




//! Filteration appointment UI
/*
                     Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 12.h,
                            ),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '6 appointment',
                                  style: Styles.boldTopHint
                                      .copyWith(fontSize: 18),
                                ),
                                InkWell(
                                  borderRadius: BorderRadius.circular(100.r),
                                  onTap: () {},
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        AppIcons.sort,
                                        color: mainBlue,
                                        height: 24.h,
                                        width: 24.h,
                                      ),
                                      ScreenUtil().setHorizontalSpacing(8),
                                      Text(
                                        'Filter',
                                        style: Styles.boldTopHint.copyWith(
                                            color: mainBlue,
                                            fontSize: 16),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          */
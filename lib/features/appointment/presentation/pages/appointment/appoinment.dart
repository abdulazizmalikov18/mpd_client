import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/features/appointment/domain/blocs/appointment/appoinment_bloc.dart';
import 'package:mpd_client/features/appointment/presentation/pages/appointment/components/appointment_list.dart';
import 'package:mpd_client/features/appointment/presentation/pages/appointment/components/no_appointment.dart';
import 'package:mpd_client/features/main_page.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/provider/local_provider.dart';
import 'package:mpd_client/src/themes/styles.dart';

import 'components/appointment_shimmer.dart';

enum DrCardInfo { following, pending, completed, cancelled }

bool noAppointment = false;

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    context.read<AppoinmentsBloc>().add(const GetAppoinmentsEvent());
    context.read<AppoinmentsBloc>().add(const GetAppoinmentsCompletedEvent());
    context.read<AppoinmentsBloc>().add(const GetAppoinmentsCanceledEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.appointment_main_page),
          bottom: PreferredSize(
            preferredSize: Size(double.maxFinite, 56),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ).copyWith(bottom: 8),
              child: Container(
                height: 48,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: context.color.background,
                ),
                child: TabBar(
                  isScrollable:
                      context.read<LocalProvider>().locale == const Locale('en')
                      ? false
                      : true,
                  padding: const EdgeInsets.all(4),
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: context.color.white,
                  ),
                  indicatorColor: Colors.transparent,
                  tabs: [
                    Tab(
                      child: Text(
                        context.l10n.appointment_upcoming,
                        style: Styles.descSubtitle.copyWith(
                          color: context.color.black,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        context.l10n.appointment_complited,
                        style: Styles.descSubtitle.copyWith(
                          color: context.color.black,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        context.l10n.appointment_canceled,
                        style: Styles.descSubtitle.copyWith(
                          color: context.color.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            _buildUpcomingAppointments(),
            _buildCompletedAppointments(),
            _buildCanceledAppointments(),
          ],
        ),
      ),
    );
  }

  BlocBuilder<AppoinmentsBloc, AppoinmentsState> _buildUpcomingAppointments() {
    return BlocBuilder<AppoinmentsBloc, AppoinmentsState>(
      builder: (context, state) {
        if (state.status.isFailure) {
          return NoAppointment(
            title: context.l10n.appointment_server_error,
            subtitle: context.l10n.appointment_server_error_description,
            buttonName: context.l10n.appointment_server_error_reload,
            onPressed: () => context.read<AppoinmentsBloc>().add(
              const GetAppoinmentsEvent(),
            ),
            isServer: true,
          );
        } else if (state.status.isSuccess) {
          if (state.appoinments.isEmpty) {
            return NoAppointment(
              onRefresh: () {
                context.read<AppoinmentsBloc>().add(
                  const GetAppoinmentsEvent(),
                );
              },
              title: context.l10n.appointment_upcoming_title,
              subtitle: context.l10n.appointment_upcoming_subtitle,
              buttonName: context.l10n.appointment_book_appointment,
              onPressed: () => controller.animateToPage(
                1,
                duration: const Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn,
              ),
            );
          }
          return AppointmentList(
            infoIndex: 0,
            onRefresh: () async {
              context.read<AppoinmentsBloc>().add(const GetAppoinmentsEvent());
              await context.read<AppoinmentsBloc>().stream.first;
            },
            hasReachedMax: state.count > state.appoinments.length,
            appointments: state.appoinments,
            scrollEndFunction: () {
              context.read<AppoinmentsBloc>().add(
                const GetAppoinmentsEvent(getMore: true),
              );
            },
            paginatorStatus: state.status,
          );
        }
        return const AppointmentShimmer();
      },
    );
  }

  BlocBuilder<AppoinmentsBloc, AppoinmentsState> _buildCompletedAppointments() {
    return BlocBuilder<AppoinmentsBloc, AppoinmentsState>(
      builder: (context, state) {
        if (state.statusCompleted.isFailure) {
          return NoAppointment(
            title: context.l10n.appointment_server_error,
            subtitle: context.l10n.appointment_server_error_description,
            buttonName: context.l10n.appointment_server_error_reload,
            onPressed: () => context.read<AppoinmentsBloc>().add(
              const GetAppoinmentsCompletedEvent(),
            ),
            isServer: true,
          );
        } else if (state.statusCompleted.isSuccess) {
          if (state.appoinmentsCompleted.isEmpty) {
            return NoAppointment(
              onRefresh: () {
                context.read<AppoinmentsBloc>().add(
                  const GetAppoinmentsCompletedEvent(),
                );
              },
              title: context.l10n.appointment_upcoming_title,
              subtitle: context.l10n.appointment_upcoming_subtitle,
              buttonName: context.l10n.appointment_book_appointment,
              onPressed: () => controller.animateToPage(
                1,
                duration: const Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn,
              ),
            );
          }
          return AppointmentList(
            infoIndex: 1,
            onRefresh: () async {
              context.read<AppoinmentsBloc>().add(
                const GetAppoinmentsCompletedEvent(),
              );
              await context.read<AppoinmentsBloc>().stream.first;
            },
            hasReachedMax:
                state.countCompleted > state.appoinmentsCompleted.length,
            appointments: state.appoinmentsCompleted,
            scrollEndFunction: () {
              context.read<AppoinmentsBloc>().add(
                const GetAppoinmentsCompletedEvent(getMore: true),
              );
            },
            paginatorStatus: state.statusCompleted,
          );
        }
        return const AppointmentShimmer();
      },
    );
  }

  BlocBuilder<AppoinmentsBloc, AppoinmentsState> _buildCanceledAppointments() {
    return BlocBuilder<AppoinmentsBloc, AppoinmentsState>(
      builder: (context, state) {
        if (state.statusCancel.isFailure) {
          return NoAppointment(
            title: context.l10n.appointment_server_error,
            subtitle: context.l10n.appointment_server_error_description,
            buttonName: context.l10n.appointment_server_error_reload,
            onPressed: () => context.read<AppoinmentsBloc>().add(
              const GetAppoinmentsCanceledEvent(),
            ),
            isServer: true,
          );
        } else if (state.statusCancel.isSuccess) {
          if (state.appoinmentsCancel.isEmpty) {
            return NoAppointment(
              onRefresh: () {
                context.read<AppoinmentsBloc>().add(
                  const GetAppoinmentsCanceledEvent(),
                );
              },
              title: context.l10n.appointment_upcoming_title,
              subtitle: context.l10n.appointment_upcoming_subtitle,
              buttonName: context.l10n.appointment_book_appointment,
              onPressed: () => controller.animateToPage(
                1,
                duration: const Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn,
              ),
            );
          }
          return AppointmentList(
            infoIndex: 2,
            onRefresh: () async {
              context.read<AppoinmentsBloc>().add(
                const GetAppoinmentsCanceledEvent(),
              );
              await context.read<AppoinmentsBloc>().stream.first;
            },
            hasReachedMax: state.countCancel > state.appoinmentsCancel.length,
            appointments: state.appoinmentsCancel,
            scrollEndFunction: () {
              context.read<AppoinmentsBloc>().add(
                const GetAppoinmentsCanceledEvent(getMore: true),
              );
            },
            paginatorStatus: state.statusCancel,
          );
        }
        return const AppointmentShimmer();
      },
    );
  }

  // BlocBuilder<CompletedAppointmentBloc, CompletedAppointmentState>
  //     _buildCompletedAppointments() {
  //   return BlocBuilder<CompletedAppointmentBloc, CompletedAppointmentState>(
  //     builder: (context, state) {
  //       if (state is CompletedAppoinmentsFailure) {
  //         return NoAppointment(
  //           title: context.l10n.appointment_server_error,
  //           subtitle: context.l10n.appointment_server_error_description,
  //           buttonName: context.l10n.appointment_server_error_reload,
  //           onPressed: () => context
  //               .read<CompletedAppointmentBloc>()
  //               .add(const GetCompletedAppoinmentsEvent(isErrorRefresh: true)),
  //           isServer: true,
  //         );
  //       } else if (state is CompletedAppoinmentSuccess) {
  //         if (state.appoinments.isEmpty) {
  //           return NoAppointment(
  //             onRefresh: () {
  //               context.read<CompletedAppointmentBloc>().add(
  //                   const GetCompletedAppoinmentsEvent(
  //                       isErrorRefresh: true, isRefresh: true));
  //             },
  //             title: context.l10n.appointment_upcoming_title,
  //             subtitle: context.l10n.appointment_upcoming_subtitle,
  //             buttonName: context.l10n.appointment_book_appointment,
  //             onPressed: () => controller.animateToPage(1,
  //                 duration: const Duration(milliseconds: 300),
  //                 curve: Curves.fastOutSlowIn),
  //           );
  //         }
  //         return AppointmentList(
  //           infoIndex: 1,
  //           onRefresh: () async {
  //             context
  //                 .read<CompletedAppointmentBloc>()
  //                 .add(const GetCompletedAppoinmentsEvent(isRefresh: true));
  //             await context.read<CompletedAppointmentBloc>().stream.first;
  //           },
  //           hasReachedMax: state.hasReachedMax,
  //           appointments: state.appoinments,
  //           scrollController: ScrollController(),
  //           scrollEndFunction: () {
  //             context
  //                 .read<CompletedAppointmentBloc>()
  //                 .add(const GetCompletedAppoinmentsEvent());
  //           },
  //         );
  //       }
  //       return const AppointmentShimmer();
  //     },
  //   );
  // }

  // BlocBuilder<CanceledAppointmentBloc, CanceledAppointmentState>
  //     _buildCanceledAppointments() {
  //   return BlocBuilder<CanceledAppointmentBloc, CanceledAppointmentState>(
  //     builder: (context, state) {
  //       if (state is CanceledAppoinmentsFailure) {
  //         return NoAppointment(
  //           title: context.l10n.appointment_server_error,
  //           subtitle: context.l10n.appointment_server_error_description,
  //           buttonName: context.l10n.appointment_server_error_reload,
  //           onPressed: () => context
  //               .read<CanceledAppointmentBloc>()
  //               .add(const GetCanceledAppoinmentsEvent(isErrorRefresh: true)),
  //           isServer: true,
  //         );
  //       } else if (state is CanceledAppoinmentSuccess) {
  //         if (state.appoinments.isEmpty) {
  //           return NoAppointment(
  //             onRefresh: () {
  //               context.read<CanceledAppointmentBloc>().add(
  //                   const GetCanceledAppoinmentsEvent(
  //                       isErrorRefresh: true, isRefresh: true));
  //             },
  //             title: context.l10n.appointment_upcoming_title,
  //             subtitle: context.l10n.appointment_upcoming_subtitle,
  //             buttonName: context.l10n.appointment_book_appointment,
  //             onPressed: () => controller.animateToPage(1,
  //                 duration: const Duration(milliseconds: 300),
  //                 curve: Curves.fastOutSlowIn),
  //           );
  //         }
  //         return AppointmentList(
  //           infoIndex: 2,
  //           onRefresh: () async {
  //             context
  //                 .read<CanceledAppointmentBloc>()
  //                 .add(const GetCanceledAppoinmentsEvent(isRefresh: true));
  //             await context.read<CanceledAppointmentBloc>().stream.first;
  //           },
  //           hasReachedMax: state.hasReachedMax,
  //           appointments: state.appoinments,
  //           scrollController: ScrollController(),
  //           scrollEndFunction: () {
  //             context
  //                 .read<CanceledAppointmentBloc>()
  //                 .add(const GetCanceledAppoinmentsEvent());
  //           },
  //         );
  //       }
  //       return const AppointmentShimmer();
  //     },
  //   );
  // }

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
                                        color: context.color.mainBlue,
                                        height: 24.h,
                                        width: 24.h,
                                      ),
                                      ScreenUtil().setHorizontalSpacing(8),
                                      Text(
                                        'Filter',
                                        style: Styles.boldTopHint.copyWith(
                                            color: context.color.mainBlue,
                                            fontSize: 16),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          */

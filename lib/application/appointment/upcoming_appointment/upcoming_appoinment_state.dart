part of 'upcoming_appoinment_bloc.dart';

abstract class UpcomingAppoinmentsState {
  final List<Appointment> appoinments;
  final bool hasReachedMax;
  const UpcomingAppoinmentsState(
      {this.appoinments = const [], this.hasReachedMax = false});
}

class UpcomingAppoinmentsInitial extends UpcomingAppoinmentsState {}

class UpcomingAppoinmentsSuccess extends UpcomingAppoinmentsState {
  const UpcomingAppoinmentsSuccess({super.appoinments, super.hasReachedMax});
}

class UpcomingAppoinmentsFailure extends UpcomingAppoinmentsState {
  final String failure;
  const UpcomingAppoinmentsFailure(
      {super.appoinments, required this.failure, super.hasReachedMax});
}

part of 'appoinment_bloc.dart';

class AppoinmentsState extends Equatable {
  final List<Appointment> appoinments;
  final List<Appointment> appoinmentsCancel;
  final List<Appointment> appoinmentsCompleted;

  final int count;
  final int countCancel;
  final int countCompleted;
  final FormzSubmissionStatus status;
  final FormzSubmissionStatus statusCompleted;
  final FormzSubmissionStatus statusCancel;

  const AppoinmentsState({
    this.appoinments = const [],
    this.appoinmentsCancel = const [],
    this.appoinmentsCompleted = const [],
    this.status = FormzSubmissionStatus.initial,
    this.statusCompleted = FormzSubmissionStatus.initial,
    this.statusCancel = FormzSubmissionStatus.initial,
    this.count = 0,
    this.countCancel = 0,
    this.countCompleted = 0,
  });

  AppoinmentsState copyWith({
    List<Appointment>? appoinments,
    List<Appointment>? appoinmentsCancel,
    List<Appointment>? appoinmentsCompleted,
    int? count,
    int? countCancel,
    int? countCompleted,
    FormzSubmissionStatus? status,
    FormzSubmissionStatus? statusCompleted,
    FormzSubmissionStatus? statusCancel,
  }) => AppoinmentsState(
    appoinments: appoinments ?? this.appoinments,
    appoinmentsCancel: appoinmentsCancel ?? this.appoinmentsCancel,
    appoinmentsCompleted: appoinmentsCompleted ?? this.appoinmentsCompleted,
    status: status ?? this.status,
    statusCompleted: statusCompleted ?? this.statusCompleted,
    statusCancel: statusCancel ?? this.statusCancel,
  );

  @override
  List<Object?> get props => [
    appoinments,
    appoinmentsCancel,
    appoinmentsCompleted,
    status,
    statusCancel,
    statusCompleted,
    count,
    countCancel,
    countCompleted,
  ];
}

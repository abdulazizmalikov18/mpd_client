part of 'show_pop_up_bloc.dart';

class ShowPopUpState extends Equatable {
  final PopStatus status;
  final String message;
  final bool showPopUp;
  const ShowPopUpState({
    required this.status,
    required this.message,
    required this.showPopUp,
  });

  ShowPopUpState copyWith({
    PopStatus? status,
    String? message,
    bool? showPopUp,
  }) =>
      ShowPopUpState(
        status: status ?? this.status,
        message: message ?? this.message,
        showPopUp: showPopUp ?? this.showPopUp,
      );
  @override
  List<Object?> get props => [showPopUp, message, status];
}

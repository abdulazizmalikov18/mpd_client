part of 'show_pop_up_bloc.dart';

@immutable
abstract class ShowPopUpEvent {}

class ShowPopUp extends ShowPopUpEvent {
  final String message;
  final bool dismissible;
  final PopStatus status;

  ShowPopUp({
    required this.message,
    required this.status,
    this.dismissible = true,
  });
}

class HidePopUp extends ShowPopUpEvent {}

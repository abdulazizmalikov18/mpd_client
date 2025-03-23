part of 'verification_bloc.dart';

abstract class VerificationEvent extends Equatable {
  const VerificationEvent();

  @override
  List<Object> get props => [];
}

class CheckCodeEvent extends VerificationEvent {
  final String code, phone;
  const CheckCodeEvent(this.phone, this.code);

  @override
  List<Object> get props => [code];
}

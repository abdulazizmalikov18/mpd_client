part of 'passport_bloc.dart';

abstract class PassportEvent extends Equatable {
  const PassportEvent();

  @override
  List<Object> get props => [];
}

class SelectPassportImage extends PassportEvent {}

class UpdatePersonalDataEvent extends PassportEvent {}

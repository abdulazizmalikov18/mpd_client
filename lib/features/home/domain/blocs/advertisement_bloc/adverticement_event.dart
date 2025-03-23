part of 'adverticement_bloc.dart';

abstract class AdverticementEvent extends Equatable {
  const AdverticementEvent();

  @override
  List<Object> get props => [];
}

class GetAdvertsEvent extends AdverticementEvent {}

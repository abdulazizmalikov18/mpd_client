part of 'adverticement_bloc.dart';

abstract class AdverticementState extends Equatable {
  final List<Adverticement> adverts;
  final bool isEnd;
  const AdverticementState({required this.adverts, this.isEnd = false});

  @override
  List<Object> get props => [adverts];
}

class AdverticementInitial extends AdverticementState {
  const AdverticementInitial({required super.adverts, super.isEnd});
}

class AdverticementLoading extends AdverticementState {
  const AdverticementLoading({required super.adverts, super.isEnd});
}

class AdverticementSuccess extends AdverticementState {
  const AdverticementSuccess({required super.adverts, super.isEnd});
}

class AdverticementFailure extends AdverticementState {
  final String failure;
  const AdverticementFailure({
    required super.adverts,
    required this.failure,
    super.isEnd,
  });
}

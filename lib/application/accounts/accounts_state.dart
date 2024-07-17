part of 'accounts_bloc.dart';

class AccountsState extends Equatable {
  final RegionAndProfessionContainer regionAndProfessionContainer;
  final UserContainer userContainer;

  const AccountsState({
    this.regionAndProfessionContainer = const RegionAndProfessionContainer(),
    this.userContainer = const UserContainer(),
  });

  @override
  List<Object> get props => [
        regionAndProfessionContainer,
        userContainer,
      ];

  AccountsState copyWith({
    RegionAndProfessionContainer? regionAndProfessionContainer,
    UserContainer? userContainer,
  }) {
    return AccountsState(
      regionAndProfessionContainer: regionAndProfessionContainer ?? this.regionAndProfessionContainer,
      userContainer: userContainer ?? this.userContainer,
    );
  }
}

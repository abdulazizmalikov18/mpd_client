import 'package:equatable/equatable.dart';

class RegionEntity extends Equatable {
  final int id;
  final String name;
  final bool isParent;
  // final Type type;
  final dynamic parent;

  const RegionEntity({
    this.id = 0,
    this.name = '',
    this.isParent = false,
    // this.type = '',
    // this.userCount = 0,
    this.parent = 0,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        isParent,
        // type,
        // userCount,
        parent,
      ];
}

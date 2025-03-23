class PaginationModel {
  final int offset, limit, status;

  const PaginationModel({this.limit = 10, this.offset = 0, this.status = 100});
}

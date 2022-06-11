abstract class GenericDataResponse<T> {
  final T data;

  const GenericDataResponse({required final this.data});

  static Type typeOf<T>() => T;
}

abstract class GenericListResponse<T> {
  final T list;

  const GenericListResponse({required final this.list});
}

import 'package:reward_app/data/response/status.dart';

class Resource<T> {
  final Status status;
  final T? data;
  final String? message;

  Resource({required this.status, this.data, this.message});

  // Factory constructors for easier usage
  static Resource<T> loading<T>() => Resource<T>(status: Status.LOADING);
  static Resource<T> completed<T>(T data) =>
      Resource<T>(status: Status.COMPLETED, data: data);
  static Resource<T> error<T>(String message) =>
      Resource<T>(status: Status.ERROR, message: message);
}

//
// class Resource<T> {
//   ResourceStatus status;
//   T? data;
//   String? message;
//
//   Resource.loading() : status = ResourceStatus.loading;
//   Resource.completed(this.data) : status = ResourceStatus.completed;
//   Resource.error(this.message) : status = ResourceStatus.error;
//
//   bool get isLoading => status == ResourceStatus.loading;
//   bool get isError => status == ResourceStatus.error;
//   bool get isCompleted => status == ResourceStatus.completed;
//   bool get isIdle => status == ResourceStatus.idle;
// }
//
// enum ResourceStatus { loading, completed, error, idle }

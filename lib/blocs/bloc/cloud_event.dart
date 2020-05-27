part of 'cloud_bloc.dart';

abstract class CloudEvent extends Equatable {
  const CloudEvent();
  @override
  List<Object> get props => [];
}

class FetchNationalData extends CloudEvent {
  @override
  String toString() => 'fetch national data';
}

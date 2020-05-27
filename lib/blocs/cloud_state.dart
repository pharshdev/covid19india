part of 'cloud_bloc.dart';

abstract class CloudState extends Equatable {
  const CloudState();
  @override
  List<Object> get props => [];
}

class CloudInitial extends CloudState {
  @override
  String toString() => 'cloud initial';
}

class NationalDataFetched extends CloudState {
  final NationalData nationalData;

  const NationalDataFetched({@required this.nationalData});

  @override
  List<Object> get props => [nationalData];

  @override
  String toString() {
    return 'national data fetched';
  }
}

class CloudError extends CloudState {
  final String error;

  const CloudError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'cloud error';
}

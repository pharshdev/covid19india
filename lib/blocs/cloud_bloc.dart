import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covid19india/models/national_data.dart';
import 'package:covid19india/repo/repo.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'cloud_event.dart';
part 'cloud_state.dart';

class CloudBloc extends Bloc<CloudEvent, CloudState> {
  final Repo repo;
  NationalData nationalData;

  CloudBloc({@required this.repo}) : assert(repo != null) {
    repo.loadPrefs();
  }
  @override
  CloudState get initialState => CloudInitial();

  @override
  Stream<CloudState> mapEventToState(
    CloudEvent event,
  ) async* {
    if (event is FetchNationalData) {
      if (nationalData != null)
        yield NationalDataFetched(nationalData: nationalData);
      final response = await repo.getNationalData();
      if (response is NationalData) {
        cacheData();
        yield NationalDataFetched(nationalData: response);
      } else {
        yield CloudError(error: '''Something's not right, try again later!''');
      }
    }
  }

  cacheData({dynamic data}) {
    if (data is NationalData) {
      nationalData = data;
      // Todo: cache in app data
    }
  }
}

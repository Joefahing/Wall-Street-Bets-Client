import '../../model/index.dart';

///This action file is responsible for containing any action
///related to fetching index data from API

class GetWSBIndexLoadingAction {}

class GetWSBIndeSuccessAction {
  final List<Index> indexes;

  GetWSBIndeSuccessAction({this.indexes});
}

class GetWSBIndexFailedAction {}

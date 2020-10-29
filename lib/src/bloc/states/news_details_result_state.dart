import 'package:equatable/equatable.dart';

abstract class NewsDetailsResultState extends Equatable {
  const NewsDetailsResultState();
}

class NewsDetailsResultInitialState extends NewsDetailsResultState {
  @override
  List<Object> get props => [];
}


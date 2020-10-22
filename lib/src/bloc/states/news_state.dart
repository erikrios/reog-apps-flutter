import 'package:equatable/equatable.dart';

abstract class NewsState extends Equatable {
  const NewsState();
}

class NewsLoadingState extends NewsState {
  @override
  List<Object> get props => [];
}

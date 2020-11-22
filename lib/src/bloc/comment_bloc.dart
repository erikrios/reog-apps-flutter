import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reog_apps_flutter/src/bloc/events/comment_event.dart';
import 'package:reog_apps_flutter/src/bloc/states/comment_state.dart';
import 'package:reog_apps_flutter/src/models/comment_result.dart';
import 'package:reog_apps_flutter/src/service/reog_apps_service.dart';
import 'package:reog_apps_flutter/src/utils/constants.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final ReogAppsService service;

  CommentBloc({@required this.service})
      : assert(service != null),
        super(CommentInitialState());

  @override
  Stream<CommentState> mapEventToState(CommentEvent event) async* {
    if (event is CommentGetEvent) {
      yield CommentLoadingState();
      try {
        Response response = await service.getComments(event.id);
        if (response.isSuccessful) {
          final CommentResult commentResult =
              CommentResult.fromJson(response.body);
          yield commentResult.data.isEmpty
              ? CommentSuccessEmptyState('No comment in this article.')
              : CommentSuccessNotEmptyState(commentResult);
        } else {
          final CommentResult commentResult =
              CommentResult.fromJson(jsonDecode(response.error));
          yield CommentErrorState(commentResult.message);
        }
      } catch (e) {
        yield CommentErrorState(e.toString());
      }
    } else {
      yield CommentLoadingState();
      try {
        String token = await getAuthToken();
        Response response = await service.postComment(
            token ?? "",
            (event as CommentPostEvent).id,
            (event as CommentPostEvent).comment.toJson());
        if (response.isSuccessful)
          this.add(CommentGetEvent((event as CommentGetEvent).id));
        else {
          final CommentResult commentResult =
              CommentResult.fromJson(jsonDecode(response.error));
          yield CommentErrorState(commentResult.message);
        }
      } catch (e) {
        yield CommentErrorState(e.toString());
      }
    }
  }
}

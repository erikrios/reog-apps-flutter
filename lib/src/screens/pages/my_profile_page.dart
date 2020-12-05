import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reog_apps_flutter/src/bloc/avatar_result_bloc.dart';
import 'package:reog_apps_flutter/src/bloc/events/avatar_result_event.dart';
import 'package:reog_apps_flutter/src/bloc/events/user_result_event.dart';
import 'package:reog_apps_flutter/src/bloc/states/avatar_result_state.dart';
import 'package:reog_apps_flutter/src/bloc/states/user_result_state.dart';
import 'package:reog_apps_flutter/src/bloc/user_result_bloc.dart';
import 'package:reog_apps_flutter/src/service/reog_apps_service.dart';
import 'package:reog_apps_flutter/src/utils/constants.dart';
import 'package:startapp/startapp.dart';

class MyProfilePage extends StatelessWidget {
  final UserResultBloc _bloc =
      UserResultBloc(service: ReogAppsService.create());

  MyProfilePage() {
    _bloc.add(UserResultFetching());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
        title: Text('my_profile'.tr()),
      ),
      body: Container(
        child: Center(
          child: BlocBuilder<UserResultBloc, UserResultState>(
            cubit: _bloc,
            builder: (BuildContext context, UserResultState state) {
              if (state is UserResultInitialState)
                return Container();
              else if (state is UserResultLoadingState)
                return _buildLoading();
              else if (state is UserResultErrorState)
                return _buildError(bloc: _bloc, state: state);
              else
                return _buildUserResult(context: context, state: state);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return CircularProgressIndicator();
  }

  Widget _buildError({UserResultBloc bloc, UserResultErrorState state}) {
    return RefreshIndicator(
      onRefresh: () {
        bloc.add(UserResultFetching());
        return;
      },
      child: Container(
        child: Center(
          child: Text(state.error),
        ),
      ),
    );
  }

  Widget _buildUserResult(
      {BuildContext context, UserResultSuccessState state}) {
    String name = state.userResult.data[0].name;
    String emailAddress = state.userResult.data[0].email;
    String memberSince = state.userResult.data[0].dateRegistered;
    String lastLogin = state.userResult.data[0].lastLogin;

    // ignore: close_sinks
    AvatarResultBloc bloc = AvatarResultBloc(service: ReogAppsService.create());
    bloc.add(AvatarResultFetching());

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocBuilder<AvatarResultBloc, AvatarResultState>(
          cubit: bloc,
          builder: (BuildContext context, AvatarResultState avatarState) {
            return SizedBox(
              width: 120,
              height: 120,
              child: CircleAvatar(
                backgroundColor: Colors.amber,
                child: avatarState is AvatarResultLoadingState
                    ? Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      )
                    : avatarState is AvatarResultErrorState
                        ? Center(
                            child: Text(
                              name[0],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40),
                            ),
                          )
                        : ClipOval(
                            child: Image.memory(
                              base64Decode(
                                  (avatarState as AvatarResultSuccessState)
                                      .avatarResult
                                      .data[0]),
                              fit: BoxFit.cover,
                            ),
                          ),
              ),
            );
          },
        ),
        SizedBox(height: 28),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 58),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textItem('name'.tr(), name),
              textItem('email_address'.tr(), emailAddress),
              textItem('member_since'.tr(), convertDate(memberSince)),
              textItem('last_login'.tr(), convertDate(lastLogin)),
            ],
          ),
        ),
        SizedBox(height: 8),
        AdBanner(),
      ],
    );
  }

  Widget textItem(String header, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: TextStyle(fontSize: 15),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Divider(
          color: Colors.black26,
        )
      ],
    );
  }
}

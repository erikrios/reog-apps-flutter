import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reog_apps_flutter/src/bloc/events/user_result_event.dart';
import 'package:reog_apps_flutter/src/bloc/states/user_result_state.dart';
import 'package:reog_apps_flutter/src/bloc/user_result_bloc.dart';
import 'package:reog_apps_flutter/src/service/reog_apps_service.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 120,
          height: 120,
          child: CircleAvatar(
            backgroundColor: Colors.brown[300],
            backgroundImage: NetworkImage(
              'https://archive.org/download/shimla_phoenix_K011P-01c_panelscan/Fromental_Conversational/F006-willow-with-embroidery-col-custom.jpg',
            ),
          ),
        ),
        SizedBox(height: 28),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 58),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textItem('name'.tr(), 'Erik Rio Setiawan'),
              textItem('email_address'.tr(), 'erikriosetiawan15@gmail.com'),
              textItem('member_since'.tr(), '2020/09/12'),
              textItem('last_login'.tr(), '2020/09/12'),
            ],
          ),
        ),
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

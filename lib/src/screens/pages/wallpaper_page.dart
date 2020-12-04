import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reog_apps_flutter/src/bloc/events/wallpaper_event.dart';
import 'package:reog_apps_flutter/src/bloc/states/wallpaper_state.dart';
import 'package:reog_apps_flutter/src/bloc/wallpaper_bloc.dart';
import 'package:reog_apps_flutter/src/screens/pages/wallpaper_details_page.dart';
import 'package:reog_apps_flutter/src/screens/widgets/brightness_menu.dart';
import 'package:reog_apps_flutter/src/screens/widgets/main_pop_up_menu.dart';
import 'package:reog_apps_flutter/src/screens/widgets/wallpaper_item.dart';
import 'package:startapp/startapp.dart';

class WallpaperPage extends StatefulWidget {
  @override
  _WallpaperPageState createState() => _WallpaperPageState();
}

class _WallpaperPageState extends State<WallpaperPage> {
  ScrollController _scrollViewController;
  WallpaperBloc _bloc;

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController();
    _bloc = BlocProvider.of<WallpaperBloc>(context);
    _bloc.add(WallpaperFetchingEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _scrollViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text('wallpaper'.tr()),
              floating: true,
              snap: true,
              forceElevated: innerBoxIsScrolled,
              actions: <Widget>[
                BrightnessMenu(),
                MainPopUpMenu(true),
              ],
            ),
          ];
        },
        body: BlocBuilder<WallpaperBloc, WallpaperState>(
          cubit: _bloc,
          builder: (BuildContext context, WallpaperState state) {
            if (state is WallpaperErrorState)
              return _buildErrorState(state, _bloc);
            else if (state is WallpaperSuccessState)
              return _buildSuccessState(state);
            else
              return _buildLoadingState();
          },
        ),
      ),
    );
  }

  Widget _buildSuccessState(WallpaperSuccessState state) => GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
        ),
        itemCount: state.wallpaperResult.data[0].urls.length,
        padding: EdgeInsets.all(3.0),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: WallpaperItem(state.wallpaperResult.data[0].urls[index]),
            onTap: () async {
              await StartApp.showInterstitialAd();
              bool result = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                return WallpaperDetailsPage(
                    state.wallpaperResult.data[0].urls[index]);
              }));
              print(result);
            },
          );
        },
      );

  Widget _buildLoadingState() => Center(child: CircularProgressIndicator());

  Widget _buildErrorState(WallpaperErrorState state, WallpaperBloc bloc) =>
      RefreshIndicator(
        onRefresh: () {
          bloc.add(WallpaperFetchingEvent());
          return;
        },
        child: Center(
          child: Text(state.error),
        ),
      );
}

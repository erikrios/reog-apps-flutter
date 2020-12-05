import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:reog_apps_flutter/src/screens/widgets/main_pop_up_menu.dart';
import 'package:reog_apps_flutter/src/utils/constants.dart';
import 'package:startapp/startapp.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

class WallpaperDetailsPage extends StatefulWidget {
  final String _url;

  WallpaperDetailsPage(this._url);

  @override
  _WallpaperDetailsPageState createState() => _WallpaperDetailsPageState(_url);
}

class _WallpaperDetailsPageState extends State<WallpaperDetailsPage> {
  final String _url;
  File file;
  bool _isLoggedIn;

  _WallpaperDetailsPageState(this._url);

  @override
  void initState() {
    super.initState();
    DefaultCacheManager().getSingleFile(_url).then((File value) {
      if (value == null) {
        DefaultCacheManager().downloadFile(_url).then((FileInfo value) {
          setState(() {
            file = value.file;
          });
        });
      } else {
        setState(() {
          file = value;
        });
      }
    });
    getAuthToken().then((value) {
      _isLoggedIn = value == null ? false : true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        _navigateBack();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                _navigateBack();
              }),
          title: Text('wallpaper'.tr()),
          actions: <Widget>[
            MainPopUpMenu(_isLoggedIn),
          ],
        ),
        body: Builder(
          builder: (context) => Container(
            child: Column(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Center(
                    child: (file == null)
                        ? CircularProgressIndicator()
                        : _loadImage(file),
                  ),
                ),
                FlatButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: () async {
                    String result =
                        await _setWallpaper(WallpaperManager.HOME_SCREEN);
                    print('Result: $result');
                    if (result.toLowerCase() == 'failed.') {
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text(result)));
                    } else {
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text(result)));
                    }
                  },
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'set_wallpaper'.tr().toUpperCase() +
                        ' (Home Screen)'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(
                  color: Colors.transparent,
                  height: 4,
                ),
                FlatButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: () async {
                    String result =
                        await _setWallpaper(WallpaperManager.LOCK_SCREEN);
                    if (result.toLowerCase() == 'failed.') {
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text(result)));
                    } else {
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text(result)));
                    }
                  },
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'set_wallpaper'.tr().toUpperCase() +
                        ' (Lock Screen)'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(
                  color: Colors.transparent,
                  height: 8,
                ),
                AdBanner(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _loadImage(File file) {
    return Image.file(
      file,
      fit: BoxFit.contain,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
    );
  }

  Future<String> _setWallpaper(int location) async {
    String result;
    try {
      result = await WallpaperManager.setWallpaperFromFile(file.path, location);
    } on PlatformException {
      result = 'Failed.';
    }
    return result;
  }

  void _navigateBack() {
    Navigator.pop(context, true);
  }
}

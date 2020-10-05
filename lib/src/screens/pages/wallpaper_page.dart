import 'package:flutter/material.dart';
import 'package:reog_apps_flutter/src/screens/pages/wallpaper_details_page.dart';
import 'package:reog_apps_flutter/src/screens/widgets/brightness_menu.dart';
import 'package:reog_apps_flutter/src/screens/widgets/main_pop_up_menu.dart';
import 'package:reog_apps_flutter/src/screens/widgets/wallpaper_item.dart';

class WallpaperPage extends StatefulWidget {
  @override
  _WallpaperPageState createState() => _WallpaperPageState();
}

class _WallpaperPageState extends State<WallpaperPage> {
  ScrollController _scrollViewController;
  List<String> _urls;

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_urls == null) {
      _urls = List<String>();
    }

    setDummyArticles();

    return Scaffold(
      body: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text('Wallpaper'),
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
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
          ),
          itemCount: _urls.length,
          padding: EdgeInsets.all(3.0),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              child: WallpaperItem(_urls[index]),
              onTap: () async {
                bool result = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return WallpaperDetailsPage(_urls[index]);
                }));
                print(result);
              },
            );
          },
        ),
      ),
    );
  }

  void setDummyArticles() {
    for (int i = 0; i < 20; i++) {
      _urls.add((i % 2 == 0)
          ? 'https://1.bp.blogspot.com/-11c9jnZJ6UE/X2tLBOww-UI/AAAAAAAAAGw/dtX0eqmMlhArj3OtOGx95SATIzn2NzE8ACLcBGAsYHQ/s266/Screenshot%2Bfrom%2B2019-10-22%2B09-29-01.png'
          : (i % 3 == 0)
              ? 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/97/The_Earth_seen_from_Apollo_17.jpg/800px-The_Earth_seen_from_Apollo_17.jpg'
              : 'https://archive.org/download/shimla_phoenix_K011P-01c_panelscan/Fromental_Conversational/F006-willow-with-embroidery-col-custom.jpg');
    }
  }
}

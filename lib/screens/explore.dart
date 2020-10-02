import 'package:flutter/material.dart';

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Explore'),
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'NEWS',
              ),
              Tab(
                text: 'SITES',
              ),
              Tab(
                text: 'FOODS',
              )
            ],
            indicatorColor: Color(0xffFEDF30),
            labelColor: Colors.white,
            labelStyle: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        body: TabBarView(children: [
          Text('News'),
          Text('Sites'),
          Text('Foods'),
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class MyProfilePage extends StatelessWidget {
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
          child: Column(
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
                margin: EdgeInsets.only(left: 48),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textItem('Name', 'Erik Rio Setiawan'),
                    textItem('Email Address', 'erikriosetiawan15@gmail.com'),
                    textItem('Member Since', '2020/09/12'),
                    textItem('Last Login', '2020/09/12'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textItem(String header, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
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

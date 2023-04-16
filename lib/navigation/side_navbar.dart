import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              "Side Menu",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.green,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/logo/AppLogo.png')
              )
            ),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text("Welcome"),
            onTap: () {

            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Setting"),
            onTap: () {

            },
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text("FeedBack"),
            onTap: () {
              
            },
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            child: Text(
              "Coming Soon",            
              style: TextStyle(
                fontFamily: 'poppins_bold',
                color: Colors.white,
                fontSize: 25,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.green,
              // image: DecorationImage(
              //   fit: BoxFit.fill,
              //   image: AssetImage('assets/logo/AppLogo.png')
              // )
            ),
          ),
          Container(
            height: 300,
            child: const Align(
              child: Text(
                'There is nothing to see here...\nSee You Next Time :)',
                style: TextStyle(
                  fontFamily: 'poppins_bold',
                  fontSize: 15,
                ),
              ),
            ),
          ),
          // ListTile(
          //   leading: Icon(Icons.input),
          //   title: Text("Welcome"),
          //   onTap: () {

          //   },
          // ),
          // ListTile(
          //   leading: Icon(Icons.settings),
          //   title: Text("Setting"),
          //   onTap: () {

          //   },
          // ),
          // ListTile(
          //   leading: Icon(Icons.border_color),
          //   title: Text("FeedBack"),
          //   onTap: () {
              
          //   },
          // )
        ],
      ),
    );
  }
}

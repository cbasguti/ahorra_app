import 'package:flutter/material.dart';

import 'Sidebar/side_menu.dart';

class MyBottomNavBar extends StatelessWidget {
  const MyBottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 20.0 * 2,
        right: 20.0 * 2,
        bottom: 20.0,
      ),
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -10),
            blurRadius: 35,
            color: Color(0xFF254587).withOpacity(0.38),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.house_outlined),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SideMenu()));
            },
          ),
          IconButton(
            icon: Icon(Icons.add_alert_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.add_box_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.bookmarks_outlined),
            onPressed: () {},
          ),
          IconButton(
              icon: Icon(Icons.person_outline),
              onPressed: () {},
          ),
        ],
      ),
    );
  }
}

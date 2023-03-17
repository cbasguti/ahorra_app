import 'package:flutter/material.dart';
import 'package:ahorra_app/vistas/my_bottom_nav_bar.dart';
import 'package:ahorra_app/vistas/menu/body.dart';

class MenuPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: Image.asset("assets/image/logo.png"),
        onPressed: () {},
      ),
    );
  }
}
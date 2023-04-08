import 'package:flutter/material.dart';
import 'package:ahorra_app/vistas/my_bottom_nav_bar.dart';
import 'package:ahorra_app/vistas/home/body.dart';

class MenuPrincipal extends StatefulWidget {
  @override
  _MenuPrincipalState createState() => _MenuPrincipalState();
}

class _MenuPrincipalState extends State<MenuPrincipal> {

  double xOffset = 0;
  double yOffset = 0;

  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        transform: Matrix4.translationValues(xOffset, yOffset, 0)
      ..scale(isDrawerOpen ? 0.85 : 1.00),
    duration: const Duration(milliseconds: 200),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(40),
    ),
      child: Scaffold(
        appBar: buildAppBar(),
        body: Body(),
        bottomNavigationBar: const MyBottomNavBar(),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      leading:
        isDrawerOpen
            ? GestureDetector(
          child: const Icon(Icons.arrow_back_ios),
          onTap: () {
            setState(() {
              xOffset = 0;
              yOffset = 0;
              isDrawerOpen = false;
            });
          },
        )
            : GestureDetector(
          child: const Icon(Icons.menu),
          onTap: () {
            setState(() {
              xOffset = 290;
              yOffset = 80;
              isDrawerOpen = true;
            });
          },
        ),
    );
  }
}
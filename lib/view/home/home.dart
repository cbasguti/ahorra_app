import 'package:ahorra_app/view/home/body.dart';
import 'package:ahorra_app/widget/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class MenuPrincipal extends StatefulWidget {
  const MenuPrincipal({super.key});

  @override
  MenuPrincipalState createState() => MenuPrincipalState();
}

class MenuPrincipalState extends State<MenuPrincipal> {
  double xOffset = 0;
  double yOffset = 0;

  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0),
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.7),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Scaffold(
        appBar: buildAppBar(),
        body: const Body(),
        bottomNavigationBar: const MyBottomNavBar(),
      ),
    );
  }


  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF082652),
      elevation: 0,
      leading: isDrawerOpen
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
                  xOffset = 300;
                  yOffset = 0;
                  isDrawerOpen = true;
                });
              },
            ),
    );
  }
}

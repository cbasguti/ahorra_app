import 'package:flutter/material.dart';

class SideMenuTile extends StatelessWidget {
  const SideMenuTile({
    super.key,
    required this.title,
    required this.icono,
  });

  final String title;
  final Icon icono;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 24),
          child: Divider(
            color: Colors.white24,
            height: 1,
          ),
        ),
        ListTile(
          leading: SizedBox(
              height: 34,
              width: 34,
              child: icono
          ),
          title: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
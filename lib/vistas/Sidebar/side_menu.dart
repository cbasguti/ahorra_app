import 'package:ahorra_app/vistas/Sidebar/side_menu_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'info_card.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 288,
        height: double.infinity,
        color: const Color(0xFF254587),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const InfoCard(
                  name: "Esteban Salas"
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text(
                  "Buscar".toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.white70),
                ),
              ),
              const SideMenuTile(
                    title: "Información",
                    icono: Icon(Icons.house_outlined)
              ),
              const SideMenuTile(
                    title: "Mis Listas",
                    icono: Icon(Icons.list_alt_outlined)
              ),
              const SideMenuTile(
                    title: "Preguntas",
                    icono: Icon(Icons.question_mark_outlined)
              ),
              const SideMenuTile(
                    title: "Programados",
                    icono: Icon(Icons.access_alarm_outlined)
              ),
              const SideMenuTile(
                    title: "Configuración",
                    icono: Icon(Icons.settings)
              ),
            ],
          ),
        ),
      ),
    );
  }
}


import 'package:ahorra_app/widget/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:ahorra_app/service/database_service.dart';

import '../view/home/home.dart';

class ConctactanosScreen extends StatefulWidget {
  const ConctactanosScreen({Key? key}) : super(key: key);

  @override
  State<ConctactanosScreen> createState() => _ConctactanosScreenState();
}

class _ConctactanosScreenState extends State<ConctactanosScreen> {
  final TextEditingController correoController = TextEditingController();
  final TextEditingController comentarioController = TextEditingController();
  final _dbService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Contactanos'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: correoController,
                decoration: InputDecoration(
                  hintText: 'Correo',
                ),
                maxLines: 1,
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: TextField(
                  controller: comentarioController,
                  decoration: InputDecoration(
                    hintText:
                        'Comentarios, Sugerencias, Quejas o Recomendaciones',
                  ),
                  maxLines: 15,
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  String name = correoController.text;
                  String comments = comentarioController.text;
                  _dbService.addCommentToDatabase(name, comments);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const AlertDialog(
                        content: Text('Comentario añadido con éxito'),
                      );
                    },
                  ).then((value) {
                    Navigator.pop(context);
                  });
                },
                child: Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

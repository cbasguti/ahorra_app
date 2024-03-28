import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';

class ChefBot extends StatefulWidget {
  const ChefBot({Key? key});

  @override
  ChefBotState createState() => ChefBotState();
}

class ChefBotState extends State<ChefBot> {
  TextEditingController _textEditingController = TextEditingController();
  List<Widget> _messageBubbles = [];
  @override
  void initState() {
    super.initState();
    OpenAI.apiKey = "ENTER-API-KEY-HERE";
  }

  Future<void> sendMessage(String message) async {
    // ignore: prefer_const_declarations
    final systemMessage = const OpenAIChatCompletionChoiceMessageModel(
      role: OpenAIChatMessageRole.assistant,
      content: 'talk like a chef',
    );

    final userMessage = OpenAIChatCompletionChoiceMessageModel(
      role: OpenAIChatMessageRole.user,
      content: message,
    );

    final requestMessages = [
      systemMessage,
      userMessage,
    ];
    try {
      // Enviar solicitud al modelo de OpenAI para obtener respuesta
      final response = await OpenAI.instance.chat
          .create(model: 'gpt-3.5-turbo', messages: requestMessages);
      setState(() {
        _messageBubbles.add(
          _buildMessageBubble(response.choices.first.message.content, false),
        );
      });
    } catch (e) {
      print("Error al enviar mensaje al bot: $e");
    }
  }

  Widget _buildMessageBubble(String message, bool isUser) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: isUser ? Colors.blueAccent : Colors.grey[200],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        message,
        style: TextStyle(
          color: isUser ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('ChefBot', style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(vertical: 10.0),
              children: _messageBubbles.reversed.toList(),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      hintText: "¿Qué vamos a preparar hoy?",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    String message = _textEditingController.text.trim();
                    if (message.isNotEmpty) {
                      setState(() {
                        _messageBubbles.add(_buildMessageBubble(message, true));
                      });
                      sendMessage(message);
                      _textEditingController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

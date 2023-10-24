import 'package:flutter/material.dart';

class ViewCometarios extends StatefulWidget {
  const ViewCometarios({super.key});

  @override
  State<ViewCometarios> createState() => _ViewCometariosState();
}

class _ViewCometariosState extends State<ViewCometarios> {
  final TextEditingController _comentarioFieldController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Comentarios",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Alinea los elementos a la izquierda
          children: [
            const Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'ddd,kk',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: _comentarioFieldController,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(color: Colors.white),
                        hintText: 'Añade un Comentario',
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

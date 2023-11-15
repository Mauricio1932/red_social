import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:red_social/features/post/domain/entities/newpost.dart';

import 'package:red_social/features/user/presentation/bloc/bloc_login/user_event.dart';

import '../../../post/presentation/bloc/newpost_bloc/newpost_bloc.dart';
import '../../../post/presentation/bloc/post_bloc/post_bloc.dart';
import '../../../post/presentation/bloc/post_bloc/post_event.dart';

import '../../../post/presentation/page/home_page.dart';
import '../bloc/bloc_login/user_bloc.dart';
import '../bloc/bloc_login/user_state.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController _textFieldController = TextEditingController();
  File? selectedFile;
  String fileName = '';

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
        fileName = result.files.single.name ?? '';
      });
    }
  }

  void _publish() async {
    List<NewPost> userData = [
      NewPost(texto: _textFieldController.text, imagen: selectedFile!),
    ];

    context.read<NewpostBloc>().add(NewPostRequest(userData[0]));
    context.read<PostBloc>().add(PostsGetRequest());
  }

  void _cerrarSesion() {
    context.read<UserBloc>().add(RemoveAuthToken());
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => const HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    File? selectedFile;
    
    Future<void> _selectFileImage() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        setState(() {
          selectedFile = File(result.files.single.path!);
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                context.read<PostBloc>().add(PostsGetRequest());
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const HomePage(),
                  ),
                );
              },
            ),
            const SizedBox(
                width: 8), // Ajusta el espacio entre el icono y el título

            const Spacer(),
          ],
        ),
        backgroundColor: Colors.black,
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state.userStatus == UserRequest.unknown) {
            context.read<UserBloc>().add(GetAuthToken());
          }
          if (state.userStatus == UserRequest.requestInProgress) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.userStatus == UserRequest.requestFailure) {}

          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 5),
                const Text(
                  "You are logged",
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
                ),
                const SizedBox(height: 30),
                if (selectedFile != null)
                  Column(
                    children: [
                      Text(
                        'Archivo a subir: $fileName',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                      const SizedBox(height: 10),
                      // Muestra el nombre del archivo en lugar de la imagen
                    ],
                  ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white),
                    controller: _textFieldController,
                    decoration: const InputDecoration(
                      labelText: 'Text',
                      labelStyle: TextStyle(color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Center(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: OutlinedButton(
                          onPressed: _pickFile,
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  1.0), // Ajusta el radio según sea necesario
                            ),
                            foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                            minimumSize: const Size(99, 40),
                            textStyle: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          child: const Text('Select file'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2.0, vertical: 10),
                        child: OutlinedButton(
                          onPressed: _publish,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  1.0), // Ajusta el radio según sea necesario
                            ),
                          ).copyWith(
                            side: MaterialStateProperty.all(const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            )),
                            minimumSize:
                                MaterialStateProperty.all(const Size(99, 40)),
                            textStyle: MaterialStateProperty.all<TextStyle>(
                              const TextStyle(
                                  fontSize: 16, color: Colors.black),
                            ),
                          ),
                          child: const Text('Post'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2.0, vertical: 10),
                        child: OutlinedButton(
                          onPressed: _cerrarSesion,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  1.0), // Ajusta el radio según sea necesario
                            ),
                          ).copyWith(
                            side: MaterialStateProperty.all(const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            )),
                            minimumSize:
                                MaterialStateProperty.all(const Size(99, 40)),
                            textStyle: MaterialStateProperty.all<TextStyle>(
                              const TextStyle(
                                  fontSize: 16, color: Colors.black),
                            ),
                          ),
                          child: const Text('Logout'),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

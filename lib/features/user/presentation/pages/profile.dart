import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
// import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:red_social/features/post/presentation/page/home_page.dart';
import 'package:red_social/features/user/presentation/bloc/bloc_login/user_event.dart';
import 'package:red_social/features/user/presentation/pages/vista_login.dart';

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

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
      });
    }
  }

  // final String userUrl = 'https://fakestoreapi.com/users';

  void _publish() async {
    String url =
        'http://localhost:3000/api/post/createPost?user_id=13248a32-2739-4734-a428-b2dd2b610ef9';
    String token ="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJsdWlzIiwiaWF0IjoxNjk3OTM2NTY2fQ.vahmIcp3v2LY97LEskVtAYrAnAVO0z4WegibFy3gw10";
    String fileName = selectedFile!.path.split('/').last;

    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      'texto': _textFieldController.text,
      'imagen':
          await MultipartFile.fromFile(selectedFile!.path, filename: fileName),
    });

    try {
      Response response = await dio.post(
        url,
        options: Options(
          headers: {'auth-token': token},
        ),
        data: formData,
      );

      if (response.statusCode == 200) {
        print("Solicitud exitosa: ${response.data}");
      } else {
        print(
            "Error en la solicitud. Código de estado: ${response.statusCode}");
      }
    } catch (e) {
      print("Error al realizar la solicitud: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const HomePage(),
                  ),
                );
              },
            ),
            const SizedBox(
                width: 8), // Ajusta el espacio entre el icono y el título
            const Text(
              'Profile',
              style: TextStyle(color: Colors.white),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.logout),
              color: Colors.white,
              onPressed: () {
                context.read<UserBloc>().add(RemoveAuthToken());
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const HomePage(),
                  ),
                );
              },
            ),
          ],
        ),
        backgroundColor: Colors.black,
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state.userStatus == UserRequest.unknown) {
            // return const Center(child: CircularProgressIndicator());
            context.read<UserBloc>().add(GetAuthToken());
          }
          if (state.userStatus == UserRequest.requestInProgress) {
            return const Center(child: CircularProgressIndicator());
          }
          // if (state.userStatus == UserRequest.requestFailure) {
          //   Navigator.pushReplacement(
          //     context,
          //     PageRouteBuilder(
          //       transitionsBuilder:
          //           (context, animation, secondaryAnimation, child) {
          //         return SlideTransition(
          //           position: Tween(
          //             begin: const Offset(
          //                 1, 0), // Cambia aquí para iniciar desde arriba
          //             end: Offset.zero,
          //           ).animate(animation),
          //           child: child,
          //         );
          //       },
          //       // ... Otros parámetros de PageRouteBuilder);

          //       pageBuilder: (_, __, ___) => const Login(),
          //     ),
          //   );
          // }
          return Center(
            child: Column(
              children: [
                // const SizedBox(height: 30),
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/images.jpeg'),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Alejandro Ocampo",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                const SizedBox(height: 5),
                const Text("¿en que estas pensando 💭? cuentanos",
                    style: TextStyle(color: Colors.white)),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: TextFormField(
                    style: const TextStyle(
                        color: Colors.white), // Color del texto de entrada
                    controller: _textFieldController,
                    decoration: const InputDecoration(
                      labelText: '¿Qué estas pensando?',
                      labelStyle: TextStyle(color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white), // Borde cuando está enfocado
                      ),
                    ),
                  ),
                ),

                // ElevatedButton(
                //   onPressed: _pickFile,
                //   child: Text('Seleccionar Archivo'),
                // ),
                const SizedBox(height: 5),
                if (selectedFile != null)
                  Image.file(
                    selectedFile!,
                    width: 200,
                    height: 200,
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 10),
                  child: OutlinedButton(
                    onPressed: _pickFile,
                    style:
                        OutlinedButton.styleFrom(foregroundColor: Colors.white)
                            .copyWith(
                      side: MaterialStateProperty.all(const BorderSide(
                        color: Colors.grey, // color del borde
                        width: 1.0, // ancho del borde
                      )),
                      minimumSize:
                          MaterialStateProperty.all(const Size(999, 40)),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                        const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                    child: const Text('Selecionar Elemento'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 10),
                  child: OutlinedButton(
                    onPressed: _publish,
                    style:
                        OutlinedButton.styleFrom(foregroundColor: Colors.white)
                            .copyWith(
                      side: MaterialStateProperty.all(const BorderSide(
                        color: Colors.grey, // color del borde
                        width: 1.0, // ancho del borde
                      )),
                      minimumSize:
                          MaterialStateProperty.all(const Size(999, 40)),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                        const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                    child: const Text('Publicar'),
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
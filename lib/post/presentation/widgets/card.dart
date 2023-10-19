import 'dart:async';

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:red_social/post/domain/entities/post.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:lottie/lottie.dart';

import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

import '../../domain/usecase/getpost_usecase.dart';
import 'media_player.dart';
// import 'comentarios.dart';

class CardContent extends StatefulWidget {
  // final Post posting;
  // const CardContent({Key? key, required this.posting}) : super(key: key);
  final Post posting;
  // const CardContent( {Key? key, required Post posting}) : super(key: key);
  const CardContent({Key? key, required this.posting}) : super(key: key);

  @override
  State<CardContent> createState() => CardContentState();
}

class CardContentState extends State<CardContent> {
  late VideoPlayerController _controller;
  late AudioPlayer audioPlayer;

  late GetAllPostUseCase getAllPostUseCase;

  String timerText = '';
  final player = AudioPlayer();
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    )..initialize().then((_) {
        setState(() {});
      });
    audioPlayer = AudioPlayer();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   // Inicia el bucle infinito al cargar el Widget
  //   startContinuousExecution();
  //   preload();
  // }

  // void preload() async {
  //   // print("hello anywhe");
  //   // final posts = await getAllPostUseCase.execute();
  //   // print("post ${posts.length}");
  // }

  // void startContinuousExecution() {
  //   Timer.periodic(const Duration(seconds: 1), (timer) {
  //     // Aquí pones el código que deseas ejecutar continuamente
  //     // print("Ejecutando algo cada segundo");
  //     miFuncion(); // Llama a tu función aquí
  //   });
  // }

  // void miFuncion() {
  //   // Código de la función que deseas ejecutar continuamente
  //   timer();
  // }

  bool isImage() {
    // Verificar si la URL termina con una extensión de imagen común
    final imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp'];
    return imageExtensions.any(widget.posting.imagen.toLowerCase().endsWith);
  }

  void toggleAudio() {
    if (isPlaying) {
      audioPlayer.pause();
    } else {
      audioPlayer.play(UrlSource(
          'http://localhost:3000/api/post/viewPost?imagen=${widget.posting.imagen}'));
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            SizedBox(width: 5),
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images.jpeg'),
            ),
            SizedBox(width: 8),
            Text(
              'Alejandro',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Spacer(),
            Icon(Icons.more_vert, color: Colors.white),
            SizedBox(
              width: 10,
            )
          ],
        ),
        const SizedBox(height: 6),
        if (isImage())
          Image.network(
            // 'https://marketplace.canva.com/EAFUDhAHQMY/2/0/1600w/canva-blue-night-girl-cartoon-desktop-wallpaper-pGxnzsOWyrE.jpg',
            'http://localhost:3000/api/post/viewPost?imagen=${widget.posting.imagen}',
            fit: BoxFit.cover,
            height: 300, // Ajusta la altura según sea necesario
          ),
        if (widget.posting.imagen.toLowerCase().endsWith('.mp3'))
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  toggleAudio(); // Reproduce o pausa el audio al tocar la imagen
                },
                // child: Lottie.network('https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json'),
                child: Lottie.asset(
                  'assets/sound.json',
                  // width: 200,
                  height: 50,
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                  // color: Colors.red, // Color de la animación

                  // Puedes ajustar más propiedades según tus necesidades
                ),
              )
            ],
          ),
        if (widget.posting.imagen.toLowerCase().endsWith('.mp4'))
            const Column(
              children: [
                // MediaPlayer(),

              ],
            ),
        Row(
          children: [
            // const SizedBox(width: 5),
            IconButton(
              icon: const Icon(
                Icons.favorite_outline,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () {
                // Acción al presionar el icono de usuario
              },
            ),

            IconButton(
              icon: const Icon(Iconsax.message4, color: Colors.white, size: 25),
              onPressed: () {
                comentarios();
              },
            ),

            const Spacer(),
            const Icon(Iconsax.save_24, color: Colors.white),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        Column(
          children: [
            const Row(
              children: [
                SizedBox(width: 10),
                Align(
                  alignment:
                      Alignment.centerLeft, // Alinea el contenido a la derecha
                  child: Text(
                    "120 Me gusta",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Row(
              children: [
                SizedBox(width: 10),
                Align(
                  alignment:
                      Alignment.centerLeft, // Alinea el contenido a la derecha
                  child: Row(
                    children: [
                      Text(
                        "alejandro.mauricio ",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Be happy!",
                        style: TextStyle(
                          color: Colors.white,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // const SizedBox(height: 3),
            const Row(
              children: [
                // print(timeago.format(fifteenAgo)); // 15 minutes ago
                SizedBox(width: 10),
                Text(
                  'Ver 1 comentario',
                  style: TextStyle(
                    inherit: true,
                    fontSize: 12.0,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            // const SizedBox(height: 2),
            Row(
              children: [
                // print(timeago.format(fifteenAgo)); // 15 minutes ago
                const SizedBox(width: 10),
                Text(
                  timerText,
                  style: const TextStyle(
                    inherit: true,
                    fontSize: 10.0,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                )
              ],
            ),
          ],
        )
      ],
    );
  }

  // final loadedTime = DateTime.now();
  // DateTime loadedTime = DateTime.now();
  // void timer() async {
  //   final now = DateTime.now();
  //   final difference = now.difference(loadedTime);
  //   final elapsedText =
  //       timeago.format(now.subtract(difference), locale: 'en_short');

  //   if (difference.inMinutes < 1) {
  //     timerText = "Subido ahora";
  //   } else {
  //     timerText = "Hace $elapsedText";
  //   }
  // }

  void comentarios() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => SegundaPantalla(),
    //   ),
    // );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    _controller.dispose();
    // _controller.dispose();
    super.dispose();
  }
}

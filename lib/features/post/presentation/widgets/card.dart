
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:red_social/features/post/domain/entities/post.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:lottie/lottie.dart';

import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

import '../../domain/usecase/getpost_usecase.dart';
import 'comentarios.dart';

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
  late ChewieController _chewieController;
  late GetAllPostUseCase getAllPostUseCase;

  String timerText = '';
  final player = AudioPlayer();
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();

    // this.setVideo();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'http://10.11.3.23:3000/api/post/viewPost?imagen=${widget.posting.imagen}'))
      ..initialize().then((_) {
        // Ensure the first frame is shown ajfter the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      autoPlay: false,
      looping: true,
      // Otras configuraciones según tus necesidades
    );
    audioPlayer = AudioPlayer();
  }

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
          'http://10.11.3.23:3000/api/post/viewPost?imagen=${widget.posting.imagen}'));
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
                  fit: BoxFit.contain,
                  // color: Colors.red, // Color de la animación

                  // Puedes ajustar más propiedades según tus necesidades
                ),
              )
            ],
          ),
        if (widget.posting.imagen.toLowerCase().endsWith('.mp4'))
          
          Chewie(controller: _chewieController),
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
                  'Ver comentarios',
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

  void comentarios() {

     Navigator.push(
            context,
            PageRouteBuilder(
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return SlideTransition(
                  position: Tween(
                    begin: const Offset(
                        1, 0), // Cambia aquí para iniciar desde arriba
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              },
              // ... Otros parámetros de PageRouteBuilder);

              pageBuilder: (_, __, ___) => const ViewCometarios(),
            ),
          );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    _controller.dispose();
    // _controller.dispose();
    super.dispose();
  }
}

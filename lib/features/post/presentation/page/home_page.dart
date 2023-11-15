// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:red_social/features/post/presentation/widgets/card.dart';

// import '../../../user/pages/login.dart';
// import '../../../user/presentation/pages/vista_login.dart';
import '../../../user/presentation/pages/profile.dart';
import '../../../user/presentation/pages/vista_login.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/post_bloc/post_bloc.dart';
import '../bloc/post_bloc/post_event.dart';
import '../bloc/post_bloc/post_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 110, 105, 105),
        elevation: 0,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 1),
            Text(
              "Social Network",
              style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state.postsStatus == PostRequest.requestInProgress) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.postsStatus == PostRequest.requestFailure) {
            return Center(
              child: Column(
        
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('There was a problem loading posts'),
                  const SizedBox(
                    height: 10,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        context.read<PostBloc>().add(PostsGetRequest());
                      },
                      child: const Text('Load again'))
                ],
              ),
            );
          }
          if (state.postsStatus == PostRequest.unknown) {
            context.read<PostBloc>().add(PostsGetRequest());
          }
          // print('${state.posts}');
          return ListView.builder(
              // padding: ,
              scrollDirection: Axis.vertical,
              itemCount: state.posts.length,
              itemBuilder: (BuildContext context, int index) {
                final posting = state.posts[index];

                return Column(
                  children: <Widget>[
                    const SizedBox(height: 20),
                    CardContent(posting: posting),
                    // CardContent(),
                  ],
                );
              });
        },
      ),
      bottomNavigationBar: _createBottonNavigationBar(),
    );
  }

  int _selectedIndex = 0;

  Widget _createBottonNavigationBar() {
    return BottomNavigationBar(
      showUnselectedLabels: false,
      backgroundColor: const Color.fromARGB(255, 110, 105, 105),

      type: BottomNavigationBarType.fixed,
      elevation: 0,
      unselectedItemColor: const Color.fromARGB(255, 255, 255, 255),
      selectedIconTheme:
          const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'home',
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Iconsax.),
        //   label: 'Search',
        // ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      // onTap: ,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // registros();
        break;
      case 1:
        login();
        break;
      case 2:
        // register();
        break;
    }
  }

  late SharedPreferences sharedPreferences;
  void login() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // sharedPreferences.setString('users', jsonEncode(token));
    String token = sharedPreferences.getString('auth_token') ?? "";

    if (token.isEmpty) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween(
                begin:
                    const Offset(1, 0), // Cambia aquí para iniciar desde arriba
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
          // ... Otros parámetros de PageRouteBuilder);

          pageBuilder: (_, __, ___) => const Login(),
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween(
                begin:
                    const Offset(1, 0), // Cambia aquí para iniciar desde arriba
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
          // ... Otros parámetros de PageRouteBuilder);

          pageBuilder: (_, __, ___) => const Profile(),
        ),
      );
    }
  }
}

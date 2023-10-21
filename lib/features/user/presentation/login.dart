// ignore_for_file: avoid_print
import 'package:animate_do/animate_do.dart';

// import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import '../../post/presentation/page/home_page.dart';

// import 'home_page.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:iconsax/iconsax.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Stack(
        children: [
         
          SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 27),
                    Image.asset(
                      "assets/ave.png",
                      width: 250,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: FadeInUp(
                        delay: const Duration(seconds: 1),
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Color(0xFFF5EDED),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              )),
                          child: SingleChildScrollView(
                            child: Container(
                              margin: const EdgeInsets.all(20.0),
                              child: Column(
                                children: <Widget>[
                                  const SizedBox(height: 30),
                                  const Text(
                                    "Inicia sesion para continuar",
                                    style: TextStyle(
                                      letterSpacing: 0.4,
                                      fontSize: 18,
                                      fontFamily: 'Montserrat',
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  correo(),
                                  const SizedBox(height: 20),
                                  password(),
                                  const SizedBox(height: 20),
                                  boton(),
                                  const SizedBox(height: 20),
                                  text(),
                                  const SizedBox(height: 30),
                                  createAccount()
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget correo() => const TextField(
        decoration: InputDecoration(
          hintText: 'E-mail',
          prefixIcon: Icon(
            Icons.person,
            color: Colors.black,
          ),
        ),
      );

  Widget password() => const TextField(
        decoration: InputDecoration(
          hintText: 'Password',
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.black,
          ),
        ),
        obscureText: true,
      );

  Widget boton() => ElevatedButton(
        onPressed: () {
          print('Se ha presionado el botón');
          loginUSer();
        },
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size(9900, 50)),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
          textStyle: MaterialStateProperty.all<TextStyle>(
            const TextStyle(fontSize: 16, color: Color.fromARGB(255, 255, 255, 255)),
          ),
        ),
        child: const Text('Login'),
      );

  Widget text() => GestureDetector(
        child: const Text("¿Olvidaste tú contraseña?",
            style: TextStyle(color: Colors.redAccent),
            textAlign: TextAlign.end),
        onTap: () {
          // goingHome();
        },
      );

  Widget createAccount() => OutlinedButton(
        onPressed: () {
          debugPrint('Received click');
        },
        style: OutlinedButton.styleFrom(foregroundColor: Colors.black).copyWith(
          side: MaterialStateProperty.all(const BorderSide(
            color: Colors.grey, // color del borde
            width: 1.0, // ancho del borde
          )),
          minimumSize: MaterialStateProperty.all(const Size(999, 40)),
          textStyle: MaterialStateProperty.all<TextStyle>(
            const TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
        child: const Text('Crear Cuenta'),
      );

  loginUSer() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (BuildContext context) => const HomePage()),
    );
  }
}

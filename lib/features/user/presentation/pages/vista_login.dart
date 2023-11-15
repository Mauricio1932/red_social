// ignore_for_file: avoid_print
import 'package:animate_do/animate_do.dart';

// import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:red_social/features/post/presentation/page/home_page.dart';
import 'package:red_social/features/user/presentation/pages/profile.dart';
import 'package:red_social/features/user/presentation/pages/register.dart';

// import '../../post/presentation/page/home_page.dart';
import '../../domain/entities/login.dart';
import '../bloc/bloc_login/user_bloc.dart';
import '../bloc/bloc_login/user_event.dart';

// import 'home_page.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:iconsax/iconsax.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // TextEditingController _nameController;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _regresar() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => const HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 243, 243),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 110, 105, 105),
        // backgroundColor: Colors.black,
        title: Row(
          children: [
            IconButton(
              onPressed: _regresar,
              icon: const Icon(Icons.arrow_back),
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ],
        ),
      ),
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
                    // const SizedBox(height: 17),

                    const SizedBox(height: 10),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          margin: const EdgeInsets.all(20.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                const SizedBox(height: 30),
                                const Text(
                                  "Inicia sesion para continuar",
                                  style: TextStyle(
                                    letterSpacing: 0.4,
                                    fontSize: 18,
                                    fontFamily: 'Montserrat',
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 30),
                                TextFormField(
                                  controller: _nameController,
                                  decoration: const InputDecoration(
                                    hintText: 'E-mail',
                                    hintStyle: TextStyle(
                                        color: Color.fromARGB(255, 0, 0,
                                            0)), // Color del texto de sugerencia
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor, ingresa tu e-mail';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  controller: _passwordController,
                                  decoration: const InputDecoration(
                                    hintText: 'Password',
                                    hintStyle:
                                        TextStyle(color: Colors.black), //
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor, ingresa tu e-mail';
                                    }
                                    return null;
                                  },
                                  obscureText: true,
                                ),
                                const SizedBox(height: 20),
                                boton(),
                                const SizedBox(height: 10),
                                createAccount()
                              ],
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

  Widget boton() => OutlinedButton(
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            // El formulario es válido, puedes realizar acciones adicionales aquí
            print('E-mail ingresado: ${_nameController.text}');
            loginUSer();
          }
        },
        style: OutlinedButton.styleFrom(
                foregroundColor: Color.fromARGB(255, 0, 0, 0))
            .copyWith(
          side: MaterialStateProperty.all(const BorderSide(
            color: Color.fromARGB(255, 0, 0, 0), // color del borde
            width: 1.0, // ancho del borde
          )),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  1.0), // Ajusta el radio según sea necesario
            ),
          ),
          minimumSize: MaterialStateProperty.all(const Size(999, 40)),
          textStyle: MaterialStateProperty.all<TextStyle>(
            const TextStyle(
                fontSize: 16, color: Color.fromARGB(255, 255, 255, 255)),
          ),
        ),
        child: const Text('Login'),
      );

  Widget createAccount() => OutlinedButton(
        onPressed: () {
          Navigator.pushReplacement(
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

              pageBuilder: (_, __, ___) => const RegisterView(),
            ),
          );
        },
        style: OutlinedButton.styleFrom(
                foregroundColor: Color.fromARGB(255, 0, 0, 0))
            .copyWith(
          side: MaterialStateProperty.all(const BorderSide(
            color: Color.fromARGB(255, 0, 0, 0), // color del borde
            width: 1.0, // ancho del borde
          )),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(1.0), // Ajusta el radio según sea necesario
      ),
    ),
          minimumSize: MaterialStateProperty.all(const Size(999, 40)),
          textStyle: MaterialStateProperty.all<TextStyle>(
            const TextStyle(
                fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
          ),
        ),
        child: const Text('Crear Cuenta'),
      );

  loginUSer() {
    List<User> userData = [
      User(
          pass: _passwordController.text,
          name: _nameController.text,
          token: ''),
    ];

    context.read<UserBloc>().add(LoginUserRequest(userData[0]));
    // context.read<UserBloc>().add(LoginUserRequest(userData[0]));
    // context.read<UserBloc>().add(GetAuthToken());
    // load_profile();
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

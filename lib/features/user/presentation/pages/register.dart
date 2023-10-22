import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:red_social/features/user/presentation/pages/vista_login.dart';

import '../../domain/entities/user.dart';
import '../bloc/bloc_create_user/create_user_bloc.dart';
import '../bloc/bloc_create_user/create_user_event.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _nombreUsuarioController =
      TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _correoElectronicoController =
      TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // bool _acceptTerms = false;

  void _regresar() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => const Login(),
      ),
    );
  }

  void profile() {
    // Navigator.of(context).pushReplacement(
    //   MaterialPageRoute(
    //     builder: (BuildContext context) => const LoginView(),
    //   ),
    // );
  }

  void enviarFormulario() {
    String nombreUsuario = _nombreUsuarioController.text;
    String lastname = _lastnameController.text;
    String correoElectronico = _correoElectronicoController.text;
    String contrasena = _contrasenaController.text;

    List<UserCreate> userData = [
      UserCreate(
          pass: contrasena,
          name: nombreUsuario,
          email: correoElectronico,
          lastname: lastname),
    ];

    context.read<CreateUserBloc>().add(CreateUserRequest(userData[0]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("jo"),),
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
                    // const SizedBox(height: 27),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: IconButton(
                            onPressed: _regresar,
                            icon: const Icon(Icons.arrow_back_ios),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
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
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: <Widget>[
                                    const SizedBox(height: 10),
                                    const Text(
                                      "Registra una cuenta",
                                      style: TextStyle(
                                        letterSpacing: 0.4,
                                        fontSize: 18,
                                        fontFamily: 'Montserrat',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    TextFormField(
                                      controller: _nombreUsuarioController,
                                      decoration: const InputDecoration(
                                        hintText: 'userName',
                                        labelText: 'userName',
                                        prefixIcon: Icon(
                                          Icons.person,
                                          color: Colors.black,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Por favor, ingresa un Username';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    TextFormField(
                                      controller: _lastnameController,
                                      decoration: const InputDecoration(
                                        hintText: 'Last Name',
                                        labelText: 'Last Name',
                                        prefixIcon: Icon(
                                          Icons.person,
                                          color: Colors.black,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Por favor, ingresa tu name';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    TextFormField(
                                      controller: _correoElectronicoController,
                                      decoration: const InputDecoration(
                                        hintText: 'E-mail',
                                        labelText: 'E-mail',
                                        prefixIcon: Icon(
                                          Icons.person,
                                          color: Colors.black,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Por favor, ingresa tu e-mail';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    TextFormField(
                                      controller: _contrasenaController,
                                      decoration: const InputDecoration(
                                        hintText: 'Password',
                                        labelText: 'Password',
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          color: Colors.black,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Por favor, ingresa un password';
                                        }
                                        return null;
                                      },
                                      obscureText: true,
                                    ),
                                    const SizedBox(height: 20),
                                    boton(),
                                    const SizedBox(height: 20),
                                    login()
                                  ],
                                ),
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

  Widget boton() => ElevatedButton(
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
          
            enviarFormulario();
            
          }
        },
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size(9900, 50)),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
          textStyle: MaterialStateProperty.all<TextStyle>(
            const TextStyle(
                fontSize: 16, color: Color.fromARGB(255, 255, 255, 255)),
          ),
        ),
        child: const Text('Create Account'),
      );
    
    Widget login() => OutlinedButton(
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

              pageBuilder: (_, __, ___) => const Login(),
            ),
          );
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
        child: const Text('Login'),
      );
}

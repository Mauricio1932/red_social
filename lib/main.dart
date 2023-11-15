import 'package:flutter/material.dart';
import 'package:red_social/features/post/presentation/page/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'comentario_usecase_config.dart';
import 'features/post/presentation/bloc/aadcomment_bloc/addcomment_bloc.dart';
import 'features/post/presentation/bloc/comentario_bloc/comentario_bloc.dart';
import 'features/post/presentation/bloc/newpost_bloc/newpost_bloc.dart';
// import 'features/user/presentation/bloc/bloc/login_bloc.dart';
import 'features/post/presentation/bloc/post_bloc/post_bloc.dart';
import 'features/user/presentation/bloc/bloc_create_user/create_user_bloc.dart';
import 'features/user/presentation/bloc/bloc_login/user_bloc.dart';
import 'login_usecase_config.dart';
import 'newpost_usecase_config.dart';
import 'post_usecase_config.dart';

void main() {
  runApp(const MyApp());
}

UseCasePostsConfig useCasePostsConfig = UseCasePostsConfig();
UseCaseUserConfig useCaseUserConfig = UseCaseUserConfig();
UseCaseNewPostsConfig newPostsConfig= UseCaseNewPostsConfig();
UseCaseComentarioConfig useCaseComentariConfig = UseCaseComentarioConfig();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AddcommentBloc(useCaseComentariConfig.newComentarioUseCase!)
          //  child: Container(),    
        ),
        BlocProvider(
          create: (BuildContext context) => ComentarioBloc(useCaseComentariConfig.getComentariosUseCase!)
          //  child: Container(),    
        ),
        BlocProvider(
          create: (BuildContext context) => NewpostBloc(newPostsConfig.postNewUseCase!)
          //  child: Container(),    
        ),
        BlocProvider(
          create: (BuildContext context) => CreateUserBloc(useCaseUserConfig.userCreateUseCase!)
          //  child: Container(),    
        ),
        BlocProvider(
          create: (BuildContext context) => UserBloc(useCaseUserConfig.loginUserUsecase!, useCaseUserConfig.removeTokenUseCase!,useCaseUserConfig.getAuthTokenUseCase!)
          //  child: Container(),    
        ),
        BlocProvider(
          create: (BuildContext context) => PostBloc(useCasePostsConfig.getAllPostUseCase!)
          //  child: Container(),    
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // scaffoldBackgroundColor: Color.fromARGB(0, 255, 255, 255),
          colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 255, 255, 255)),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomePage(),
    );
  }
}

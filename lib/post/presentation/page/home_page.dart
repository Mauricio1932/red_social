import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
// import 'package:red_social/post/domain/entities/post.dart';
import 'package:red_social/post/presentation/widgets/card.dart';

import '../bloc/post_bloc.dart';
import '../bloc/post_event.dart';
import '../bloc/post_state.dart';
// import '../widgets/card.dart';

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
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/ave.png',
              fit: BoxFit.cover,
              height: 40,
              // color: Colors.amber,
            ),
            const SizedBox(width: 1),
            const Text(
              "Send",
              style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.user, color: Colors.white),
            onPressed: () {},
          ),
          const SizedBox(
            width: 5,
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0), // Altura de la línea blanca
          child: Divider(
            color:
                Color.fromARGB(99, 255, 255, 255), // Color de la línea blanca
          ),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Problem loading products'),
                  const SizedBox(
                    height: 10,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        context.read<PostBloc>().add(PostsGetRequest());
                      },
                      child: const Text('Try again'))
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

  final int _selectedIndex = 0;
  
  Widget _createBottonNavigationBar() {
    return BottomNavigationBar(
      showUnselectedLabels: false,
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      unselectedItemColor: Color.fromARGB(255, 255, 255, 255),
      selectedIconTheme:
          const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Iconsax.home),
          label: '',
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Iconsax.),
        //   label: 'Search',
        // ),
        BottomNavigationBarItem(
          icon: Icon(Iconsax.user),
          label: 'Profile',
        ),
      ],
      selectedItemColor:const Color.fromARGB(255, 255, 255, 255),
      currentIndex: _selectedIndex,
      // onTap: ,
    );
  }
}

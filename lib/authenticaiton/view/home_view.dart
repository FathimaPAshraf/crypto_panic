import 'package:cryptoo/authenticaiton/bloc/authentication_bloc.dart';

import 'package:cryptoo/authenticaiton/view/login_view.dart';

import 'package:cryptoo/crypto_news/view/news_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeMainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                'CRYPTO',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.teal),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'NEWS',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
              ),

            ],
          ),
          actions: [
            Row(
              children: [
                // google logged user profile picture
                CircleAvatar(radius: 15,
                    backgroundImage: NetworkImage('${user?.photoURL}')),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                  icon: FaIcon(
                    // logout icon
                    FontAwesomeIcons.arrowRightFromBracket,
                  ),
                  onPressed: () =>
                      BlocProvider.of<AuthenticationBloc>(context).add(
                    AuthenticationExited(),
                  ),
                ),
              ],
            ),
          ],
        ),
        body: Center(
          //bloc consumer to navigate
          child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is AuthenticationFailure) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => LoginMainView()));
              }
            },
            builder: (context, state) {
              if (state is AuthenticationInitial) {
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(AuthenticationStarted());
                return CircularProgressIndicator(
                  color: Colors.white,
                );
              } else if (state is AuthenticationLoading) {
                return CircularProgressIndicator(
                  color: Colors.white,
                );
              } else if (state is AuthenticationSuccess) {
                return NewsScreen();
              }
              return Text('');
            },
          ),
        ),
      ),
    );
  }
}

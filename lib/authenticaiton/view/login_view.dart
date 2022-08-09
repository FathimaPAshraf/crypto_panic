import 'package:cryptoo/authenticaiton/bloc/authentication_bloc.dart';

import 'package:cryptoo/authenticaiton/view/home_view.dart';
import 'package:cryptoo/crypto_news/repository/crypto_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginMainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Builder(
          builder: (context) {
            return BlocConsumer<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state is AuthenticationSuccess) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MultiRepositoryProvider(
                        child: HomeMainView(),
                        providers: [
                          RepositoryProvider(
                            create: (context) => CryptoService(),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (state is AuthenticationFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }
              },
              buildWhen: (current, next) {
                if (next is AuthenticationSuccess) {
                  return false;
                }
                return true;
              },
              builder: (context, state) {
                //checking authentication state
                if (state is AuthenticationInitial ||
                    state is AuthenticationFailure) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Text(
                          'CRYPTO',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.orange,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'PANIC',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.black,
                            side: BorderSide(color: Colors.white),
                          ),
                          onPressed: () =>
                              BlocProvider.of<AuthenticationBloc>(context).add(
                            AuthenticationGoogleStarted(),
                          ),

                          //using font awesome icon
                          icon: FaIcon(FontAwesomeIcons.google
                          , color: Colors.indigo),

                          label: Text(
                            'Login With Google',
                            style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is AuthenticationLoading) {
                  // if state is loading showing indicator
                  return Center(
                      child: CircularProgressIndicator(
                    color: Colors.white,
                  ));
                }
                return Center(
                  child: Text(''),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

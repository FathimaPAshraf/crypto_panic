import 'package:cryptoo/authenticaiton/bloc/authentication_bloc.dart';
import 'package:cryptoo/authenticaiton/data/providers/authentication_firebase_provider.dart';
import 'package:cryptoo/authenticaiton/data/providers/google_sign_in_provider.dart';
import 'package:cryptoo/authenticaiton/repository/authenticaiton_repository.dart';
import 'package:cryptoo/authenticaiton/view/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'crypto_news/repository/crypto_services.dart';

void main() async {

  //initialize the firebase when app has started
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //to monitor current state of app

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(
        authenticationRepository: AuthenticationRepository(
          authenticationFirebaseProvider: AuthenticationFirebaseProvider(
            firebaseAuth: FirebaseAuth.instance,
          ),
          googleSignInProvider: GoogleSignInProvider(
            googleSignIn: GoogleSignIn(),
          ),
        ),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Crypto login',
        theme: ThemeData.dark().copyWith(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.black
          ),
          scaffoldBackgroundColor: Colors.black,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MultiRepositoryProvider(
          child:  HomeMainView(),
          providers: [
            RepositoryProvider(create: (context)=>CryptoService(),),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:LetMeBeYourChefFlutter/Home/homepage.dart';
import 'package:LetMeBeYourChefFlutter/Registrazione/nome_page.dart';
import 'package:LetMeBeYourChefFlutter/inizio_page.dart';
import 'package:LetMeBeYourChefFlutter/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(                         //Inizializzo firebase
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
  runApp(const MyApp());                        //Avvio app
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late StreamSubscription<User?> user;
  @override
  void initState() {          //Controllo se l'utente si è loggato in precedenza
    super.initState();
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
      } else {
      }
    });
  }

  @override
  void dispose() {        //Metodo cancellazione
    user.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(                       //Costruzione app
      title: 'LetMeBeYourChef!',
      initialRoute:
      FirebaseAuth.instance.currentUser == null ? '/' : '/homepage',      //Se utente loggato vado sulla home altrimenti all'inizio
      routes: {                                 //Rotte principali
        '/': (context) => const InizioPage(),
        '/login': (context) => const LoginPage(),
        '/registrazione': (context) => const NomePage(),
        '/homepage': (context) => const Home(title: "Login Demo"),
      },
      theme: ThemeData(
        primaryColor: Colors.blue,
        primarySwatch: Colors.blue
      ),
      //home: const MyHomePage(title: 'LetMeBeYourChefFlutter'),
    );
  }
}

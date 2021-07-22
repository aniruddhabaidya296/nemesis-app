import 'package:flutter/material.dart';
import 'package:flutter_application_1/helper/auth_service.dart';
import 'package:flutter_application_1/helper/user_model.dart';
import 'package:flutter_application_1/pages/loginpage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

import 'BLoCs/authBloc/auth_bloc.dart';
import 'BLoCs/authBloc/auth_event.dart';
import 'BLoCs/authBloc/auth_state.dart';
import 'pages/homepage.dart';
import 'pages/splashscreen.dart';

void main() {
  runApp(RepositoryProvider<AuthenticationService>(
    create: (context) {
      return FakeAuthenticationService();
    },
    // Injects the Authentication BLoC
    child: BlocProvider<AuthenticationBloc>(
      create: (context) {
        final authService =
            RepositoryProvider.of<AuthenticationService>(context);
        return AuthenticationBloc(authService)..add(AppLoaded());
      },
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  final User? user;

  MyApp({Key? key, this.user}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Authentication Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // BlocBuilder will listen to changes in AuthenticationState
      // and build an appropriate widget based on the state.
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
            // show home page
            return HomePage(
              user: state.user,
            );
          }
          // otherwise show login page
          return LoginPage();
        },
      ),
    );
  }
}

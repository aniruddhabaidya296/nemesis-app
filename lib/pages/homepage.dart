import 'package:flutter/material.dart';
import 'package:flutter_application_1/BLoCs/authBloc/auth_bloc.dart';
import 'package:flutter_application_1/BLoCs/authBloc/auth_event.dart';
import 'package:flutter_application_1/helper/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  final User user;

  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Welcome, ${user.name}',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(
                height: 12,
              ),
              MaterialButton(
                textColor: Theme.of(context).primaryColor,
                child: Text('Logout'),
                onPressed: () {
                  // Add UserLoggedOut to authentication event stream.
                  authBloc.add(UserLoggedOut());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

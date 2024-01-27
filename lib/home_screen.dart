import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_form_validation/widgets/gradient_button.dart';

import 'bloc/auth_bloc.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            (route) => false,
          );
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: [
              Center(child: Text((state as AuthSuccess).uid)),
              GradientButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthLogoutButtonPressed());
                  },
                  title: 'Sign Out'),
            ],
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pet_home_app/screens/login/bloc/login_bloc.dart';

class LoginAppBar extends StatelessWidget with PreferredSizeWidget {
  final Function popScreen;
  final LoginState state;

  const LoginAppBar({
    Key? key,
    required this.popScreen,
    required this.state,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        "Login",
      ),
      leading: IconButton(
        onPressed: () async {
          if (await popScreen(state)) {
            Navigator.pop(context);
          }
        },
        icon: const Icon(Icons.arrow_back),
        splashRadius: 23,
      ),
    );
  }
}

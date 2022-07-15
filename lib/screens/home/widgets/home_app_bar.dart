import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_home_app/blocs/auth/auth_bloc.dart';
import 'package:pet_home_app/screens/create_pet/create_pet_screen.dart';
import 'package:pet_home_app/screens/login/login_screen.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends StatelessWidget with PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return AppBar(
          title: const Text(
            "Pet Home",
            style: TextStyle(),
          ),
          actions: [
            Builder(
              builder: (context) {
                if (state is AuthAuthenticatedState) {
                  return Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          print("AAAAAAAA");
                          print(context.read<AuthBloc>());
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) =>
                          //         BlocBuilder<AuthBloc, AuthState>(
                          //       builder: (context, _state) {
                          //         return Scaffold();
                          //       },
                          //     ),
                          //   ),
                          // );
                        },
                        splashRadius: 23,
                        icon: const Icon(
                          Icons.add,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(AuthLogoutEvent());
                        },
                        splashRadius: 23,
                        icon: const Icon(
                          Icons.logout,
                        ),
                      ),
                    ],
                  );
                } else {
                  return IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    splashRadius: 23,
                    icon: const Icon(
                      Icons.login,
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}

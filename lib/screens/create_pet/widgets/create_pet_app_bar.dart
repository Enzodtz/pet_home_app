import 'package:flutter/material.dart';
import 'package:pet_home_app/screens/create_pet/bloc/create_pet_bloc.dart';

class CreatePetAppBar extends StatelessWidget with PreferredSizeWidget {
  final Function popScreen;
  final CreatePetState state;

  const CreatePetAppBar({
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
        "Create Pet",
        style: TextStyle(),
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

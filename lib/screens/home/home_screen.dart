import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pet_home_app/blocs/auth/auth_bloc.dart';
import 'package:pet_home_app/screens/home/widgets/home_app_bar.dart';
import 'package:pet_home_app/screens/home/widgets/pets_list.dart';

import 'bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          appBar: const HomeAppBar(),
          body: BlocProvider<HomeBloc>(
            create: (context) => HomeBloc(),
            child: const PetsList(),
          ),
        );
      },
    );
  }
}

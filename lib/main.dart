import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_home_app/blocs/geolocation/geolocation_bloc.dart';
import 'package:pet_home_app/screens/home/home_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pet_home_app/screens/splash_screen.dart';
import 'package:pet_home_app/widgets/geolocation_dialogs.dart';

import 'blocs/auth/auth_bloc.dart';
import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(
          create: ((context) => GeolocationBloc()),
        )
      ],
      child: MaterialApp(
        title: 'Pet Home',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              color: Colors.white,
            ),
            toolbarTextStyle: TextStyle(
              color: Colors.white,
            ),
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
          ),
          // colorScheme: const ColorScheme.dark(),
          // primarySwatch: Colors.blue,
        ),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            return BlocConsumer<GeolocationBloc, GeolocationState>(
                listener: (context, geolocationState) async {
              if (geolocationState is GeolocationFailureState) {
                if (geolocationState.exception is PermissionDeniedException) {
                  await showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return const GeoLocationPermissionDialog();
                    },
                  );
                } else if (geolocationState.exception
                    is LocationServiceDisabledException) {
                  await showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return const GeoLocationDisabledDialog();
                    },
                  );
                }

                context.read<GeolocationBloc>().add(
                      GeolocationGetCurrentEvent(),
                    );
              }
            }, builder: (context, geolocationState) {
              if (authState is AuthLoadingState ||
                  geolocationState is! GeolocationSuccessState) {
                return const SplashScreen();
              } else {
                return const HomeScreen();
              }
            });
          },
        ),
        localizationsDelegates: const [
          FormBuilderLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          // Locale('pt', ''),
          // Locale('es', ''),
          // Locale('fa', ''),
          // Locale('fr', ''),
          // Locale('ja', ''),
          // Locale('sk', ''),
          // Locale('pl', ''),
        ],
      ),
    );
  }
}

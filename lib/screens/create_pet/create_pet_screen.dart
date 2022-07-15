import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pet_home_app/blocs/auth/auth_bloc.dart';
import 'package:pet_home_app/exceptions/form_exceptions.dart';
import 'package:pet_home_app/exceptions/server_exception.dart';
import 'package:pet_home_app/screens/register/register_screen.dart';
import 'package:pet_home_app/widgets/cellphone_field.dart';
import 'package:pet_home_app/widgets/form_error_widget.dart';
import 'package:pet_home_app/widgets/success_dialog.dart';

import 'bloc/create_pet_bloc.dart';
import 'widgets/create_pet_app_bar.dart';

import 'package:geolocator/geolocator.dart';

class CreatePetScreen extends StatelessWidget {
  CreatePetScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();

  void submitForm(BuildContext context) {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final data = _formKey.currentState?.value;
      // context.read<CreatePetBloc>().add(
      //       CreatePetSubmitEvent(
      //         email: data!['email'],
      //         password: data['password'],
      //       ),
      //     );
    }
  }

  Future<bool> popScreen(state) async {
    return state is! CreatePetLoadingState;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        return BlocProvider(
          create: (context) => CreatePetBloc(),
          child: BlocConsumer<CreatePetBloc, CreatePetState>(
            listener: (context, state) {
              if (state is CreatePetSuccessState) {
                context.read<AuthBloc>().add(
                      AuthAuthenticateEvent(state.user),
                    );
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const SuccessDialog(
                      title: 'Success',
                      text: 'Your login was successful!',
                      buttonText: 'Continue',
                    );
                  },
                );
              }
            },
            builder: (context, state) {
              return WillPopScope(
                onWillPop: () => popScreen(state),
                child: Scaffold(
                  appBar: CreatePetAppBar(popScreen: popScreen, state: state),
                  body: Builder(
                    builder: (_) {
                      return Center(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: FormBuilder(
                              key: _formKey,
                              child: Builder(
                                builder: (context) {
                                  if (state is CreatePetErrorState) {
                                    if (state.exception
                                        is FormFieldsException) {
                                      for (var error in (state.exception
                                              as FormFieldsException)
                                          .errors
                                          .entries) {
                                        _formKey.currentState?.invalidateField(
                                          name: error.key,
                                          errorText: error.value,
                                        );
                                      }
                                    }
                                  }

                                  return Column(
                                    children: [
                                      Builder(builder: (context) {
                                        if (state is CreatePetErrorState) {
                                          if (state.exception
                                                  is FormGeneralException ||
                                              state.exception
                                                  is ServerException) {
                                            return Column(
                                              children: [
                                                FormErrorWidget(
                                                  (state.exception
                                                          as FormGeneralException)
                                                      .message,
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                )
                                              ],
                                            );
                                          }
                                        }
                                        return Container();
                                      }),
                                      FormBuilderTextField(
                                        name: 'name',
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Name',
                                        ),
                                        textInputAction: TextInputAction.next,
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.required(
                                              context),
                                          FormBuilderValidators.minLength(
                                              context, 3),
                                        ]),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      FormBuilderImagePicker(
                                        name: 'images',
                                        decoration: const InputDecoration(
                                          labelText: 'Select Pet Images',
                                        ),
                                        maxImages: 5,
                                        initialValue: [
                                          Image.network(
                                            'https://images.pexels.com/photos/8311418/pexels-photo-8311418.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260',
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      MaterialButton(
                                        color: Theme.of(context).primaryColor,
                                        onPressed: () {
                                          if (state is! CreatePetLoadingState) {
                                            submitForm(context);
                                          }
                                        },
                                        child: (state is CreatePetLoadingState)
                                            ? const Center(
                                                child: SizedBox(
                                                  height: 15,
                                                  width: 15,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.white,
                                                    strokeWidth: 2,
                                                  ),
                                                ),
                                              )
                                            : const SizedBox(
                                                width: double.infinity,
                                                child: Text(
                                                  'Create',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

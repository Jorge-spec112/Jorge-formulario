import 'package:flutter/material.dart';
import 'package:flutter_application_1/SuccesView.dart';
import 'package:flutter_application_1/failure.dart';
import 'package:flutter_application_1/initiall.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/formulario_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FormularioCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const InitialFormWrapper(),
      ),
    );
  }
}

class InitialFormWrapper extends StatelessWidget {
  const InitialFormWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormularioCubit, FormularioState>(
      builder: (context, state) {
        if (state is FormularioSuccess) {
          return SuccessView(
            correo: state.correo,
            contrasena: state.contrasena,
            onBack: () => context.read<FormularioCubit>().reset(),
          );
        } else if (state is FormularioFailure) {
          return FailureView(
            mensaje: state.mensaje,
            onRetry: () => context.read<FormularioCubit>().reset(),
          );
        }
        return const InitialForm();
      },
    );
  }
}

class FormularioFailure {}

class FormularioSuccess {}

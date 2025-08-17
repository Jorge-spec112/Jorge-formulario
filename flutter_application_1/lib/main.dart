import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubit/formulario_state.dart';
import 'package:flutter_application_1/pages/bloc/contador_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/formulario_cubit.dart';
import 'vistas/initiall.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (contex) => FormularioCubit()), // formulario
        BlocProvider(create: (contex) => ContadorBloc()), // contador
      ],
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
        if (state.cargando) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return const InitialForm();
      },
    );
  }
}

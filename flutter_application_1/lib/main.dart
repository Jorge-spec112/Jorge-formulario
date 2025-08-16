import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/bloc/contador_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/formulario_cubit.dart';
import 'pages/initiall.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FormularioCubit()),
        BlocProvider(create: (_) => ContadorBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: InitialForm(),
      ),
    );
  }
}

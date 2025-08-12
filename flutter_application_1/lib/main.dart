import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/cubit/formulario_cubit.dart';
import 'package:flutter_application_1/pages/initiall.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FormularioCubit(),
      child: const MaterialApp(home: Initial()),
    );
  }
}

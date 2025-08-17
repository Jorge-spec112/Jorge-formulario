import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubit/formulario_cubit.dart';
import 'package:flutter_application_1/cubit/formulario_state.dart';
import 'package:flutter_application_1/vistas/failure.dart';
import 'package:flutter_application_1/vistas/loading.dart';
import 'package:flutter_application_1/vistas/succesview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// -----------------------------
// WIDGET CONTADOR
// -----------------------------
class ContadorWidget extends StatelessWidget {
  const ContadorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormularioCubit, FormularioState>(
      builder: (context, state) {
        return Card(
          color: Colors.grey[850],
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(
                  Icons.countertops,
                  color: Colors.indigoAccent,
                  size: 30,
                ),
                const SizedBox(width: 12),
                Text(
                  "Usuarios registrados: ${state.contador}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// -----------------------------
// WIDGET USUARIOS
// -----------------------------
class UsuariosWidget extends StatelessWidget {
  const UsuariosWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormularioCubit, FormularioState>(
      builder: (context, state) {
        if (state.usuarios.isEmpty) {
          return Card(
            color: Colors.grey[850],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 6,
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "No hay usuarios registrados",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ),
          );
        }

        return Card(
          color: Colors.grey[850],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.people, color: Colors.indigoAccent, size: 28),
                    SizedBox(width: 8),
                    Text(
                      "Usuarios Registrados",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Divider(color: Colors.indigoAccent, thickness: 1),
                const SizedBox(height: 8),

                // Lista de usuarios
                ...state.usuarios.map(
                  (u) => Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.email, color: Colors.indigoAccent),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            u.correo,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const Icon(Icons.lock, color: Colors.grey),
                        const SizedBox(width: 5),
                        Text(
                          u.contrasena,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// -----------------------------
// FORMULARIO PRINCIPAL
// -----------------------------
class InitialForm extends StatefulWidget {
  const InitialForm({super.key});

  @override
  State<InitialForm> createState() => _InitialFormState();
}

class _InitialFormState extends State<InitialForm> {
  final correoController = TextEditingController();
  final contrasenaController = TextEditingController();

  @override
  void dispose() {
    correoController.dispose();
    contrasenaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formularioCubit = context.read<FormularioCubit>();

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text("Formulario"),
        backgroundColor: Colors.indigoAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // FORMULARIO
              Card(
                color: Colors.grey[850],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 6,
                shadowColor: Colors.indigoAccent.withOpacity(0.6),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextField(
                        controller: correoController,
                        decoration: const InputDecoration(
                          labelText: "Correo",
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.indigoAccent,
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: contrasenaController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: "Contraseña",
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.indigoAccent,
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // BOTÓN GUARDAR
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigoAccent,
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 24,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  // 1. Mostrar Loading
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LoadingView()),
                  );

                  await Future.delayed(const Duration(seconds: 2));

                  final correo = correoController.text;
                  final contrasena = contrasenaController.text;

                  // 2. Validar correo
                  if (correo.isEmpty || !correo.contains("@")) {
                    Navigator.pop(context); // cerrar Loading
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FailureView(
                          mensaje: "Correo inválido",
                          onRetry: () => Navigator.pop(context),
                        ),
                      ),
                    );
                  } else {
                    // 3. Registrar usuario
                    formularioCubit.actualizarDatos(correo, contrasena);
                    formularioCubit.incrementarContador();
                    formularioCubit.registrarUsuario(correo, contrasena);

                    Navigator.pop(context); // cerrar Loading
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SuccessView(
                          correo: correo,
                          contrasena: contrasena,
                          onBack: () => Navigator.pop(context),
                        ),
                      ),
                    );
                  }
                },
                child: const Text(
                  "Guardar datos",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),

              const SizedBox(height: 16),

              // CONTADOR
              const ContadorWidget(),
              const SizedBox(height: 16),

              // LISTA DE USUARIOS
              const UsuariosWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

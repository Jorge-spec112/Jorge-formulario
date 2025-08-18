import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubit/formulario_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/cubit/formulario_cubit.dart';
import 'package:flutter_application_1/vistas/failure.dart';
import 'package:flutter_application_1/vistas/loading.dart';
import 'package:flutter_application_1/vistas/succesview.dart';

// ----------------- UsuariosWidget -----------------
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

// ----------------- InitialForm -----------------
class InitialForm extends StatefulWidget {
  const InitialForm({super.key});

  @override
  State<InitialForm> createState() => _InitialFormState();
}

class _InitialFormState extends State<InitialForm>
    with SingleTickerProviderStateMixin {
  final correoController = TextEditingController();
  final contrasenaController = TextEditingController();

  bool cargandoUsuarios = false;
  bool cargandoFormulario = false;
  bool actualizando = false;

  late AnimationController _animController;
  late Animation<Color?> _colorAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
      lowerBound: 0.8,
      upperBound: 1.2,
    )..repeat(reverse: true);

    _colorAnim = ColorTween(
      begin: Colors.indigoAccent,
      end: Colors.pinkAccent,
    ).animate(_animController);
  }

  @override
  void dispose() {
    correoController.dispose();
    contrasenaController.dispose();
    _animController.dispose();
    super.dispose();
  }

  Widget _buildLoadingIcon({double size = 30}) {
    return AnimatedBuilder(
      animation: _animController,
      builder: (context, child) {
        return Transform.scale(scale: _animController.value, child: child);
      },
      child: AnimatedBuilder(
        animation: _colorAnim,
        builder: (context, child) {
          return SizedBox(
            height: size,
            width: size,
            child: CircularProgressIndicator(
              color: _colorAnim.value,
              strokeWidth: 3,
            ),
          );
        },
      ),
    );
  }

  // En actualizarSecuencial()
  Future<void> actualizarSecuencial() async {
    if (actualizando) return;
    setState(() {
      actualizando = true;
      cargandoFormulario = true; // 🔹 muestra carga en formulario
      cargandoUsuarios = false; // 🔹 usuarios en espera
    });

    // Simula carga del formulario
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      cargandoFormulario = false;
      correoController.clear();
      contrasenaController.clear();
    });

    // Usuarios
    setState(() {
      cargandoUsuarios = true; // 🔹 loading en usuarios
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      cargandoUsuarios = false;
      actualizando = false;
    });
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
      body: Stack(
        children: [
          Padding(
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
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: cargandoFormulario
                          ? SizedBox(
                              height: 100,
                              child: Center(child: _buildLoadingIcon(size: 40)),
                            )
                          : Column(
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
                      final correo = correoController.text;
                      final contrasena = contrasenaController.text;

                      if (correo.isEmpty || !correo.contains("@")) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FailureView(
                              mensaje: "Correo inválido",
                              onRetry: () => Navigator.pop(context),
                            ),
                          ),
                        );
                        return;
                      }

                      // MOSTRAR LoadingView
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LoadingView()),
                      );

                      await Future.delayed(const Duration(seconds: 2));

                      // Registrar usuario
                      formularioCubit.actualizarDatos(correo, contrasena);
                      formularioCubit.registrarUsuario(correo, contrasena);

                      // CERRAR LoadingView
                      Navigator.pop(context);

                      // Mostrar SuccessView
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
                    },
                    child: const Text(
                      "Guardar datos",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 🔹 UsuariosWidget SIEMPRE visible
                  cargandoUsuarios
                      ? _buildLoadingIcon(size: 30)
                      : const UsuariosWidget(),
                ],
              ),
            ),
          ),

          // BOTÓN ACTUALIZAR
          Positioned(
            bottom: 16,
            left: 16,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: actualizando ? Colors.grey : Colors.indigoAccent,
              onPressed: actualizando ? null : actualizarSecuencial,
              child: const Icon(Icons.refresh),
            ),
          ),
        ],
      ),
    );
  }
}

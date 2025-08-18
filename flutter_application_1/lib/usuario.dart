import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// =========================
// CUBIT Y ESTADO
// =========================
class Usuario {
  final String correo;
  final String contrasena;

  Usuario({required this.correo, required this.contrasena});
}

class FormularioState {
  final List<Usuario> usuarios;
  final int contador;

  FormularioState({required this.usuarios, required this.contador});

  FormularioState copyWith({List<Usuario>? usuarios, int? contador}) {
    return FormularioState(
      usuarios: usuarios ?? this.usuarios,
      contador: contador ?? this.contador,
    );
  }
}

class FormularioCubit extends Cubit<FormularioState> {
  FormularioCubit() : super(FormularioState(usuarios: [], contador: 0));

  void guardarUsuario(String correo, String contrasena) {
    final nuevosUsuarios = List<Usuario>.from(state.usuarios)
      ..add(Usuario(correo: correo, contrasena: contrasena));
    emit(state.copyWith(usuarios: nuevosUsuarios));
  }

  void incrementarContador() {
    emit(state.copyWith(contador: state.contador + 1));
  }

  void guardarDatos(String correo, String contrasena) {}

  void actualizarDatos(String correo, String contrasena) {}
}

// =========================
// MAIN
// =========================
void main() {
  runApp(BlocProvider(create: (_) => FormularioCubit(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InitialForm(),
    );
  }
}

// =========================
// FORMULARIO
// =========================
class InitialForm extends StatefulWidget {
  const InitialForm({super.key});

  @override
  State<InitialForm> createState() => _InitialFormState();
}

class _InitialFormState extends State<InitialForm> {
  final correoController = TextEditingController();
  final contrasenaController = TextEditingController();

  bool mostrarUsuarios = false;
  bool mostrarContador = false;
  bool mostrarCorreo = false;

  bool cargandoUsuarios = false;
  bool cargandoContador = false;
  bool cargandoCorreo = false;

  bool actualizando = false;

  Future<void> actualizarSecuencial() async {
    if (actualizando) return;
    setState(() => actualizando = true);

    // 🚀 limpiar campos para ingresar nuevo correo/contraseña
    correoController.clear();
    contrasenaController.clear();

    // Usuarios
    setState(() {
      mostrarUsuarios = true;
      cargandoUsuarios = true;
    });
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() => cargandoUsuarios = false);

    // Contador
    context.read<FormularioCubit>().incrementarContador();
    setState(() {
      mostrarContador = true;
      cargandoContador = true;
    });
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() => cargandoContador = false);

    // Correo/contraseña widget
    setState(() {
      mostrarCorreo = true;
      cargandoCorreo = true;
    });
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() => cargandoCorreo = false);

    setState(() => actualizando = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text("Formulario BLoC"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ========= FORM CORREO / CONTRASEÑA =========
            TextField(
              controller: correoController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "Correo",
                labelStyle: TextStyle(color: Colors.white70),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: contrasenaController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "Contraseña",
                labelStyle: TextStyle(color: Colors.white70),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final correo = correoController.text.trim();
                final contrasena = contrasenaController.text.trim();
                if (correo.isNotEmpty && contrasena.isNotEmpty) {
                  context.read<FormularioCubit>().guardarUsuario(
                    correo,
                    contrasena,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LoadingView()),
                  ).then((_) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SuccessView(
                          correo: correo,
                          contrasena: contrasena,
                          onBack: () => Navigator.pop(context),
                        ),
                      ),
                    );
                  });
                }
              },
              child: const Text("Guardar Datos"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: actualizando ? null : actualizarSecuencial,
              child: const Text("Actualizar Widgets"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  // ========== USUARIOS ==========
                  if (mostrarUsuarios)
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 600),
                      child: cargandoUsuarios
                          ? const Center(
                              key: ValueKey('loadingUsuarios'),
                              child: CircularProgressIndicator(),
                            )
                          : const UsuariosWidget(key: ValueKey('usuarios')),
                    ),
                  const SizedBox(height: 20),
                  // ========== CONTADOR ==========
                  if (mostrarContador)
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 600),
                      child: cargandoContador
                          ? const Center(
                              key: ValueKey('loadingContador'),
                              child: CircularProgressIndicator(),
                            )
                          : const ContadorWidget(key: ValueKey('contador')),
                    ),
                  const SizedBox(height: 20),
                  // ========== CORREO / CONTRASEÑA ==========
                  if (mostrarCorreo)
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 600),
                      child: cargandoCorreo
                          ? const Center(
                              key: ValueKey('loadingCorreo'),
                              child: CircularProgressIndicator(),
                            )
                          : CorreoContrasenaWidget(
                              correoController: correoController,
                              contrasenaController: contrasenaController,
                              key: const ValueKey('correoContrasena'),
                            ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =========================
// WIDGETS
// =========================
class UsuariosWidget extends StatelessWidget {
  const UsuariosWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormularioCubit, FormularioState>(
      builder: (context, state) {
        final usuarios = state.usuarios;
        if (usuarios.isEmpty) {
          return const Text(
            "No hay usuarios registrados",
            style: TextStyle(color: Colors.white),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: usuarios
              .map(
                (u) => Text(
                  "${u.correo} - ${u.contrasena}",
                  style: const TextStyle(color: Colors.white),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class ContadorWidget extends StatelessWidget {
  const ContadorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormularioCubit, FormularioState>(
      builder: (context, state) {
        return Text(
          "Contador: ${state.contador}",
          style: const TextStyle(color: Colors.white, fontSize: 20),
        );
      },
    );
  }
}

class CorreoContrasenaWidget extends StatelessWidget {
  final TextEditingController correoController;
  final TextEditingController contrasenaController;

  const CorreoContrasenaWidget({
    super.key,
    required this.correoController,
    required this.contrasenaController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: correoController,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            labelText: "Nuevo correo",
            labelStyle: TextStyle(color: Colors.white70),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: contrasenaController,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            labelText: "Nueva contraseña",
            labelStyle: TextStyle(color: Colors.white70),
          ),
        ),
      ],
    );
  }
}

// =========================
// LOADING VIEW
// =========================
class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
    });

    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: CircularProgressIndicator(color: Colors.white)),
    );
  }
}

// =========================
// SUCCESS VIEW
// =========================
class SuccessView extends StatelessWidget {
  final String correo;
  final String contrasena;
  final VoidCallback onBack;

  const SuccessView({
    super.key,
    required this.correo,
    required this.contrasena,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Card(
          color: Colors.grey[800],
          margin: const EdgeInsets.all(24),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 80),
                const SizedBox(height: 20),
                Text(
                  "Correo: $correo",
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  "Contraseña: $contrasena",
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),
                ElevatedButton(onPressed: onBack, child: const Text("Volver")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

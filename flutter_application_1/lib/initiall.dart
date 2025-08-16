import 'package:flutter/material.dart';
import 'package:flutter_application_1/SuccesView.dart';
import 'package:flutter_application_1/failure.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/formulario_cubit.dart';

// -----------------------------
// WIDGET CONTADOR
// -----------------------------
class ContadorWidget extends StatelessWidget {
  const ContadorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormularioCubit, FormularioState>(
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: state.cargando
              ? const Center(
                  key: ValueKey("loadingCounter"),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: CircularProgressIndicator(
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                )
              : Column(
                  key: const ValueKey("counterContent"),
                  children: [
                    Text(
                      "Contador: ${state.contador}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}

// -----------------------------
// FORMULARIO
// -----------------------------
class InitialForm extends StatefulWidget {
  const InitialForm({super.key});

  @override
  State<InitialForm> createState() => _InitialFormState();
}

class _InitialFormState extends State<InitialForm>
    with SingleTickerProviderStateMixin {
  final correoController = TextEditingController();
  final contrasenaController = TextEditingController();
  bool _obscurePassword = true;

  late AnimationController _glowController;
  late Animation<double> _glowAnimation;

  final FocusNode _correoFocus = FocusNode();
  final FocusNode _contrasenaFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 0.0, end: 8.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    _correoFocus.addListener(() => setState(() {}));
    _contrasenaFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    correoController.dispose();
    contrasenaController.dispose();
    _correoFocus.dispose();
    _contrasenaFocus.dispose();
    _glowController.dispose();
    super.dispose();
  }

  InputDecoration _neonDecoration({
    required String label,
    required IconData icon,
    Widget? suffix,
    required bool focused,
    Color color = Colors.indigoAccent,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: focused ? color : Colors.grey),
      suffixIcon: suffix,
      filled: true,
      fillColor: Colors.black.withOpacity(0.05),
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: focused ? color : Colors.grey.shade300,
          width: 2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: color, width: 2.5),
      ),
      labelStyle: TextStyle(
        color: focused ? color : Colors.grey,
        fontWeight: FontWeight.bold,
        shadows: focused
            ? [
                Shadow(
                  color: color.withOpacity(0.8),
                  blurRadius: _glowAnimation.value,
                ),
              ]
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formularioCubit = context.read<FormularioCubit>();

    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: Colors.grey[900],
          appBar: AppBar(
            title: const Text("Formulario"),
            backgroundColor: Colors.indigoAccent,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // FORMULARIO
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: Colors.grey[850],
                  elevation: 6,
                  shadowColor: Colors.indigoAccent.withOpacity(0.6),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: BlocBuilder<FormularioCubit, FormularioState>(
                      builder: (context, state) {
                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 400),
                          child: state.cargando
                              ? const Center(
                                  key: ValueKey("loadingForm"),
                                  child: Padding(
                                    padding: EdgeInsets.all(12),
                                    child: CircularProgressIndicator(
                                      color: Colors.indigoAccent,
                                    ),
                                  ),
                                )
                              : Column(
                                  key: const ValueKey("formContent"),
                                  children: [
                                    TextField(
                                      controller: correoController,
                                      focusNode: _correoFocus,
                                      decoration: _neonDecoration(
                                        label: "Correo",
                                        icon: Icons.email,
                                        focused: _correoFocus.hasFocus,
                                      ),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    const SizedBox(height: 16),
                                    TextField(
                                      controller: contrasenaController,
                                      focusNode: _contrasenaFocus,
                                      obscureText: _obscurePassword,
                                      decoration: _neonDecoration(
                                        label: "Contraseña",
                                        icon: Icons.lock,
                                        focused: _contrasenaFocus.hasFocus,
                                        suffix: IconButton(
                                          icon: Icon(
                                            _obscurePassword
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: Colors.indigoAccent,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _obscurePassword =
                                                  !_obscurePassword;
                                            });
                                          },
                                        ),
                                      ),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Column(
                                      children: [
                                        Text(
                                          "Correo: ${state.correo}",
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          "Contraseña: ${state.contrasena}",
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // -----------------------------
                // BOTÓN GUARDAR DATOS
                // -----------------------------
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
                    // 1️⃣ Mostrar loading solo en formulario
                    formularioCubit.setCargando(true);
                    await Future.delayed(const Duration(milliseconds: 500));

                    final correo = correoController.text;
                    final contrasena = contrasenaController.text;

                    if (correo.isEmpty || !correo.contains("@")) {
                      // Error → FailureView
                      formularioCubit.setCargando(false);
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
                      // Success → Actualizar datos
                      formularioCubit.actualizarDatos(correo, contrasena);
                      formularioCubit.setCargando(false);

                      // 2️⃣ Actualizar contador con loading
                      formularioCubit.setCargando(true);
                      await Future.delayed(const Duration(milliseconds: 500));
                      formularioCubit.incrementarContador();
                      formularioCubit.setCargando(false);

                      // 3️⃣ Ir a SuccessView
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

                // -----------------------------
                // WIDGET DEL CONTADOR
                // -----------------------------
                const ContadorWidget(),
              ],
            ),
          ),
        );
      },
    );
  }
}

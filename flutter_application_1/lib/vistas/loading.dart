import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  final String mensaje;

  const LoadingView({super.key, this.mensaje = "Cargando..."});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Spinner
            const CircularProgressIndicator(
              color: Colors.indigoAccent,
              strokeWidth: 4,
            ),
            const SizedBox(height: 20),
            // Mensaje
            Text(
              mensaje,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// formulario_state.dart
import 'package:flutter_application_1/usuario.dart';

class FormularioState {
  final String correo;
  final String contrasena;
  final bool cargando;
  final bool registrado;
  final int contador;
  final List<Usuario> usuarios;

  const FormularioState({
    this.correo = '',
    this.contrasena = '',
    this.cargando = false,
    this.registrado = false,
    this.contador = 0,
    this.usuarios = const [],
  });

  FormularioState copyWith({
    String? correo,
    String? contrasena,
    bool? cargando,
    bool? registrado,
    int? contador,
    List<Usuario>? usuarios,
  }) {
    return FormularioState(
      correo: correo ?? this.correo,
      contrasena: contrasena ?? this.contrasena,
      cargando: cargando ?? this.cargando,
      registrado: registrado ?? this.registrado,
      contador: contador ?? this.contador,
      usuarios: usuarios ?? this.usuarios,
    );
  }
}

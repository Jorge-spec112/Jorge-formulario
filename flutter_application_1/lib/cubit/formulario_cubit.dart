import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/usuario.dart' hide FormularioState;
import 'formulario_state.dart';

class FormularioCubit extends Cubit<FormularioState> {
  FormularioCubit() : super(const FormularioState());

  void actualizarDatos(String correo, String contrasena) {
    emit(state.copyWith(correo: correo, contrasena: contrasena));
  }

  void incrementarContador() {
    emit(state.copyWith(contador: state.contador + 1));
  }

  void registrarUsuario(String correo, String contrasena) {
    final nuevoUsuario = Usuario(correo: correo, contrasena: contrasena);
    emit(state.copyWith(usuarios: [...state.usuarios, nuevoUsuario]));
  }

  void reiniciarUsuarios() {
    emit(state.copyWith(usuarios: []));
  }

  void enviarFormulario(String text, String text2) {}

  void agregarUsuario(String correo, String contrasena) {}
}

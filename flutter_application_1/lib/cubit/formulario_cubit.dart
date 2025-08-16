import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// -----------------------------
// Estado
// -----------------------------
class FormularioState extends Equatable {
  final String correo;
  final String contrasena;
  final bool cargando;
  final int contador; // ✅ nuevo campo

  const FormularioState({
    this.correo = '',
    this.contrasena = '',
    this.cargando = false,
    this.contador = 0, // ✅ inicializado
  });

  FormularioState copyWith({
    String? correo,
    String? contrasena,
    bool? cargando,
    int? contador, // ✅ copyWith para contador
  }) {
    return FormularioState(
      correo: correo ?? this.correo,
      contrasena: contrasena ?? this.contrasena,
      cargando: cargando ?? this.cargando,
      contador: contador ?? this.contador,
    );
  }

  @override
  List<Object?> get props => [correo, contrasena, cargando, contador];

  get mensaje => null;
}

// -----------------------------
// Cubit
// -----------------------------
class FormularioCubit extends Cubit<FormularioState> {
  FormularioCubit() : super(const FormularioState());

  void setCorreo(String correo) {
    emit(state.copyWith(correo: correo));
  }

  void setContrasena(String contrasena) {
    emit(state.copyWith(contrasena: contrasena));
  }

  void setCargando(bool cargando) {
    emit(state.copyWith(cargando: cargando));
  }

  void actualizarDatos(String correo, String contrasena) {
    emit(state.copyWith(correo: correo, contrasena: contrasena));
  }

  void reset() {
    emit(const FormularioState());
  }

  // -----------------------------
  // Métodos del contador
  // -----------------------------
  void incrementarContador() {
    emit(state.copyWith(contador: state.contador + 1));
  }

  void reiniciarContador() {
    emit(state.copyWith(contador: 0));
  }
}

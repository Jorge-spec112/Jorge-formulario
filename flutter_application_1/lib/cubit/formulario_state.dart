import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Estado
class FormularioState extends Equatable {
  final String correo;
  final String contrasena;
  final bool cargando;

  const FormularioState({
    this.correo = '',
    this.contrasena = '',
    this.cargando = false,
  });

  FormularioState copyWith({
    String? correo,
    String? contrasena,
    bool? cargando,
  }) {
    return FormularioState(
      correo: correo ?? this.correo,
      contrasena: contrasena ?? this.contrasena,
      cargando: cargando ?? this.cargando,
    );
  }

  @override
  List<Object?> get props => [correo, contrasena, cargando];
}

// Cubit
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
}

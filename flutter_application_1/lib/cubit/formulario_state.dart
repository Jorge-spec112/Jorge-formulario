part of 'formulario_cubit.dart';

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

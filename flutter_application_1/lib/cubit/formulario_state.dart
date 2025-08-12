part of 'formulario_cubit.dart';

class FormularioState {
  final String correo;

  const FormularioState({this.correo = ' '});

  @override
  List<Object> get props => [correo];
}

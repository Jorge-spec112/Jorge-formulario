import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'formulario_state.dart';

class FormularioCubit extends Cubit<FormularioState> {
  FormularioCubit() : super(const FormularioState());

  void setCargando(bool cargando) {
    emit(state.copyWith(cargando: cargando));
  }

  void actualizarDatos(String correo, String contrasena) {
    emit(
      state.copyWith(correo: correo, contrasena: contrasena, cargando: false),
    );
  }
}

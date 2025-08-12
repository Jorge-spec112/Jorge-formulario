import 'package:flutter_bloc/flutter_bloc.dart';

// Estado
class FormularioState {
  final String email;
  final String password;
  final bool esValido;

  FormularioState({this.email = '', this.password = '', this.esValido = false});

  FormularioState copyWith({String? email, String? password, bool? esValido}) {
    return FormularioState(
      email: email ?? this.email,
      password: password ?? this.password,
      esValido: esValido ?? this.esValido,
    );
  }
}

// Cubit
class FormularioCubit extends Cubit<FormularioState> {
  FormularioCubit() : super(FormularioState());

  void actualizarEmail(String email) {
    emit(
      state.copyWith(
        email: email,
        esValido: _validarFormulario(email, state.password),
      ),
    );
  }

  void actualizarPassword(String password) {
    emit(
      state.copyWith(
        password: password,
        esValido: _validarFormulario(state.email, password),
      ),
    );
  }

  bool _validarFormulario(String email, String password) {
    final emailValido = email.contains("@") && email.isNotEmpty;
    final passValida = password.length >= 6;
    return emailValido && passValida;
  }

  void enviarDatos() {
    print("📤 Enviando datos...");
    print("Correo: ${state.email}");
    print("Contraseña: ${state.password}");
  }
}

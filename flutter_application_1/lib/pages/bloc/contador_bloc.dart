import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'contador_event.dart';
part 'contador_state.dart';

class ContadorBloc extends Bloc<ContadorEvent, ContadorState> {
  ContadorBloc() : super(const ContadorState()) {
    on<Incrementar>((event, emit) {
      emit(state.copyWith(contador: state.contador + 1, cargando: false));
    });

    on<SetCargando>((event, emit) {
      emit(state.copyWith(cargando: event.cargando));
    });
  }
}

part of 'contador_bloc.dart';

abstract class ContadorEvent extends Equatable {
  const ContadorEvent();

  @override
  List<Object> get props => [];
}

class Incrementar extends ContadorEvent {}

class SetCargando extends ContadorEvent {
  final bool cargando;
  const SetCargando(this.cargando);

  @override
  List<Object> get props => [cargando];
}

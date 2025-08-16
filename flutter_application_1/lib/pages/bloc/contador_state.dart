part of 'contador_bloc.dart';

class ContadorState extends Equatable {
  final int contador;
  final bool cargando;

  const ContadorState({this.contador = 0, this.cargando = false});

  ContadorState copyWith({int? contador, bool? cargando}) {
    return ContadorState(
      contador: contador ?? this.contador,
      cargando: cargando ?? this.cargando,
    );
  }

  @override
  List<Object> get props => [contador, cargando];
}

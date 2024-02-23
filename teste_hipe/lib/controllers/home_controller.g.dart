// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeController on HomeControllerBase, Store {
  late final _$dataListaAtom =
      Atom(name: 'HomeControllerBase.dataLista', context: context);

  @override
  DateTime get dataLista {
    _$dataListaAtom.reportRead();
    return super.dataLista;
  }

  @override
  set dataLista(DateTime value) {
    _$dataListaAtom.reportWrite(value, super.dataLista, () {
      super.dataLista = value;
    });
  }

  late final _$tipoAtom =
      Atom(name: 'HomeControllerBase.tipo', context: context);

  @override
  String get tipo {
    _$tipoAtom.reportRead();
    return super.tipo;
  }

  @override
  set tipo(String value) {
    _$tipoAtom.reportWrite(value, super.tipo, () {
      super.tipo = value;
    });
  }

  late final _$listasPendentesAtom =
      Atom(name: 'HomeControllerBase.listasPendentes', context: context);

  @override
  List<Lista> get listasPendentes {
    _$listasPendentesAtom.reportRead();
    return super.listasPendentes;
  }

  @override
  set listasPendentes(List<Lista> value) {
    _$listasPendentesAtom.reportWrite(value, super.listasPendentes, () {
      super.listasPendentes = value;
    });
  }

  late final _$listasEnviadasAtom =
      Atom(name: 'HomeControllerBase.listasEnviadas', context: context);

  @override
  List<Lista> get listasEnviadas {
    _$listasEnviadasAtom.reportRead();
    return super.listasEnviadas;
  }

  @override
  set listasEnviadas(List<Lista> value) {
    _$listasEnviadasAtom.reportWrite(value, super.listasEnviadas, () {
      super.listasEnviadas = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'HomeControllerBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$newListaAsyncAction =
      AsyncAction('HomeControllerBase.newLista', context: context);

  @override
  Future newLista() {
    return _$newListaAsyncAction.run(() => super.newLista());
  }

  late final _$carregarListasAsyncAction =
      AsyncAction('HomeControllerBase.carregarListas', context: context);

  @override
  Future carregarListas() {
    return _$carregarListasAsyncAction.run(() => super.carregarListas());
  }

  late final _$deletarListaAsyncAction =
      AsyncAction('HomeControllerBase.deletarLista', context: context);

  @override
  Future deletarLista(int index) {
    return _$deletarListaAsyncAction.run(() => super.deletarLista(index));
  }

  late final _$editarListaAsyncAction =
      AsyncAction('HomeControllerBase.editarLista', context: context);

  @override
  Future editarLista(int index, Lista lista) {
    return _$editarListaAsyncAction.run(() => super.editarLista(index, lista));
  }

  late final _$enviarListaAsyncAction =
      AsyncAction('HomeControllerBase.enviarLista', context: context);

  @override
  Future enviarLista(int index, Lista lista) {
    return _$enviarListaAsyncAction.run(() => super.enviarLista(index, lista));
  }

  late final _$logoutAsyncAction =
      AsyncAction('HomeControllerBase.logout', context: context);

  @override
  Future<dynamic> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  @override
  String toString() {
    return '''
dataLista: ${dataLista},
tipo: ${tipo},
listasPendentes: ${listasPendentes},
listasEnviadas: ${listasEnviadas},
isLoading: ${isLoading}
    ''';
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lista_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ListaController on ListaControllerBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'ListaControllerBase.isLoading', context: context);

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

  late final _$listaAtom =
      Atom(name: 'ListaControllerBase.lista', context: context);

  @override
  Lista get lista {
    _$listaAtom.reportRead();
    return super.lista;
  }

  bool _listaIsInitialized = false;

  @override
  set lista(Lista value) {
    _$listaAtom.reportWrite(value, _listaIsInitialized ? super.lista : null,
        () {
      super.lista = value;
      _listaIsInitialized = true;
    });
  }

  late final _$dataValidadeAtom =
      Atom(name: 'ListaControllerBase.dataValidade', context: context);

  @override
  DateTime get dataValidade {
    _$dataValidadeAtom.reportRead();
    return super.dataValidade;
  }

  @override
  set dataValidade(DateTime value) {
    _$dataValidadeAtom.reportWrite(value, super.dataValidade, () {
      super.dataValidade = value;
    });
  }

  late final _$newItemAsyncAction =
      AsyncAction('ListaControllerBase.newItem', context: context);

  @override
  Future<dynamic> newItem() {
    return _$newItemAsyncAction.run(() => super.newItem());
  }

  late final _$editarItemAsyncAction =
      AsyncAction('ListaControllerBase.editarItem', context: context);

  @override
  Future editarItem(int index) {
    return _$editarItemAsyncAction.run(() => super.editarItem(index));
  }

  late final _$deleteItemAsyncAction =
      AsyncAction('ListaControllerBase.deleteItem', context: context);

  @override
  Future deleteItem(int index) {
    return _$deleteItemAsyncAction.run(() => super.deleteItem(index));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
lista: ${lista},
dataValidade: ${dataValidade}
    ''';
  }
}

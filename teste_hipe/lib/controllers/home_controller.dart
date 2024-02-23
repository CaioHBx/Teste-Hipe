import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:teste_hipe/controllers/auth_controller.dart';
import 'package:teste_hipe/models/lista_model.dart';
import 'package:teste_hipe/models/user_model.dart';
import 'package:teste_hipe/repositories/lista_repository.dart';

part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {
  final ListaRepository _listaRepository = ListaRepository();

  @observable
  DateTime dataLista = DateTime.now();

  @observable
  String tipo = 'Contagem';

  List<String> tipos = ['Contagem', 'Auditoria'];

  TextEditingController unidadeController = TextEditingController();

  @observable
  List<Lista> listasPendentes = [];

  @observable
  List<Lista> listasEnviadas = [];

  @observable
  bool isLoading = false;

  clearVariables() {
    dataLista = DateTime.now();
    tipo = 'Contagem';
    unidadeController.clear();
  }

  @action
  newLista() async {
    var lista = Lista(
      data: dataLista,
      unidade: unidadeController.text,
      tipo: tipo,
      enviada: false,
      itens: [],
    );
    var response = await _listaRepository.newLista(lista);
    clearVariables();
    return response;
  }

  @action
  carregarListas() async {
    isLoading = true;
    listasPendentes = await _listaRepository.carregarListasPendentes();
    listasEnviadas = await _listaRepository.carregarListasEnviadas();
    isLoading = false;
  }

  @action
  deletarLista(int index) async {
    await _listaRepository.deletarLista(index);
  }

  @action
  editarLista(int index, Lista lista) async {
    var listaEditada =
        lista.copyWith(data: dataLista, unidade: unidadeController.text);
    await _listaRepository.editarLista(index, listaEditada);
  }

  @action
  enviarLista(int index, Lista lista) async {
    await _listaRepository.enviarLista(index, lista.copyWith(enviada: true));
  }

  @action
  Future logout() async {
    var box = await Hive.openBox<User>('User');
    await box.clear();
    userLogado = null;
  }
}

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:teste_hipe/models/item_model.dart';
import 'package:teste_hipe/models/lista_model.dart';
import 'package:teste_hipe/repositories/lista_repository.dart';

part 'lista_controller.g.dart';

class ListaController = ListaControllerBase with _$ListaController;

abstract class ListaControllerBase with Store {
  final ListaRepository _listaRepository = ListaRepository();

  @observable
  bool isLoading = false;

  @observable
  late Lista lista;

  late int indexLista;

  final TextEditingController codigoBarrasTextController =
      TextEditingController();

  final TextEditingController quantidadeEmbalagemTextController =
      TextEditingController();

  final TextEditingController quantidadeTextController =
      TextEditingController();

  @observable
  DateTime dataValidade = DateTime.now();

  clearVariables() {
    dataValidade = DateTime.now();
    codigoBarrasTextController.clear();
    quantidadeEmbalagemTextController.clear();
    quantidadeTextController.clear();
  }

  @action
  Future newItem() async {
    isLoading = true;
    var item = Item(
      codigoBarras: codigoBarrasTextController.text,
      dataValidade: dataValidade,
      quantidadePorEmbalagem: quantidadeEmbalagemTextController.text,
      quantidade: quantidadeTextController.text,
    );
    lista.itens.add(item);
    await _listaRepository.editarLista(indexLista, lista);
    lista = lista;
    isLoading = false;
  }

  @action
  editarItem(int index) async {
    isLoading = true;
    var item = Item(
      codigoBarras: codigoBarrasTextController.text,
      dataValidade: dataValidade,
      quantidadePorEmbalagem: quantidadeEmbalagemTextController.text,
      quantidade: quantidadeTextController.text,
    );
    lista.itens[index] = item;
    await _listaRepository.editarLista(indexLista, lista);
    lista = lista;
    isLoading = false;
  }

  @action
  deleteItem(int index) async {
    isLoading = true;
    lista.itens.removeAt(index);
    await _listaRepository.editarLista(indexLista, lista);
    lista = lista;
    isLoading = false;
  }
}

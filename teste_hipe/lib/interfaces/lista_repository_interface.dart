import 'dart:async';

import 'package:teste_hipe/models/lista_model.dart';

abstract class IlistaRepository {
  Future newLista(Lista lista);
  Future carregarListasPendentes();
  Future carregarListasEnviadas();
  Future enviarLista(int index, Lista lista);
  Future deletarLista(int index);
  Future editarLista(int index, Lista lista);
}

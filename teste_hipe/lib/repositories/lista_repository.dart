import 'package:hive/hive.dart';
import 'package:teste_hipe/controllers/auth_controller.dart';
import 'package:teste_hipe/interfaces/lista_repository_interface.dart';
import 'package:teste_hipe/models/lista_model.dart';

class ListaRepository extends IlistaRepository {
  @override
  Future newLista(Lista lista) async {
    var box = await Hive.openBox<Lista>('${userLogado?.email} ListasBox');
    var response = await box.add(lista);
    return {'index': response, 'lista': lista};
  }

  @override
  Future carregarListasPendentes() async {
    var box = await Hive.openBox<Lista>('${userLogado?.email} ListasBox');
    List<Lista> listas = box.values.toList();
    return listas;
  }

  @override
  Future carregarListasEnviadas() async {
    var box = await Hive.openBox<Lista>('${userLogado?.email} ListasEnvBox');
    List<Lista> listas = box.values.toList();
    return listas;
  }

  @override
  Future deletarLista(int index) async {
    var box = await Hive.openBox<Lista>('${userLogado?.email} ListasBox');
    await box.deleteAt(index);
  }

  @override
  Future editarLista(int index, Lista lista) async {
    var box = await Hive.openBox<Lista>('${userLogado?.email} ListasBox');
    await box.putAt(index, lista);
  }

  @override
  Future enviarLista(int index, Lista lista) async {
    deletarLista(index);
    var boxEnviadas =
        await Hive.openBox<Lista>('${userLogado?.email} ListasEnvBox');
    await boxEnviadas.add(lista);
  }
}

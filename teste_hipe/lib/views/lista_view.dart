import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:teste_hipe/controllers/lista_controller.dart';
import 'package:teste_hipe/models/item_model.dart';
import 'package:teste_hipe/utils/utils.dart';
import 'package:teste_hipe/utils/widgets.dart';

class ListaView extends StatefulWidget {
  const ListaView({super.key, required this.args});

  final Map<String, dynamic> args;

  @override
  State<ListaView> createState() => _ListaViewState();
}

class _ListaViewState extends State<ListaView> {
  late ListaController _listaController;
  @override
  void initState() {
    _listaController = ListaController();
    _listaController.indexLista = widget.args['index'];
    _listaController.lista = widget.args['lista'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista selecionada'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Observer(
              builder: (context) {
                return Card(
                  child: SizedBox(
                    width: double.maxFinite,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Unidade: ${_listaController.lista.unidade}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Data: ${formatarData(_listaController.lista.data)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Tipo: ${_listaController.lista.tipo}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Enviada: ${_listaController.lista.enviada ? 'Sim' : 'Não'}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Quantidade de Itens: ${_listaController.lista.itens.length}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Observer(
                  builder: (context) {
                    if (_listaController.lista.itens.isNotEmpty) {
                      return ListView.separated(
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          Item item = _listaController.lista.itens[index];
                          return ListTile(
                            leading: const Icon(Icons.archive_outlined),
                            title: const Text('Código do Item:'),
                            subtitle: Text(item.codigoBarras.toString()),
                            onTap: () {
                              showModal(context, item, index);
                            },
                          );
                        },
                        itemCount: _listaController.lista.itens.length,
                      );
                    } else if (_listaController.isLoading) {
                      return const Center(
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text('Nenhum item adicionado'),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: !_listaController.lista.enviada,
        child: FloatingActionButton(
          onPressed: () {
            _listaController.clearVariables();
            showDialog(
              context: context,
              builder: (context) {
                return NewEditItemDialog(
                  listaController: _listaController,
                  onConfirm: () {
                    _listaController.newItem();
                    Navigator.pop(context);
                  },
                  isEdit: false,
                );
              },
            );
          },
          tooltip: 'Adicionar novo item',
          heroTag: 'Nova item',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void showModal(BuildContext context, Item item, int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 210,
          width: double.maxFinite,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            insetPadding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            title: const Text('Visualizar Item'),
                            content: SizedBox(
                              width: double.maxFinite,
                              height: 190,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Código de Barras:\n${item.codigoBarras}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Data de Validade: ${formatarData(item.dataValidade)}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Quantidade por Embalagem: ${item.quantidadePorEmbalagem}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Quantidade: ${item.quantidade}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Fechar'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('Ver'),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: _listaController.lista.enviada
                        ? null
                        : () {
                            Navigator.pop(context);
                            _listaController.codigoBarrasTextController.text =
                                item.codigoBarras.toString();
                            _listaController.dataValidade = item.dataValidade;
                            _listaController.quantidadeEmbalagemTextController
                                .text = item.quantidadePorEmbalagem.toString();
                            _listaController.quantidadeTextController.text =
                                item.quantidade.toString();
                            showDialog(
                              context: context,
                              builder: (context) {
                                return NewEditItemDialog(
                                  listaController: _listaController,
                                  onConfirm: () {
                                    _listaController.editarItem(index);
                                    Navigator.pop(context);
                                  },
                                  isEdit: true,
                                );
                              },
                            );
                          },
                    child: const Text('Editar'),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: _listaController.lista.enviada
                        ? null
                        : () {
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Atenção'),
                                  content: const Text(
                                      'Tem certeza que deseja excluir esse item?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        'Cancelar',
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        _listaController.deleteItem(index);
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        'Confirmar',
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                    child: const Text('Excluir'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

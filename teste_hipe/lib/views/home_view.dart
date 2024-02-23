import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:teste_hipe/controllers/auth_controller.dart';
import 'package:teste_hipe/controllers/home_controller.dart';
import 'package:teste_hipe/models/lista_model.dart';
import 'package:teste_hipe/utils/utils.dart';
import 'package:teste_hipe/utils/widgets.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeController _homeController;

  @override
  void initState() {
    _homeController = HomeController();
    _homeController.carregarListas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              DrawerHeader(
                child: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.account_circle,
                        color: Colors.grey,
                        size: 64,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        userLogado?.nome ?? 'Nome não identificado.',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(userLogado?.email ?? 'E-mail não identificado.')
                    ],
                  ),
                ),
              ),
              ListTile(
                title: const Text('Sair'),
                subtitle: const Text('Realizar logout do sistema'),
                leading: const Icon(Icons.logout_outlined),
                onTap: () {
                  _homeController.logout().then((value) =>
                      Navigator.pushReplacementNamed(context, '/login'));
                },
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text('Listas'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Pendentes',
              ),
              Tab(
                text: 'Enviadas',
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Scaffold(
              body: Observer(
                builder: (context) {
                  if (_homeController.listasPendentes.isNotEmpty) {
                    return ListView.separated(
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        Lista lista = _homeController.listasPendentes[index];
                        return ListTile(
                          leading: const Icon(Icons.list_alt),
                          title: Text('Unidade: ${lista.unidade}'),
                          subtitle: Text(
                            'Data: ${formatarData(lista.data)}',
                          ),
                          onTap: () {
                            showModal(context, index, lista);
                          },
                        );
                      },
                      itemCount: _homeController.listasPendentes.length,
                    );
                  } else if (_homeController.isLoading) {
                    return const Center(
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text('Nenhuma lista adicionada'),
                    );
                  }
                },
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return NewEditListaDialog(
                        homeController: _homeController,
                        isEdit: false,
                        onConfirm: () {
                          _homeController.newLista().then((value) =>
                              Navigator.pushNamed(context, '/lista',
                                  arguments: value));
                          Navigator.pop(context);
                          _homeController.carregarListas();
                        },
                      );
                    },
                  );
                },
                tooltip: 'Adicionar nova lista',
                heroTag: 'Nova lista',
                child: const Icon(Icons.add),
              ),
            ),
            Scaffold(
              body: Observer(
                builder: (context) {
                  if (_homeController.listasEnviadas.isNotEmpty) {
                    return ListView.separated(
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        Lista lista = _homeController.listasEnviadas[index];
                        return ListTile(
                          leading: const Icon(Icons.list_alt),
                          title: Text('Unidade: ${lista.unidade}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Data: ${formatarData(lista.data)}',
                              ),
                              Text('Quantidade de Itens: ${lista.itens.length}')
                            ],
                          ),
                          onTap: () {
                            showModal(context, index, lista);
                          },
                        );
                      },
                      itemCount: _homeController.listasEnviadas.length,
                    );
                  } else if (_homeController.isLoading) {
                    return const Center(
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text('Nenhuma lista enviada'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showModal(BuildContext context, int index, Lista lista) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
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
                      Navigator.pushNamed(context, '/lista', arguments: {
                        'index': index,
                        'lista': lista,
                      }).then((value) {
                        _homeController.carregarListas();
                      });
                    },
                    child: const Text('Visualizar'),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: lista.enviada
                        ? null
                        : () {
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Atenção'),
                                  content: const Text(
                                    'Tem certeza que deseja excluir essa lista?',
                                  ),
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
                                        _homeController.deletarLista(index);
                                        _homeController.carregarListas();
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
                const SizedBox(height: 10),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: lista.enviada
                        ? null
                        : () {
                            _homeController.enviarLista(index, lista);
                            _homeController.carregarListas();
                            Navigator.pop(context);
                          },
                    child: const Text('Sincronizar'),
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

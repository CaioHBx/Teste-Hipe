import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:teste_hipe/controllers/home_controller.dart';
import 'package:teste_hipe/controllers/lista_controller.dart';
import 'package:teste_hipe/utils/utils.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final Icon icon;
  final String labelName;
  final bool isObscure;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  const MyTextFormField({
    super.key,
    required this.controller,
    required this.icon,
    required this.labelName,
    this.keyboardType,
    this.isObscure = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(labelName),
        ),
        const SizedBox(height: 10),
        TextFormField(
          keyboardType: keyboardType,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            prefixIcon: icon,
            filled: true,
            fillColor: Colors.white,
          ),
          controller: controller,
          obscureText: isObscure,
          validator: validator,
        ),
      ],
    );
  }
}

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelName;
  final TextInputType? keyboardType;
  final bool onlyNumber;
  const MyTextField({
    super.key,
    required this.controller,
    required this.labelName,
    this.keyboardType,
    this.onlyNumber = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(labelName),
        ),
        const SizedBox(height: 5),
        TextFormField(
          keyboardType: keyboardType,
          inputFormatters: onlyNumber
              ? <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ]
              : [],
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          controller: controller,
        ),
      ],
    );
  }
}

class MyDateField extends StatelessWidget {
  final DateTime data;
  final String labelName;
  final void Function()? onClick;

  const MyDateField({
    super.key,
    required this.data,
    required this.labelName,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(labelName),
        ),
        const SizedBox(height: 5),
        InkWell(
          onTap: onClick,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              border: Border.all(color: Colors.black),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    formatarData(data),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.date_range, size: 20),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MyDropDownButton extends StatelessWidget {
  const MyDropDownButton(
      {super.key,
      required HomeController homeController,
      required this.labelName})
      : _homeController = homeController;

  final HomeController _homeController;
  final String labelName;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(labelName),
            ),
            const SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                border: Border.all(color: Colors.black),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  isDense: true,
                  isExpanded: true,
                  underline: Container(
                    decoration: const BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.transparent)),
                    ),
                  ),
                  value: _homeController.tipo,
                  items: _homeController.tipos
                      .map<DropdownMenuItem<String>>((String? value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value ?? 'Não foi possivel carregar',
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    _homeController.tipo = newValue!;
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class ErrorDialog extends StatelessWidget {
  final String message;
  const ErrorDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Erro'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Fechar'),
        ),
      ],
    );
  }
}

class NewEditListaDialog extends StatelessWidget {
  const NewEditListaDialog({
    super.key,
    required HomeController homeController,
    required this.onConfirm,
    required this.isEdit,
  }) : _homeController = homeController;

  final HomeController _homeController;
  final void Function()? onConfirm;
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(16.0),
      insetPadding: const EdgeInsets.all(16.0),
      title: Text(isEdit ? 'Editar Lista' : 'Adicionar Lista'),
      content: Observer(
        builder: (context) {
          return SizedBox(
            width: double.maxFinite,
            height: 230,
            child: ListView(
              shrinkWrap: true,
              children: [
                MyTextField(
                  controller: _homeController.unidadeController,
                  labelName: 'Unidade',
                ),
                const SizedBox(height: 15),
                MyDateField(
                  data: _homeController.dataLista,
                  labelName: 'Data',
                  onClick: () async {
                    _homeController.dataLista = await showDatePicker(
                          locale: const Locale('pt', 'BR'),
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2023, 01, 01),
                          lastDate: DateTime(2030, 12, 31),
                        ) ??
                        DateTime.now();
                  },
                ),
                const SizedBox(height: 15),
                MyDropDownButton(
                  homeController: _homeController,
                  labelName: 'Tipo de lista',
                )
              ],
            ),
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            _homeController.unidadeController.clear();
            _homeController.dataLista = DateTime.now();
            Navigator.pop(context);
          },
          child: const Text(
            'Cancelar',
            style: TextStyle(color: Colors.red),
          ),
        ),
        TextButton(
          onPressed: onConfirm,
          child: Text(isEdit ? 'Confirmar' : 'Cadastrar'),
        ),
      ],
    );
  }
}

class NewEditItemDialog extends StatelessWidget {
  const NewEditItemDialog({
    super.key,
    required ListaController listaController,
    required this.onConfirm,
    required this.isEdit,
  }) : _listaController = listaController;

  final ListaController _listaController;
  final void Function()? onConfirm;
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(16.0),
      insetPadding: const EdgeInsets.all(16.0),
      title: Text(isEdit ? 'Editar Item' : 'Adicionar Item'),
      content: Observer(
        builder: (context) {
          return SizedBox(
            width: double.maxFinite,
            height: 305,
            child: ListView(
              shrinkWrap: true,
              children: [
                MyTextField(
                  controller: _listaController.codigoBarrasTextController,
                  labelName: 'Código de Barras',
                  keyboardType: TextInputType.number,
                  onlyNumber: true,
                ),
                const SizedBox(height: 10),
                MyDateField(
                  data: _listaController.dataValidade,
                  labelName: 'Data de Validade',
                  onClick: () async {
                    _listaController.dataValidade = await showDatePicker(
                          locale: const Locale('pt', 'BR'),
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2023, 01, 01),
                          lastDate: DateTime(2050, 12, 31),
                        ) ??
                        DateTime.now();
                  },
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller:
                      _listaController.quantidadeEmbalagemTextController,
                  labelName: 'Quantidade por Embalagem',
                  keyboardType: TextInputType.number,
                  onlyNumber: true,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: _listaController.quantidadeTextController,
                  labelName: 'Quantidade',
                  keyboardType: TextInputType.number,
                  onlyNumber: true,
                ),
              ],
            ),
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Cancelar',
            style: TextStyle(color: Colors.red),
          ),
        ),
        TextButton(
          onPressed: onConfirm,
          child: Text(isEdit ? 'Confirmar' : 'Cadastrar'),
        ),
      ],
    );
  }
}

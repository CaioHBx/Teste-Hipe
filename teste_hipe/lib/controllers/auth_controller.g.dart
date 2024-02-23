// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthController on AuthControllerBase, Store {
  late final _$verificarUserAsyncAction =
      AsyncAction('AuthControllerBase.verificarUser', context: context);

  @override
  Future<bool> verificarUser() {
    return _$verificarUserAsyncAction.run(() => super.verificarUser());
  }

  late final _$newUserAsyncAction =
      AsyncAction('AuthControllerBase.newUser', context: context);

  @override
  Future<dynamic> newUser(BuildContext context) {
    return _$newUserAsyncAction.run(() => super.newUser(context));
  }

  late final _$loginAsyncAction =
      AsyncAction('AuthControllerBase.login', context: context);

  @override
  Future<dynamic> login(BuildContext context) {
    return _$loginAsyncAction.run(() => super.login(context));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}

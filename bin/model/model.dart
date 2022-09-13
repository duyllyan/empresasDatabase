import 'dart:io';

import '../util/menu_validacoes.dart';
import 'endereco.dart';

abstract class Pessoa {
  late final String _nome;
  late final Endereco endereco;
  late final String _cadastro;

  Pessoa();

  String get nome => _nome;
  set nome(String nome) {
    _nome = prosseguir(nome);
  }

  String get cadastro => _cadastro;
  set cadastro(String value) {
    _cadastro = value;
  }

  String validaCadastro(String cadastro);

  String prosseguirCadastro(String input) {
    validaCadastro(input);
    print("Deseja Prosseguir? \n"
        "1. Sim \n"
        "2. Não");
    String inputMenu = stdin.readLineSync()!;
    while (inputMenu.compareTo("1") == -1 || inputMenu.compareTo("2") == 1) {
      print("\nOpção inválida!");
      inputMenu = stdin.readLineSync()!;
    }
    if (inputMenu == "2") {
      print("\nInforme novamente: ");
      input = stdin.readLineSync()!;
      prosseguirCadastro(validaCadastro(input));
    }
    return input;
  }
}

import 'dart:io';

import '../util/cpfcnpj.dart';
import 'model.dart';

class PessoaFisica extends Pessoa {
  PessoaFisica();

  @override
  set cadastro(String cpf) {
    super.cadastro = prosseguirCadastro(validaCadastro(cpf));
  }

  @override
  String validaCadastro(String cpf) {
    while (!CPF.valida(cpf)) {
      print("\nInforme um CPF válido!");
      cpf = stdin.readLineSync()!;
    }
    return cpf;
  }

  @override
  String toString() {
    return 'CPF: ${CPF.formata(cadastro)} \n'
        'Nome Completo: $nome \n'
        'Endereço: $endereco';
  }
}

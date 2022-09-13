
import 'dart:io';

import '../util/cpfcnpj.dart';
import '../util/menu_validacoes.dart';
import 'model.dart';

class PessoaJuridica extends Pessoa {
  late final String _razaoSocial;
  PessoaJuridica();

  String get razaoSocial => _razaoSocial;
  set razaoSocial(String razaoSocial) {
    _razaoSocial = prosseguir(razaoSocial);
  }

  @override
  set cadastro(String cnpj) {
    super.cadastro = prosseguirCadastro(validaCadastro(cnpj));
  }

  @override
  String validaCadastro(String cnpj) {
    while (!CNPJ.valida(cnpj)) {
      print("Informe um CNPJ válido!");
      cnpj = stdin.readLineSync()!;
    }
    return cnpj;
  }

  @override
  String toString() {
    return 'CNPJ: ${CNPJ.formata(cadastro)} \n'
        'Razão Social: $razaoSocial'
        'Nome Fantasia: $nome \n'
        'Endereço: $endereco';
  }
}


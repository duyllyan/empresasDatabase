import 'dart:io';

import '../util/cpfcnpj.dart';
import '../util/formatacoes.dart';
import '../util/menu_validacoes.dart';
import '../util/uuid.dart';
import 'model.dart';
import 'pessoa_juridica.dart';

class Empresa extends PessoaJuridica {
  final String _id = UuidGenerator.newUuid();
  late final String _telefone;
  final DateTime horaCadastro = DateTime.now();
  late final Pessoa _socio;

  Empresa();

  String get id => _id;

  String get telefone => _telefone;
  set telefone(String telefone) {
    while (telefone.length != 11) {
      print("Telefone inválido!\n"
          "Informe o telefone");
      telefone = stdin.readLineSync()!;
    }
    _telefone = prosseguir(telefone);
  }

  Pessoa get socio => _socio;
  set socio(Pessoa value) {
    _socio = value;
  }

  @override
  String toString() {
    return 'ID: $id \n'
        'CNPJ: ${CNPJ.formata(cadastro)} Data Cadastro: $horaCadastro \n'
        'Razão Social: $razaoSocial \n'
        'Nome Fantasia: $nome \n'
        'Telefone: ${telefone.formataTelefone()} \n'
        'Endereço: $endereco \n'
        'Socio: \n'
        '$socio';
  }
}


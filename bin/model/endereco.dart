import 'dart:io';

import '../util/formatacoes.dart';
import '../util/menu_validacoes.dart';

class Endereco {
  late final String _logradouro;
  late final String _numero;
  late final String _complemento;
  late final String _bairro;
  late final String _cidade;
  late final String _estado;
  late final String _cep;

  Endereco();

  String get logradouro => _logradouro;
  set logradouro(String logradouro) {
    _logradouro = prosseguir(logradouro);
  }

  String get numero => _numero;
  set numero(String numero) {
    _numero = prosseguir(numero);
  }

  String get complemento => _complemento;
  set complemento(String complemento) {
    _complemento = prosseguir(complemento);
  }

  String get bairro => _bairro;
  set bairro(String bairro) {
    _bairro = prosseguir(bairro);
  }

  String get cidade => _cidade;
  set cidade(String cidade) {
    _cidade = prosseguir(cidade);
  }

  String get estado => _estado;
  set estado(String estado) {
    _estado = prosseguir(estado);
  }

  String get cep => _cep;
  set cep(String cep) {
    while (cep.length != 8) {
      print("CEP inválido!\n"
          "Informe novamente:");
      cep = stdin.readLineSync()!;
    }
    _cep = prosseguir(cep);
  }

  @override
  String toString() {
    return '$logradouro, $numero, $bairro${complemento == "" ? " " : ", $complemento"}, $cidade/$estado, ${cep.formataCEP()}';
  }
}
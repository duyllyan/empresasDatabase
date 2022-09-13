import '../util/cpfcnpj.dart';
import '../util/formatacoes.dart';
import '../util/menu_validacoes.dart';
import '../util/uuid.dart';
import 'dart:io';

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

  String _prosseguirCadastro(String input) {
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
      _prosseguirCadastro(validaCadastro(input));
    }
    return input;
  }
}

class PessoaFisica extends Pessoa {
  PessoaFisica();

  @override
  set cadastro(String cpf) {
    _cadastro = _prosseguirCadastro(validaCadastro(cpf));
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

class PessoaJuridica extends Pessoa {
  late final String _razaoSocial;
  PessoaJuridica();

  String get razaoSocial => _razaoSocial;
  set razaoSocial(String razaoSocial) {
    _razaoSocial = prosseguir(razaoSocial);
  }

  @override
  set cadastro(String cnpj) {
    _cadastro = _prosseguirCadastro(validaCadastro(cnpj));
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

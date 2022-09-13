import '../util/cpfcnpj.dart';
import 'endereco.dart';

abstract class Pessoa {
  final String nome;
  final Endereco endereco;
  final String cadastro;

  Pessoa(this.nome, this.endereco, this.cadastro);

  bool validaCadastro();
}

class PessoaFisica extends Pessoa {
  PessoaFisica(super.nome, super.endereco, super.cadastro);

  @override
  bool validaCadastro() {
    return CPF.valida(super.cadastro);
  }
}

class PessoaJuridica extends Pessoa {
  final String razaoSocial;
  PessoaJuridica(super.nome, super.endereco, super.cadastro, this.razaoSocial);

  @override
  bool validaCadastro() {
    return CNPJ.valida(super.cadastro);
  }
}
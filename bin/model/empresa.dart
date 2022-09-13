import '../util/uuid.dart';
import 'pessoa.dart';

class Empresa extends PessoaJuridica {
  final String _id = UuidGenerator.newUuid();
  final String telefone;
  final DateTime horaCadastro = DateTime.now();
  final Pessoa socio;

  Empresa(this.telefone, this.socio, super.nome, super.endereco, super.cadastro, super.razaoSocial);

  String get id => _id;

  @override
  String toString() {
    return '$id: ${super.razaoSocial}';
  }
}
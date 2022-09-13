import '../model/model.dart';
import '../model/pessoa_fisica.dart';
import '../model/pessoa_juridica.dart';

enum PessoaTipo { fisica, juridica }

class PessoaFactory {
  static Pessoa definePessoa(String tipo) {
    switch (tipo) {
      case "1":
        return PessoaFisica();
      case "2":
      default:
        return PessoaJuridica();
    }
  }
}
import '../model/model.dart';

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
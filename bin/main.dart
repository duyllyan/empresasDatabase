import 'model/empresa.dart';
import 'model/endereco.dart';
import 'model/pessoa.dart';
import 'repository/empresa_repository.dart';
import 'util/cpfcnpj.dart';

void main() {
  final instance = EmpresaRepository.instance;
  final endereco1 = Endereco("rua", "numero", "complemento", "bairro", "cidade", 'estado', 'cep');
  final socio = PessoaJuridica("nome", endereco1, "0022", "razaoSocial");
  final socio2 = PessoaFisica("nome", endereco1, "0593652312");

  print(socio2.validaCadastro());
  instance.adicionarEmpresa(
    Empresa("0000", socio , "Empresa 1", endereco1, "0033", "Empresa 7")
  );

  instance.adicionarEmpresa(
      Empresa("0000", socio , "Empresa 2", endereco1, "003", "Empresa 3")
  );

  instance.adicionarEmpresa(
      Empresa("0000", socio , "Empresa 2", endereco1, "003", "Empresa 2")
  );
}

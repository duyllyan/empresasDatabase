import '../factory/factory_pessoa.dart';
import '../model/model.dart';
import '../repository/empresa_repository.dart';
import 'dart:io';
import '../util/cpfcnpj.dart';
import '../util/menu_validacoes.dart';

void main() {
  final repository = EmpresaRepository.instance;
  _carregaMenuPrincipal(repository);
}

void _carregaMenuPrincipal(EmpresaRepository repository) {
  final menu = "Selecione a opção desejada: \n"
      "1. Cadastrar Nova Empresa \n"
      "2. Buscar Empresa por CNPJ \n"
      "3. Buscar Empresa por CPF/CNPJ do Sócio \n"
      "4. Listar Empresas por Razão Social \n"
      "5. Excluir Empresa \n"
      "6. Sair \n";

  print("Seja bem-vindo(a) ao Cadastro de Empresas \n");
  print(menu);

  String inputMenu = validacaoMenu(menu, "1", "6");

  switch (inputMenu) {
    case "1":
      cadastraEmpresa(repository);
      break;
    case "2":
      buscaEmpresaCNPJ(repository);
      break;
    case "3":
      buscaEmpresaSocio(repository);
      break;
    case "4":
      listaEmpresas(repository);
      break;
    case "5":
      excluiEmpresa(repository);
      break;
    case "6":
    default:
      print("\nAté breve!");
      break;
  }
}

void excluiEmpresa(EmpresaRepository repository) {
  print("\nInforme o UUID:");
  String uuid = stdin.readLineSync()!;

  try {
    repository.excluirEmpresa(uuid);
    print("\nEmpresa excluida!");
  } catch(e) {
    print("\nNão foi possível excluir a empresa com o UUID informado");
  }

  enterParaContinuar();
  _carregaMenuPrincipal(repository);
}

void listaEmpresas(EmpresaRepository repository) {
  if (repository.listaEmpresas.isEmpty) {
    print("\nNão há empresas cadastradas");
  } else {
    repository.listaEmpresas.map((e) => "${e.razaoSocial} - ${CNPJ.formata(e.cadastro)}")
        .forEach(print);
  }
  enterParaContinuar();
  _carregaMenuPrincipal(repository);
}

void buscaEmpresaSocio(EmpresaRepository repository) {
  print("\nInforme o CPF/CNPJ do sócio:");
  String cadastro = stdin.readLineSync()!;

  if (repository.buscaSocio(cadastro).isEmpty) {
    print("\nNão há empresas cadastradas para o CPF/CNPJ informado");
  } else {
    print("");
    repository.buscaSocio(cadastro).forEach(print);
  }

  enterParaContinuar();
  _carregaMenuPrincipal(repository);
}

void buscaEmpresaCNPJ(EmpresaRepository repository) {

  print("\nInforme o CNPJ");
  String cnpj = stdin.readLineSync()!;

  while(!CNPJ.valida(cnpj)) {
    print("\nCNPJ inválido!");
    print("Informe novamente:");
    cnpj = stdin.readLineSync()!;
  }

  try {
    print("");
    print(repository.buscaCNPJ(cnpj));
  } catch(e) {
    print("\nNão há empresa cadastrada com esse CNPJ");
  }

  enterParaContinuar();
  _carregaMenuPrincipal(repository);
}

void cadastraEmpresa(EmpresaRepository repository) {
  print("\n ############ CADASTRAR NOVA EMPRESA ############ \n");

  Empresa empresa = Empresa();

  print("Informe o CNPJ:");
  String cnpj = stdin.readLineSync()!;
  empresa.cadastro = cnpj;

  print("Informe a Razão Social:");
  String razaoSocial = stdin.readLineSync()!;
  empresa.razaoSocial = razaoSocial;

  print("Informe o Nome Fantasia:");
  String nomeFantasia = stdin.readLineSync()!;
  empresa.nome = nomeFantasia;

  print("Informe o telefone:");
  String telefone = stdin.readLineSync()!;
  empresa.telefone = telefone;

  print("\n############# CADASTRAR ENDEREÇO ############## \n");

  empresa.endereco = Endereco();

  _cadastraEndereco(empresa.endereco);

  print("\n############# CADASTRAR SÓCIO #############\n");

  String menuPessoa = "Informe o tipo de Pessoa: \n"
      "1. Pessoa Física \n"
      "2. Pessoa Jurídica \n";
  print(menuPessoa);

  String inputPessoaTipo = validacaoMenu(menuPessoa, "1", "2");

  empresa.socio = PessoaFactory.definePessoa(inputPessoaTipo);

  if (empresa.socio is PessoaJuridica) {
    print("Informe o nome fantasia:");
    String nome = stdin.readLineSync()!;
    empresa.socio.nome = nome;

    print("Informe o CNPJ:");
    String cadastro = stdin.readLineSync()!;
    empresa.socio.cadastro = cadastro;

    print("Informe a razão social:");
    String razaoSocial = stdin.readLineSync()!;
    (empresa.socio as PessoaJuridica).razaoSocial = razaoSocial;
  } else {
    print("Informe o nome:");
    String nome = stdin.readLineSync()!;
    empresa.socio.nome = nome;

    print("Informe o CPF:");
    String cadastro = stdin.readLineSync()!;
    empresa.socio.cadastro = cadastro;
  }

  String enderecoMenu = 'Deseja utilizar o mesmo endereço do cadastro da empresa? \n'
      '1. Sim \n'
      '2. Não \n';
  print(enderecoMenu);
  String inputEndereco = validacaoMenu(enderecoMenu, "1", "2");

  if (inputEndereco.compareTo("1") == 0) {
    empresa.socio.endereco = empresa.endereco;
  } else {
    empresa.socio.endereco = Endereco();
    _cadastraEndereco(empresa.socio.endereco);
  }

  print("Empresa cadastrada com sucesso! \n"
      "\n$empresa \n\n");

  repository.adicionarEmpresa(empresa);

  enterParaContinuar();

  _carregaMenuPrincipal(repository);
}

void _cadastraEndereco(Endereco endereco) {
  print("Informe o logradouro:");
  String logradouro = stdin.readLineSync()!;
  endereco.logradouro = logradouro;

  print("Informe o número:");
  String numero = stdin.readLineSync()!;
  endereco.numero = numero;

  print("Informe o complemento:");
  String complemento = stdin.readLineSync()!;
  endereco.complemento = complemento;

  print("Informe o bairro:");
  String bairro = stdin.readLineSync()!;
  endereco.bairro = bairro;

  print("Informe a cidade:");
  String cidade = stdin.readLineSync()!;
  endereco.cidade = cidade;

  print("Informe o estado:");
  String estado = stdin.readLineSync()!;
  endereco.estado = estado;

  print("Informe o CEP:");
  String cep = stdin.readLineSync()!;
  endereco.cep = cep;
}
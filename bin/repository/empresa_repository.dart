import '../model/empresa.dart';

class EmpresaRepository {

  final List<Empresa> _empresas = [];

  EmpresaRepository._privateConstructor();

  static final EmpresaRepository instance = EmpresaRepository._privateConstructor();

  List<Empresa> get listaEmpresas => _empresas;

  void adicionarEmpresa(Empresa empresa) {
    _empresas.add(empresa);
  }

  Empresa buscaCNPJ(String cnpj) {
    return _empresas.firstWhere((element) => element.cadastro == cnpj);
  }

  List<Empresa> buscaSocio(String cadastro) {
    return _empresas.where((element) => element.socio.cadastro == cadastro).toList();
  }

  List<Empresa> ordenaPorRazaoSocial() {
    final listaOrdenada = List<Empresa>.from(_empresas);
    listaOrdenada.sort((a, b) => a.razaoSocial.compareTo(b.razaoSocial));
    return listaOrdenada;
  }

  void excluirEmpresa(String uuid) {
    _empresas.removeWhere((element) => element.id == uuid);
  }
}
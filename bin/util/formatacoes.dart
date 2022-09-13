extension Telefone on String {
  String formataTelefone() {
    return replaceAllMapped(RegExp(r'(\d{2})(\d{1})(\d{4})(\d+)'), (Match m) => "(${m[1]}) ${m[2]} ${m[3]}-${m[4]}");
  }
}

extension CEP on String {
  String formataCEP() {
    return replaceAllMapped(RegExp(r'(\d{2})(\d{3})(\d+)'), (Match m) => "${m[1]}.${m[2]}-${m[3]}");
  }
}
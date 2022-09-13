class CPF {
  static bool valida(String cpf) {
    //Verifica se os números são diferentes de 11
    if (cpf.length != 11) {
      return false;
    }

    //Verifica se os números são iguais
    bool numerosIguais = true;
    for (int i = 0; i < cpf.length - 1; i++) {
      numerosIguais = numerosIguais && cpf[i] != cpf[i + 1];
    }
    if (numerosIguais == false) return false;

    //Calculo de verificação do CPF
    int somaPrimeiro = _somatoria(0, 9, cpf);
    int primeiroDigito = int.parse(cpf[9]);
    bool validaPrimeiro = _validaDigito(somaPrimeiro, primeiroDigito);

    int somaSegundo = _somatoria(0, 10, cpf);
    int segundoDigito = int.parse(cpf[10]);

    bool validaSegundo = _validaDigito(somaSegundo, segundoDigito);
    return validaPrimeiro && validaSegundo;
  }

  static String formata(String cpf) {
    return cpf.replaceAllMapped(RegExp(r'(\d{3})(\d{3})(\d{3})(\d+)'), (Match m) =>
    "${m[1]}.${m[2]}.${m[3]}-${m[4]}");
  }
}

class CNPJ {
  static bool valida(String cnpj) {
    //Verifica se os numeros são diferentes de 14
    if (cnpj.length != 14) {
      return false;
    }

    //Calculo validação CNPJ
    int somaPrimeiro = _somatoria(0, 4, cnpj);
    somaPrimeiro += _somatoria(4, 12, cnpj);
    int primeiroDigito = int.parse(cnpj[12]);
    bool validaPrimeiro = _validaDigito(somaPrimeiro, primeiroDigito);

    int somaSegundo = _somatoria(0, 5, cnpj);
    somaSegundo += _somatoria(5, 13, cnpj);
    int segundoDigito = int.parse(cnpj[13]);
    bool validaSegundo = _validaDigito(somaSegundo, segundoDigito);

    return validaPrimeiro && validaSegundo;
  }

  static String formata(String cnpj) {
    return cnpj.replaceAllMapped(RegExp(r'(\d{2})(\d{3})(\d{3})(\d{4})(\d+)'), (Match m) =>
    "${m[1]}.${m[2]}.${m[3]}/${m[4]}-${m[5]}");
  }
}

bool _validaDigito(int soma, int digito) {
  int restoDivisao = (soma * 10) % 11;
  return digito == (soma % 11 < 2 ? 0 : 11 - soma % 11);
}

int _somatoria(int inicio, int fim, String cadastro) {
  int soma = 0;
  for (int i = inicio; i < fim; i++) {
    soma += int.parse(cadastro[i]) * (fim + 1 - i);
  }
  return soma;
}
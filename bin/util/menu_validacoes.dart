import 'dart:io';

String prosseguir(String input) {
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
    prosseguir(input);
  }
  return input;
}

String validacaoMenu(String menu, String inicio, String fim) {
  String inputMenu = stdin.readLineSync()!;
  while (inputMenu.compareTo(inicio) == -1 || inputMenu.compareTo(fim) == 1) {
    print("\nOpção inválida!");
    print(menu);
    inputMenu = stdin.readLineSync()!;
  }
  return inputMenu;
}

void enterParaContinuar() {
  print("\nPressione [Enter] para continuar:");
  stdin.readLineSync()!;
}
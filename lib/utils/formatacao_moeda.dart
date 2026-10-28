String formatarReais(double valor) {
  final valorFormatado = valor.toStringAsFixed(2).replaceAll('.', ',');
  return 'R\$ $valorFormatado';
}

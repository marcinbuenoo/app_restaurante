class Prato {
  final String foto;
  final String nome;
  final String descricao;
  final double preco;
  final double estrelas;
  final List<String> ingredientes;

  const Prato({
    required this.foto,
    required this.nome,
    required this.descricao,
    required this.preco,
    required this.estrelas,
    required this.ingredientes,
  });
}

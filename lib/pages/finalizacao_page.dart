import 'package:flutter/material.dart';

import '../models/bebida.dart';
import '../models/forma_pagamento.dart';
import '../models/prato.dart';
import '../models/sobremesa.dart';
import '../utils/formatacao_moeda.dart';

class FinalizacaoPage extends StatelessWidget {
  final Prato pratoSelecionado;
  final Bebida? bebidaSelecionada;
  final Sobremesa? sobremesaSelecionada;
  final FormaPagamento formaPagamento;

  const FinalizacaoPage({
    super.key,
    required this.pratoSelecionado,
    required this.bebidaSelecionada,
    required this.sobremesaSelecionada,
    required this.formaPagamento,
  });

  double get _totalPedido {
    return pratoSelecionado.preco +
        (bebidaSelecionada?.preco ?? 0) +
        (sobremesaSelecionada?.preco ?? 0);
  }

  String get _nomeFormaPagamento {
    switch (formaPagamento) {
      case FormaPagamento.pix:
        return 'Pix';
      case FormaPagamento.cartaoCredito:
        return 'Cartão de crédito';
      case FormaPagamento.cartaoDebito:
        return 'Cartão de débito';
      case FormaPagamento.dinheiro:
        return 'Dinheiro';
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope<void>(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Finalização do pedido'),
          automaticallyImplyLeading: false,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Itens escolhidos',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Card(
              child: Column(
                children: [
                  _ItemPedidoTile(
                    nome: pratoSelecionado.nome,
                    preco: pratoSelecionado.preco,
                  ),
                  if (bebidaSelecionada != null)
                    _ItemPedidoTile(
                      nome: bebidaSelecionada!.nome,
                      preco: bebidaSelecionada!.preco,
                    ),
                  if (sobremesaSelecionada != null)
                    _ItemPedidoTile(
                      nome: sobremesaSelecionada!.nome,
                      preco: sobremesaSelecionada!.preco,
                    ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text(
                      'Total',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      formatarReais(_totalPedido),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Forma de pagamento',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.payment),
                title: Text(_nomeFormaPagamento),
              ),
            ),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/',
                    (route) => false,
                  );
                },
                child: const Text('Novo pedido'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ItemPedidoTile extends StatelessWidget {
  final String nome;
  final double preco;

  const _ItemPedidoTile({super.key, required this.nome, required this.preco});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(nome),
      trailing: Text(formatarReais(preco)),
    );
  }
}

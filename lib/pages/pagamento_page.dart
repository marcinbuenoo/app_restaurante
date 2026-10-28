import 'package:flutter/material.dart';

import '../models/bebida.dart';
import '../models/forma_pagamento.dart';
import '../models/prato.dart';
import '../models/sobremesa.dart';
import '../utils/formatacao_moeda.dart';
import 'finalizacao_page.dart';

class PagamentoPage extends StatefulWidget {
  final Prato pratoSelecionado;
  final Bebida? bebidaSelecionada;
  final Sobremesa? sobremesaSelecionada;

  const PagamentoPage({
    super.key,
    required this.pratoSelecionado,
    required this.bebidaSelecionada,
    required this.sobremesaSelecionada,
  });

  @override
  State<PagamentoPage> createState() => _PagamentoPageState();
}

class _PagamentoPageState extends State<PagamentoPage> {
  FormaPagamento? _formaPagamentoSelecionada;

  double get _totalPedido {
    return widget.pratoSelecionado.preco +
        (widget.bebidaSelecionada?.preco ?? 0) +
        (widget.sobremesaSelecionada?.preco ?? 0);
  }

  String _nomeFormaPagamento(FormaPagamento forma) {
    switch (forma) {
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

  IconData _iconeFormaPagamento(FormaPagamento forma) {
    switch (forma) {
      case FormaPagamento.pix:
        return Icons.qr_code_2;
      case FormaPagamento.cartaoCredito:
      case FormaPagamento.cartaoDebito:
        return Icons.credit_card;
      case FormaPagamento.dinheiro:
        return Icons.payments;
    }
  }

  void _irParaFinalizacao() {
    final formaPagamento = _formaPagamentoSelecionada;
    if (formaPagamento == null) return;

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => FinalizacaoPage(
          pratoSelecionado: widget.pratoSelecionado,
          bebidaSelecionada: widget.bebidaSelecionada,
          sobremesaSelecionada: widget.sobremesaSelecionada,
          formaPagamento: formaPagamento,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagamento'),
        actions: [
          IconButton(
            tooltip: 'Início',
            icon: const Icon(Icons.home_outlined),
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/',
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Resumo do pedido',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Card(
            child: Column(
              children: [
                ListTile(
                  title: Text(widget.pratoSelecionado.nome),
                  trailing: Text(
                    formatarReais(widget.pratoSelecionado.preco),
                  ),
                ),
                if (widget.bebidaSelecionada != null)
                  ListTile(
                    title: Text(widget.bebidaSelecionada!.nome),
                    trailing: Text(
                      formatarReais(widget.bebidaSelecionada!.preco),
                    ),
                  ),
                if (widget.sobremesaSelecionada != null)
                  ListTile(
                    title: Text(widget.sobremesaSelecionada!.nome),
                    trailing: Text(
                      formatarReais(widget.sobremesaSelecionada!.preco),
                    ),
                  ),
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
          const SizedBox(height: 16),
          Text(
            'Escolha a forma de pagamento',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          for (final forma in FormaPagamento.values)
            Card(
              child: ListTile(
                leading: Icon(_iconeFormaPagamento(forma)),
                title: Text(_nomeFormaPagamento(forma)),
                selected: _formaPagamentoSelecionada == forma,
                trailing: _formaPagamentoSelecionada == forma
                    ? const Icon(Icons.check_circle, color: Colors.green)
                    : null,
                onTap: () {
                  setState(() {
                    _formaPagamentoSelecionada = forma;
                  });
                },
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
              onPressed: _formaPagamentoSelecionada == null
                  ? null
                  : _irParaFinalizacao,
              child: const Text('Revisar pedido'),
            ),
          ),
        ),
      ),
    );
  }
}

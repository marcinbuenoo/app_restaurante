import 'package:flutter/material.dart';

import '../data/bebidas.dart';
import '../models/bebida.dart';
import '../models/prato.dart';
import '../pages/sobremesas_pages.dart';
import '../utils/formatacao_moeda.dart';

class BebidasPage extends StatefulWidget {
  final Prato pratoSelecionado;

  const BebidasPage({super.key, required this.pratoSelecionado});

  @override
  State<BebidasPage> createState() => _BebidasPageState();
}

class _BebidasPageState extends State<BebidasPage> {
  Bebida? _bebidaSelecionada;
  bool _semBebidaSelecionada = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bebidas'),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text('Prato escolhido: ${widget.pratoSelecionado.nome}'),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: bebidas.length + 1,
              itemBuilder: (context, index) {
                if (index == bebidas.length) {
                  return Card(
                    child: ListTile(
                      title: const Text('Sem bebida'),
                      selected: _semBebidaSelecionada,
                      trailing: _semBebidaSelecionada
                          ? const Icon(Icons.check_circle, color: Colors.green)
                          : null,
                      onTap: () {
                        setState(() {
                          _bebidaSelecionada = null;
                          _semBebidaSelecionada = true;
                        });
                      },
                    ),
                  );
                }

                final bebida = bebidas[index];
                final selecionada = _bebidaSelecionada == bebida;

                return Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(8),
                    leading: Image.asset(
                      bebida.foto,
                      width: 72,
                      height: 72,
                      fit: BoxFit.cover,
                    ),
                    title: Text(bebida.nome),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('${bebida.volumeMl} ml'),
                        Text(formatarReais(bebida.preco)),
                      ],
                    ),
                    selected: selecionada,
                    trailing: selecionada
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : null,
                    onTap: () {
                      setState(() {
                        _bebidaSelecionada = bebida;
                        _semBebidaSelecionada = false;
                      });
                    },
                  ),
                );
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
              onPressed: _bebidaSelecionada == null && !_semBebidaSelecionada
                  ? null
                  : () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => SobremesasPage(
                            pratoSelecionado: widget.pratoSelecionado,
                            bebidaSelecionada: _bebidaSelecionada,
                          ),
                        ),
                      );
                    },
              child: const Text('Escolher sobremesa'),
            ),
          ),
        ),
      ),
    );
  }
}

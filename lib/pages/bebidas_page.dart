import 'package:flutter/material.dart';

import '../data/bebidas.dart';
import '../models/bebida.dart';
import '../models/prato.dart';
import '../pages/sobremesas_pages.dart';

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
      appBar: AppBar(title: const Text('Bebidas')),
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
                        Text('R\$ ${bebida.preco.toStringAsFixed(2)}'),
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
    );
  }
}

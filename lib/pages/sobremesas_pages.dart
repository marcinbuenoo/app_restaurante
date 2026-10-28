import 'package:flutter/material.dart';

import '../data/sobremesas.dart';
import '../models/bebida.dart';
import '../models/prato.dart';
import '../models/sobremesa.dart';

class SobremesasPage extends StatefulWidget {
  final Prato pratoSelecionado;
  final Bebida? bebidaSelecionada;

  const SobremesasPage({
    super.key,
    required this.pratoSelecionado,
    required this.bebidaSelecionada,
  });

  @override
  State<SobremesasPage> createState() => _SobremesasPageState();
}

class _SobremesasPageState extends State<SobremesasPage> {
  Sobremesa? _sobremesaSelecionada;
  bool _semSobremesaSelecionada = false;

  @override
  Widget build(BuildContext context) {
    final nomeBebida = widget.bebidaSelecionada?.nome ?? 'Sem bebida';

    return Scaffold(
      appBar: AppBar(title: const Text('Sobremesas')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'Prato: ${widget.pratoSelecionado.nome}\n'
              'Bebida: $nomeBebida',
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: sobremesas.length + 1,
              itemBuilder: (context, index) {
                if (index == sobremesas.length) {
                  return Card(
                    child: ListTile(
                      title: const Text('Sem sobremesa'),
                      selected: _semSobremesaSelecionada,
                      trailing: _semSobremesaSelecionada
                          ? const Icon(Icons.check_circle, color: Colors.green)
                          : null,
                      onTap: () {
                        setState(() {
                          _sobremesaSelecionada = null;
                          _semSobremesaSelecionada = true;
                        });
                      },
                    ),
                  );
                }

                final sobremesa = sobremesas[index];
                final selecionada = _sobremesaSelecionada == sobremesa;

                return Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(8),
                    leading: Image.asset(
                      sobremesa.foto,
                      width: 72,
                      height: 72,
                      fit: BoxFit.cover,
                    ),
                    title: Text(sobremesa.nome),
                    subtitle: Text('R\$ ${sobremesa.preco.toStringAsFixed(2)}'),
                    selected: selecionada,
                    trailing: selecionada
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : null,
                    onTap: () {
                      setState(() {
                        _sobremesaSelecionada = sobremesa;
                        _semSobremesaSelecionada = false;
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

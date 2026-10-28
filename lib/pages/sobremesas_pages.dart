import 'package:flutter/material.dart';

import '../data/sobremesas.dart';
import '../models/bebida.dart';
import '../models/prato.dart';
import '../models/sobremesa.dart';
import '../utils/formatacao_moeda.dart';
import 'pagamento_page.dart';

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
    final podeContinuar =
        _sobremesaSelecionada != null || _semSobremesaSelecionada;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobremesas'),
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
                    subtitle: Text(formatarReais(sobremesa.preco)),
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
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: !podeContinuar
                  ? null
                  : () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => PagamentoPage(
                            pratoSelecionado: widget.pratoSelecionado,
                            bebidaSelecionada: widget.bebidaSelecionada,
                            sobremesaSelecionada: _sobremesaSelecionada,
                          ),
                        ),
                      );
                    },
              child: const Text('Ir para pagamento'),
            ),
          ),
        ),
      ),
    );
  }
}

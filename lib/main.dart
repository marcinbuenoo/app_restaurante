import 'package:app_restaurante/models/prato.dart';
import 'package:flutter/material.dart';

import 'data/pratos.dart';
import 'pages/bebidas_page.dart';
import 'utils/formatacao_moeda.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HouseBurguer',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'House Burguer'),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Prato? _pratoSelecionado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: pratos.length,
        itemBuilder: (context, index) {
          final prato = pratos[index];

          return Card(
            child: ListTile(
              contentPadding: const EdgeInsets.all(8),
              leading: Image.asset(
                prato.foto,
                width: 72,
                height: 72,
                fit: BoxFit.cover,
              ),
              title: Text(prato.nome),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(formatarReais(prato.preco)),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      Text(prato.estrelas.toString()),
                    ],
                  ),
                ],
              ),
              selected: _pratoSelecionado == prato,
              trailing: _pratoSelecionado == prato
                  ? const Icon(Icons.check_circle, color: Colors.green)
                  : null,
              onTap: () async {
                final comprar = await showModalBottomSheet<bool>(
                  context: context,
                  builder: (modalContext) {
                    return Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            prato.nome,
                            style: Theme.of(modalContext).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 12),
                          Text(prato.descricao),
                          const SizedBox(height: 12),
                          Text(
                            'Ingredientes: ${prato.ingredientes.join(', ')}',
                          ),
                          const SizedBox(height: 12),
                          Text(formatarReais(prato.preco)),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: () =>
                                  Navigator.of(modalContext).pop(true),
                              child: const Text('Comprar'),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );

                if (comprar == true && context.mounted) {
                  setState(() {
                    _pratoSelecionado = prato;
                  });
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => BebidasPage(pratoSelecionado: prato),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}

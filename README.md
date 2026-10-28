# HouseBurguer

Aplicativo Flutter para montar um pedido de restaurante em até cinco telas. A interface permite escolher um prato, uma bebida opcional, uma sobremesa opcional e a forma de pagamento, e então revisar o pedido.

## Fluxo do pedido

1. **Pratos:** exibe as opções. Ao tocar em um prato, abre um modal com descrição, ingredientes e preço. O botão **Comprar** confirma a escolha.
2. **Bebidas:** permite escolher uma bebida ou **Sem bebida**.
3. **Sobremesas:** permite escolher uma sobremesa ou **Sem sobremesa**.
4. **Pagamento:** oferece Pix, cartão de crédito, cartão de débito ou dinheiro.
5. **Finalização:** mostra os itens escolhidos, o preço de cada item, o total e a forma de pagamento.

## Regras de navegação

- O avanço fica desabilitado até que uma opção seja escolhida na etapa atual.
- Nas telas de bebidas, sobremesas e pagamento, é possível voltar à etapa anterior ou usar o ícone de início para descartar o pedido e voltar aos pratos.
- Ao voltar uma etapa, a seleção anterior permanece marcada e pode ser alterada.
- A finalização não permite voltar. **Novo pedido** limpa as escolhas e retorna à tela de pratos.
- Os valores são exibidos em reais, com duas casas decimais, por exemplo: `R$ 8,50`.

## Estrutura do projeto

```text
lib/
├── assets/       # Imagens dos pratos, bebidas e sobremesas
├── data/         # Listas de itens disponíveis
├── models/       # Modelos de prato, bebida, sobremesa e pagamento
├── pages/        # Telas de bebidas, sobremesas, pagamento e finalização
├── utils/        # Formatação de valores em reais
└── main.dart     # Tela inicial, lista de pratos e modal de detalhes
```

As imagens em `lib/assets/` estão declaradas no `pubspec.yaml`.

## Executar o aplicativo

Com Flutter instalado, na raiz do projeto execute:

```bash
flutter pub get
flutter run
```

## Escopo atual

O fluxo registra as escolhas localmente e apresenta o resumo do pedido. A integração com um serviço de pedidos ou processamento real de pagamentos ainda não está implementada.

import '../models/prato.dart';

const pratos = <Prato>[
  Prato(
    foto: 'lib/assets/xburger.jpeg',
    nome: 'X-burger Artesanal',
    descricao:
        'Hambúrguer artesanal da casa com queijo prato, tomate e alface.',
    preco: 22.00,
    estrelas: 4.7,
    ingredientes: ['Pão', 'Carne', 'Queijo prato', 'Tomate', 'Alface'],
  ),
  Prato(
    foto: 'lib/assets/frangocrispy.jpeg',
    nome: 'Frango Crispy',
    descricao: 'Lanche de frango crocante!',
    preco: 25.00,
    estrelas: 4.5,
    ingredientes: [
      'Pão',
      'Frango empanado',
      'Molho Tasty',
      'Tomate',
      'Alface',
      'Picles',
    ],
  ),
  Prato(
    foto: 'lib/assets/batatafrita.jpeg',
    nome: 'Batata Rústica',
    descricao: 'Porção de 300g de batata frita',
    preco: 15.00,
    estrelas: 5.0,
    ingredientes: ['Batata', 'Sal'],
  ),
];

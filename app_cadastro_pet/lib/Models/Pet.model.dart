import 'package:flutter/material.dart';

class Pet {
  final String idPet;
  final String nome;
  final num idade;
  final String raca;

  const Pet({
    this.idPet,
    @required this.nome,
    @required this.idade,
    @required this.raca,
  });
}

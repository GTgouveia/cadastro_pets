import 'dart:math';

import 'package:app_cadastro_pet/Data/Database.dart';
import 'package:app_cadastro_pet/Models/Pet.model.dart';
import 'package:flutter/material.dart';

class PetsProvider with ChangeNotifier {
  final Map<String, Pet> _items = {...dataPet};
  //Retornar todos os nossos pets!
  List<Pet> get all {
    return [..._items.values];
  }

  //Retorna a quantidade de pets
  int get count {
    return _items.length;
  }

  //Retorna o pet pelo index
  Pet byIndex(int index) {
    return _items.values.elementAt(index);
  }

  //Vamos alterar ou adicionar um novo pet
  void put(Pet pet) {
    if (pet == null) {
      return;
    }

    if (pet.idPet != null &&
        pet.idPet.trim().isNotEmpty &&
        _items.containsKey(pet.idPet)) {
      //Ele apenas entrará nessa condição caso o id seja diferente de nulo
      _items.update(
        pet.idPet,
        (_) => Pet(
          idPet: pet.idPet,
          nome: pet.nome,
          idade: pet.idade,
          raca: pet.raca,
        ),
      );
    } else {
      final id = Random()
          .nextDouble()
          .toString(); //o id sera gerado de forma randomica
      _items.putIfAbsent(
        id,
        () => Pet(
          idPet: id,
          nome: pet.nome,
          idade: pet.idade,
          raca: pet.raca,
        ),
      );
    }
    notifyListeners(); // Este metodo notifica o provider e atualiza a aplicaçao com o novo dado
  }

  //Removera o pet selecionado
  void remove(Pet pet) {
    if (pet != null && pet.idPet != null) {
      _items.remove(pet.idPet);
      notifyListeners();
    }
  }
}

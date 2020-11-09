import 'package:app_cadastro_pet/Models/Pet.model.dart';
import 'package:app_cadastro_pet/Provider/Pets.provider.dart';
import 'package:app_cadastro_pet/Routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListPets extends StatelessWidget {
  final Pet pet;
  const ListPets(this.pet);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(Icons.pets),
      ),
      title: Text(pet.nome),
      subtitle: Text("Idade: ${pet.idade}"),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.amber,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.PET_FORM,
                  arguments: pet,
                );
              },
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text("Excluir Pet"),
                    content: Text("Deseja excluir o pet?"),
                    actions: [
                      FlatButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          "Cancelar".toUpperCase(),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          Provider.of<PetsProvider>(
                            context,
                            listen: false,
                          ).remove(pet);
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Ok".toUpperCase(),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

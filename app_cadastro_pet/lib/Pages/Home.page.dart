import 'package:app_cadastro_pet/Provider/Pets.provider.dart';
import 'package:app_cadastro_pet/Routes/app_routes.dart';
import 'package:app_cadastro_pet/Widgets/ListPet.widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PetsProvider petsProvider = Provider.of(context);
    double width = MediaQuery.of(context).size.width;
    double heigth = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Pets"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).pushNamed(AppRoutes.PET_FORM),
      ),
      body: petsProvider.count == 0
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ":(",
                    style: TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Não há nenhum pet cadastrado!",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Container(
                width: width,
                height: heigth,
                child: ListView.builder(
                  itemCount: petsProvider.count,
                  itemBuilder: (context, index) => ListPets(
                    petsProvider.byIndex(index),
                  ),
                ),
              ),
            ),
    );
  }
}

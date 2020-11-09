import 'package:app_cadastro_pet/Pages/Home.page.dart';
import 'package:app_cadastro_pet/Pages/PetForm.page.dart';
import 'package:app_cadastro_pet/Provider/Pets.provider.dart';
import 'package:app_cadastro_pet/Routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PetsProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.blue[900],
        ),
        home: HomePage(),
        routes: {
          AppRoutes.PET_FORM: (_) => PetForm(),
        },
      ),
    );
  }
}

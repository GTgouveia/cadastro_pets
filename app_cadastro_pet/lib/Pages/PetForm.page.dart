import 'package:app_cadastro_pet/Models/Pet.model.dart';
import 'package:app_cadastro_pet/Provider/Pets.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PetForm extends StatefulWidget {
  @override
  _PetFormState createState() => _PetFormState();
}

class _PetFormState extends State<PetForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerIdade = TextEditingController();
  final TextEditingController _controllerRaca = TextEditingController();

  final FocusNode _focusIdade = FocusNode();
  final FocusNode _focusRaca = FocusNode();

  final Map<String, dynamic> _formData = {};

  void alterarPet(Pet pet) {
    if (pet != null) {
      _formData['id'] = pet.idPet;
      _formData['nome'] = pet.nome;
      _formData['idade'] = pet.idade.toString();
      _formData['raca'] = pet.raca;

      _controllerNome.text = pet.nome;
      _controllerIdade.text = pet.idade.toString();
      _controllerRaca.text = pet.raca;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Pet pet = ModalRoute.of(context).settings.arguments;

    alterarPet(pet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulario do Pet"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => addOuAlterar(),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Nome"),
                controller: _controllerNome,
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Informe um nome!";
                  } else {
                    return null;
                  }
                },
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_focusIdade),
                onSaved: (value) => _formData['nome'] = value.trim(),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Idade"),
                controller: _controllerIdade,
                keyboardType: TextInputType.numberWithOptions(
                  decimal: false,
                  signed: false,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Informe a idade do pet!";
                  } else {
                    return null;
                  }
                },
                focusNode: _focusIdade,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_focusRaca),
                onSaved: (value) =>
                    _formData['idade'] = num.parse(value.trim()),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Raça"),
                controller: _controllerRaca,
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Informe a raça do pet!";
                  } else {
                    return null;
                  }
                },
                focusNode: _focusRaca,
                onFieldSubmitted: (_) => addOuAlterar(),
                onSaved: (value) => _formData['raca'] = value.trim(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addOuAlterar() {
    final isValid = _formKey.currentState.validate();

    if (isValid) {
      _formKey.currentState.save();
      Provider.of<PetsProvider>(
        context,
        listen: false,
      ).put(
        Pet(
          idPet: _formData['id'],
          nome: _formData['nome'],
          idade: _formData['idade'],
          raca: _formData['raca'],
        ),
      );
      Navigator.of(context).pop();
    }
  }
}

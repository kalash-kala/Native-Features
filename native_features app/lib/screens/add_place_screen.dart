import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:native_features/widgets/image_input.dart';
import 'package:native_features/widgets/location_input.dart';
import 'package:native_features/providers/great_places.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({Key? key}) : super(key: key);

  static const routeName = '/add-place';

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {

  final _titleController = TextEditingController();
  File ? _pickImage;

  void _selectImage(File ? pickedImage){
    _pickImage = pickedImage;
  }

  void _savePlace(){
    if(_titleController.text.isEmpty || _pickImage==null){
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false).addPlace(_titleController.text, _pickImage);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                    ),
                    SizedBox(height: 10,),
                    ImageInput(_selectImage),
                    SizedBox(height: 10,),
                    LocationInput(),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _savePlace,
            icon: Icon(Icons.add),
            label: Text('Add Place'),
          ),
        ],
      ),
    );
  }
}

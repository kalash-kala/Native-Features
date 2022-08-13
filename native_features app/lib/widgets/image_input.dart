import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths ;

class ImageInput extends StatefulWidget {

  final Function onSelectImage;
  ImageInput(this.onSelectImage);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takePicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo =
        await picker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if(photo==null){
      return;
    }

    setState(() {
      _storedImage = File(photo!.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(photo!.path);
    final savedImage = await File(photo!.path).copy('${appDir.path}/${fileName}');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150,
          height: 100,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _storedImage != null
              ? Image.file(
                  _storedImage as File,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No image added',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
            child: TextButton.icon(
                onPressed: _takePicture,
                icon: Icon(Icons.camera),
                label: Text('Take Picture'))),
      ],
    );
  }
}

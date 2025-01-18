import 'dart:io';
import 'dart:typed_data'; // For memory storage on web
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart'; // For local storage on mobile

class AddCarScreen extends StatefulWidget {
  final Function(Map<String, String>) onAddCar;

  AddCarScreen({required this.onAddCar});

  @override
  _AddCarScreenState createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  XFile? _carImage;
  Uint8List? _carImageBytes; // For storing image in memory (web)

  // Pick an image from gallery
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _carImage = image;
        if (kIsWeb) {
          // For web, read image as bytes (Uint8List)
          _carImage!.readAsBytes().then((bytes) {
            setState(() {
              _carImageBytes = bytes; // Store bytes for web
            });
          });
        } else {
          // For mobile, save the image to local storage
          _saveImageToLocal(image);
        }
      });
    }
  }

  // Save image to local storage (mobile)
  Future<void> _saveImageToLocal(XFile image) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = DateTime.now().millisecondsSinceEpoch.toString();
    final newImagePath = '${directory.path}/$name.jpg';
    final newImage = File(newImagePath);
    await newImage.writeAsBytes(await image.readAsBytes());

    setState(() {
      _carImage = XFile(newImage.path); // Update the image with the local path
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Car'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Car Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Price per day (\$)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _pickImage, child: Text('Add Photo')),
            SizedBox(height: 20),

            _carImage != null
                ? kIsWeb
                ? (_carImageBytes != null
                ? Image.memory(
              _carImageBytes!,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            )
                : CircularProgressIndicator())
                : Image.file(
              File(_carImage!.path),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            )
                : Icon(
              Icons.add_a_photo,
              size: 50,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    priceController.text.isNotEmpty) {
                  widget.onAddCar({
                    'name': nameController.text,
                    'price': '\$${priceController.text}/day',
                    'image': _carImage?.path ?? '',
                  });
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill all fields')),
                  );
                }
              },
              child: Text('Add Car'),
            ),
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' as io;
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

Future<XFile?> pickImage() async {
  if (kIsWeb) {
    // Web: Use file picker and return the image as a memory object
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  } else {
    // Android/iOS: Use native picker and return file path
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }
}

Future<Uint8List?> getImageBytes(XFile? image) async {
  if (image != null && kIsWeb) {
    return await image.readAsBytes(); // For web, read image as bytes
  }
  return null; // Return null for non-web platforms
}


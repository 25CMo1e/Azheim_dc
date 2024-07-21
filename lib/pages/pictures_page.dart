
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:azheim_care/components/photo_provider.dart'; // 确保导入PhotoProvider
import 'package:flutter/foundation.dart' show kIsWeb;

class PicturesPage extends StatefulWidget {
  @override
  _PicturesPageState createState() => _PicturesPageState();
}

class _PicturesPageState extends State<PicturesPage> {
  final TextEditingController _descriptionController = TextEditingController();
  File? _pickedImage;
  String? _imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pictures'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              _pickImage(context);
            },
            child: Text('Pick Image'),
          ),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(labelText: 'Description'),
          ),
          ElevatedButton(
            onPressed: () {
              if ((_pickedImage != null || _imageUrl != null) && _descriptionController.text.isNotEmpty) {
                final photo = Photo(
                  id: DateTime.now().millisecondsSinceEpoch,
                  path: _imageUrl ?? _pickedImage!.path,
                  description: _descriptionController.text,
                );
                Provider.of<PhotoProvider>(context, listen: false).addPhoto(photo);
                Navigator.pop(context);
              }
            },
            child: Text('Save'),
          ),
          Expanded(
            child: Consumer<PhotoProvider>(
              builder: (context, provider, child) {
                return ListView.builder(
                  itemCount: provider.photos.length,
                  itemBuilder: (context, index) {
                    final photo = provider.photos[index];
                    return ListTile(
                      leading: kIsWeb
                          ? Image.network(photo.path)
                          : Image.file(File(photo.path)),
                      title: Text(photo.description),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _pickedImage = File(image.path);
        if (kIsWeb) {
          _imageUrl = image.path; // 在实际项目中，可能需要上传图片到服务器并获取URL
        }
      });
    }
  }
}

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Photo {
  final int id;
  final String path;
  final String description;

  Photo({required this.id, required this.path, required this.description});

  Map<String, dynamic> toJson() => {
    'id': id,
    'path': path,
    'description': description,
  };

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      path: json['path'],
      description: json['description'],
    );
  }
}

class PhotoProvider with ChangeNotifier {
  List<Photo> _photos = [];

  List<Photo> get photos => _photos;

  PhotoProvider() {
    _loadPhotos();
  }

  void addPhoto(Photo photo) {
    _photos.add(photo);
    _savePhotos();
    notifyListeners();
  }

  void _savePhotos() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> photosJson = _photos.map((photo) => json.encode(photo.toJson())).toList();
    prefs.setStringList('photos', photosJson);
  }

  void _loadPhotos() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? photosJson = prefs.getStringList('photos');
    if (photosJson != null) {
      _photos = photosJson.map((photoJson) => Photo.fromJson(json.decode(photoJson))).toList();
      notifyListeners();
    }
  }
}

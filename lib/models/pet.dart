import 'package:pet_home_app/models/user_model.dart';

import 'dart:convert';

class Pet {
  final int id;
  final int user;

  List<String> images;
  String location;
  String name;

  Pet({
    required this.id,
    required this.user,
    required this.images,
    required this.name,
    required this.location,
  });

  factory Pet.fromJson(Map<String, dynamic> json) {
    final user = Pet(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      images: json['images'].cast<String>(),
      user: json['user'],
    );

    return user;
  }

  String toJson() {
    return jsonEncode({
      'id': id,
      'name': name,
      'location': location,
      'images': images,
      'user': user,
    });
  }
}

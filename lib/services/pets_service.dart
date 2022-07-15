import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pet_home_app/exceptions/server_exception.dart';
import 'package:pet_home_app/services/helper_service.dart';
import '../models/pet.dart';

class FetchPetsReturn {
  final List<Pet> pets;
  final String? cursor;

  FetchPetsReturn(this.pets, this.cursor);
}

class PetsService {
  static const String path = 'pets/';

  static Future<FetchPetsReturn> fetchPets(String? cursor) async {
    final response = cursor != null
        ? await http.get(
            Uri.parse(cursor),
            headers: HelperService.buildHeaders(),
          )
        : await http.get(
            HelperService.buildUri(
              path,
            ),
            headers: HelperService.buildHeaders(),
          );

    final statusType = HelperService.getStatusType(response.statusCode);
    switch (statusType) {
      case 200:
        final json = jsonDecode(response.body);
        final pets = <Pet>[];
        for (var pet in json['results']) {
          pets.add(Pet.fromJson(pet));
        }
        final String? cursor = json['next'];

        return FetchPetsReturn(pets, cursor);
      case 300:
      case 500:
      default:
        throw ServerException();
    }
  }
}

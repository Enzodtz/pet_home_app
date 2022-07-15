import 'package:flutter/material.dart';
import 'package:pet_home_app/models/pet.dart';
import 'package:pet_home_app/services/helper_service.dart';
import 'package:pet_home_app/utils/capitalize_extension.dart';

class PetsListItem extends StatelessWidget {
  const PetsListItem({Key? key, required this.pet}) : super(key: key);

  final Pet pet;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: () {},
          child: Ink(
            color: Colors.grey[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Ink.image(
                    fit: BoxFit.fitWidth,
                    width: double.infinity,
                    height: 0,
                    image: NetworkImage(
                      HelperService.buildString(pet.images[0]),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pet.name.capitalize(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        '15km',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

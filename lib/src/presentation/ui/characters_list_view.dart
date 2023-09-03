import 'package:casino_test/src/data/models/character.dart';
import 'package:flutter/material.dart';

class CharactersListView extends StatelessWidget {
  final List<Character> characters;
  final ScrollController scrollController;

  const CharactersListView({
    Key? key,
    required this.characters,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: PageStorageKey("characters_list"),
      controller: scrollController,
      itemCount: characters.length,
      itemBuilder: (context, index) {
        final character = characters[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Material(
            elevation: 1,
            borderRadius: BorderRadius.circular(16),
            color: Color(0xFFDFFBFC),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        character.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          character.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text("Status: ${character.status}"),
                        SizedBox(height: 8),
                        Text("Species: ${character.species}"),
                        SizedBox(height: 8),
                        Text("Type: ${character.type!.isEmpty ? "unknown" : character.type}"),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

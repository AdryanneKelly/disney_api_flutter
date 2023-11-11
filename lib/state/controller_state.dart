import 'package:disney_api_flutter/models/character_model.dart';
import 'package:disney_api_flutter/repositories/api_respository.dart';

class ControllerState {
  final repository = ApiRepository();
  Future<List<CharacterModel>> getCharacters() async {
    final response = await repository.getCharacters();
    return response;
  }
}

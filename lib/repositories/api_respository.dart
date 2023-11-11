import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:disney_api_flutter/models/character_model.dart';

class ApiRepository {
  final _dio = Dio();

  Future<List<CharacterModel>> getCharacters() async {
    try {
      final response = await _dio.get('https://api.disneyapi.dev/character');
      final data = response.data;

      final list = data['data'] as List<dynamic>;
      final characters = list.map((e) => CharacterModel.fromMap(e)).toList();

      return characters;
    } catch (e, s) {
      log('Erro $e Stacktrace $s');
      return [];
    }
  }
}

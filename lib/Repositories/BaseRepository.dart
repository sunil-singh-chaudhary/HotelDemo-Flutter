import 'dart:convert' as convert;
import 'dart:io';

import 'package:design_demo/Repositories/rest_logger.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart';

import '../exceptions/repository_exception.dart';

export 'package:http/http.dart' show Client;

abstract class BaseRepository {
  BaseRepository(
    Client? client, [
    this.baseUrl = 'jsonplaceholder.typicode.com',
  ]) : _client = client ?? Client();

  final Client _client;

  final String baseUrl;

  void close() {
    _client.close();
  }

  @protected
  Future<T> get<T>(String endpoint) async {
    final uri = Uri.https(baseUrl, endpoint);
    const logger = RestLogger(RequestMethod.get);

    logger.request(uri);

    try {
      final response = await _client.get(uri);
      final statusCode = response.statusCode;

      logger.status(uri, statusCode);

      if (statusCode == HttpStatus.ok) {
        final data = convert.jsonDecode(response.body);
        return data;
      } else {
        throw RepositoryStatusCodeException(statusCode);
      }
    } on RepositoryException catch (e, stackTrace) {
      logger.error(uri, e, stackTrace);

      rethrow;
    } catch (e, stackTrace) {
      logger.error(uri, e, stackTrace);
      throw const RepositoryException();
    }
  }
}

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/item_model.dart';

class ApiService {
  ApiService({this.baseUrl});

  final String? baseUrl;

  String get _base {
    if (baseUrl != null) return baseUrl!;

    if (kIsWeb) {
      return 'http://localhost:5000/api';
    } else {
      return 'http://10.0.2.2:5000/api';
    }
  }

  Future<Map<String, dynamic>> _post(
    String path,
    Map<String, dynamic> body, {
    String? token,
  }) async {
    final uri = Uri.parse('$_base$path');
    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
    final res = await http.post(uri, headers: headers, body: jsonEncode(body));
    return jsonDecode(res.body) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> _get(String path, {String? token}) async {
    final uri = Uri.parse('$_base$path');
    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
    final res = await http.get(uri, headers: headers);
    return jsonDecode(res.body) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final resp = await _post('/auth/login', {
      'email': email,
      'password': password,
    });
    return resp;
  }

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final resp = await _post('/auth/register', {
      'name': name,
      'email': email,
      'password': password,
    });
    return resp;
  }

  Future<List<Item>> getLostItems() async {
    final resp = await _get('/items/lost');
    final items = (resp['items'] as List<dynamic>)
        .map((e) => Item.fromJson(e as Map<String, dynamic>))
        .toList();
    return items;
  }

  Future<List<Item>> getFoundItems() async {
    final resp = await _get('/items/found');
    final items = (resp['items'] as List<dynamic>)
        .map((e) => Item.fromJson(e as Map<String, dynamic>))
        .toList();
    return items;
  }

  Future<Item> getItemDetail(String itemId) async {
    final resp = await _get('/items/$itemId');
    return Item.fromJson(resp['item'] as Map<String, dynamic>);
  }

  Future<Item> addItem({
    required String title,
    required String description,
    required String category,
    required String type,
    required String location,
    required String contactName,
    required String contactEmail,
    required String contactPhone,
    required String userId,
    DateTime? dateLostOrFound,
    String? token,
  }) async {
    try {
      final body = {
        'title': title,
        'description': description,
        'category': category,
        'status': type.toLowerCase(),
        'location': location,
        'contact': contactPhone,
        'user_id': int.parse(userId),
      };
      if (dateLostOrFound != null) {
        body['date_lost_or_found'] = dateLostOrFound.toIso8601String();
      }
      final resp = await _post('/items', body, token: token);
      if (resp.containsKey('error')) {
        throw Exception(resp['error']);
      }
      return Item.fromJson(resp['item'] as Map<String, dynamic>);
    } catch (e) {
      print('Error adding item: $e');
      rethrow;
    }
  }
}

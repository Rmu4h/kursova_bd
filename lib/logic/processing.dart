import 'package:http/http.dart' as http;
import 'dart:convert';

import 'classes.dart';

class Processing {

  Future<List<Product>> getAllProducts(int userid) async {
    var map = <String, dynamic>{};
    map['action'] = 'GET_ITEMS';
    map['userid'] = userid.toString();
    final response = await http.post(
        Uri.http('192.168.1.104', '/dbkursach/itemactions.php'),
        body: map); //instead of "localhost" input ur local IPv4
    if (200 == response.statusCode) {
      List<Product> list = parseResponse(response.body);
      return list;
    } else {
      return <Product>[];
    }
  }

  Future getProducts(int userid) async {
    try {
      getAllProducts(userid);
    } catch (e) {
      return <Product>[];
    }
  }

  static List<Product> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Product>((json) => Product.fromJson(json)).toList();
  }

  static Future<String> putProduct(Product product) async {
    try {
      var map = product.toJson();
      map['action'] = 'ADD_ITEM';
      final response = await http.post(
          Uri.http('192.168.1.104', '/dbkursach/itemactions.php'),
          body: map); //instead of "localhost" input ur local IPv4
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return 'error';
      }
    } catch (e) {
      return 'error';
    }
  }

  static Future<List<Product>> getProductsByDate(
      int userid, String date) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = 'GET_ITEMS_BY_DATE';
      map['userid'] = userid.toString();
      map['date'] = date;
      final response = await http.post(
          Uri.http('192.168.1.104', '/dbkursach/itemactions.php'),
          body: map); //instead of "localhost" input ur local IPv4
      if (200 == response.statusCode) {
        List<Product> list = parseResponse(response.body);
        return list;
      } else {
        return <Product>[];
      }
    } catch (e) {
      return <Product>[];
    }
  }

  static Future<String> updateProduct(Product product) async {
    try {
      var map = product.toJson();
      map['action'] = 'UPDATE_ITM';
      final response = await http.post(
          Uri.http('192.168.1.104', '/dbkursach/itemactions.php'),
          body: map); //instead of "localhost" input ur local IPv4
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return 'error';
      }
    } catch (e) {
      return 'error';
    }
  }

  static Future<String> deleteProduct(int product_id) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = 'DELETE_ITM';
      map['product_id'] = product_id.toString();
      final response = await http.post(
          Uri.http('192.168.1.104', '/dbkursach/itemactions.php'),
          body: map); //instead of "localhost" input ur local IPv4
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return 'error';
      }
    } catch (e) {
      return 'error';
    }
  }

  static Future<User> userLogin(String email, String password) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = 'LOG_IN';
      map['email'] = email;
      map['password'] = password;
      final response = await http.post(
          Uri.http('192.168.1.104', '/dbkursach/useraction.php'),
          body: map); //instead of "localhost" input ur local IPv4
      if (200 == response.statusCode) {
        print(response.body);
        User tempUser = User.fromJson(json.decode(response.body));
        return tempUser;
      } else {
        return Future.error("Connection error");
      }
    } catch (e) {
      return Future.error("Connection error");
    }
  }

  static Future<String> registerUser(User user) async {
    try {
      var map = user.toJson();
      map['action'] = 'SIGN_UP';

      final response = await http.post(
          Uri.http('192.168.1.104', '/dbkursach/useraction.php'),
          body: map); //instead of "localhost" input ur local IPv4
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return 'error';
      }
    } catch (e) {
      return 'error';
    }
  }
}

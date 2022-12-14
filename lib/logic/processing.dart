import 'package:http/http.dart' as http;
import 'dart:convert';

import 'classes.dart';

class Processing {
  // static Future<List<Product>> getAllProducts(int ownerId) async {
  //   //var map = <String, dynamic>{};
  //   var map = Map<String, dynamic>();
  //   map['action'] = 'GET_ITEMS';
  //   map['userid'] = ownerId.toString();
  //
  //   final response = await http.post(
  //       Uri.http('192.168.0.103', '/dbkursach/itemactions.php'),
  //       body: map); //instead of "localhost" input ur local IPv4
  //
  //   if (200 == response.statusCode) {
  //     print('before list');
  //     List<Product> list = parseResponse(response.body);
  //     print('after list');
  //     return list;
  //   } else {
  //     print('fafafafaf2');
  //
  //     return <Product>[];
  //   }
  // }
  //
  // static Future getProducts(int ownerId) async {
  //   try {
  //     getAllProducts(ownerId);
  //   } catch (e) {
  //     print('eeeerooooree - ${e}');
  //     return <Product>[];
  //   }
  // }

  static Future<List<Product>> getProducts(int userid) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = 'GET_ITEMS';
      map['userid'] = userid.toString();
      final response = await http.post(
          Uri.http('192.168.0.103', '/dbkursach/itemactions.php'),
          body: map); //instead of "localhost" input ur local IPv4
      if (200 == response.statusCode) {
        print(response.body);
        List<Product> list = parseResponse(response.body);
        print('worked');
        return list;
      } else {
        //return <Product>[];
        return Future.error('Connection Error');
      }
    } catch (e) {
      print('Помилка бля - ${e}');
      return Future.error('Exeption');
      //return <Product>[];
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
          Uri.http('192.168.0.103', '/dbkursach/itemactions.php'),
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
          Uri.http('192.168.0.103', '/dbkursach/itemactions.php'),
          body: map); //instead of "localhost" input ur local IPv4
      if (200 == response.statusCode) {
        List<Product> list = parseResponse(response.body);
        return list;
      } else {
        //return <Product>[];
        return Future.error('Connection Error');
      }
    } catch (e) {
      //return <Product>[];
      return Future.error('Exeption');
    }
  }

  static Future<String> updateProduct(Product product) async {
    try {
      var map = product.toJson();
      map['action'] = 'UPDATE_ITM';
      final response = await http.post(
          Uri.http('192.168.0.103', '/dbkursach/itemactions.php'),
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

  static Future<String> deleteProduct(int productId) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = 'DELETE_ITM';
      map['product_id'] = productId.toString();
      final response = await http.post(
          Uri.http('192.168.0.103', '/dbkursach/itemactions.php'),
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

  //my function
  static Future<String> incrementItem(int productId) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = 'DELETE_ITM';
      map['product_id'] = productId.toString();
      final response = await http.post(
          Uri.http('192.168.0.103', '/dbkursach/itemactions.php'),
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
          Uri.http('192.168.0.103', '/dbkursach/useraction.php'),
          body: map); //instead of "localhost" input ur local IPv4
      if (200 == response.statusCode) {
        if (response.body == 'error') {
          return Future.error("Wrong Email or Password");
        }
        User tempUser = User.fromJson(json.decode(response.body));
        return tempUser;
      } else {
        return Future.error("Connection error");
      }
    } catch (e) {
      return Future.error("Exeption error");
    }
  }

  //here returning error is mean that user already registered
  static Future<String> registerUser(User user) async {
    try {
      var map = user.toJson();
      map['action'] = 'SIGN_UP';

      final response = await http.post(
          Uri.http('192.168.0.103', '/dbkursach/useraction.php'),
          body: map); //instead of "localhost" input ur local IPv4
      if (200 == response.statusCode) {
        print('200');
        return response.body;
      } else {
        return 'Connection error';
      }
    } catch (e) {
      return 'exeption';
    }
  }


    static Future<String> updateUser(User user) async {
    try {
      var map = user.toJson();
      map['action'] = 'UPDATE_USER';

      final response = await http.post(
          Uri.http('192.168.0.103', '/dbkursach/useraction.php'),
          body: map); //instead of "localhost" input ur local IPv4
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return 'Connection error';
      }
    } catch (e) {
      return 'exeption';
    }
  }

  static List<Producer> parseProducers(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Producer>((json) => Producer.fromJson(json)).toList();
  }

  static Future<List<Producer>> getProducers() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = 'GET_PRODUCERS';
      final response = await http.post(
          Uri.http('192.168.0.103', '/dbkursach/producersactions.php'),
          body: map); //instead of "localhost" input ur local IPv4
      if (200 == response.statusCode) {
        List<Producer> list = parseProducers(response.body);
        return list;
      } else {
        //return <Producer>[];
        return Future.error('Connection Error');
      }
    } catch (e) {
      print('Помилка бля - ${e}');
      return Future.error('Exeption');
      //return <Producer>[];
    }
  }


    static Future<String> addProducer(Producer producer) async {
    try {
      var map = producer.toJson();
      map['action'] = 'ADD_PRODUCER';
      final response = await http.post(
          Uri.http('192.168.0.103', '/dbkursach/producersactions.php'),
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

    static Future<String> deleteProducer(int producerId) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = 'DEL_PRODUCER';
      map['producer_id'] = producerId.toString();
      final response = await http.post(
          Uri.http('192.168.0.103', '/dbkursach/producersactions.php'),
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

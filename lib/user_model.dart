import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  final int id;
  final String name;
  final String email;
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final double long;
  final double lat;
  bool isFriend;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.long,
    required this.lat,
    this.isFriend = false,
  });

  static Future<List<User>> getUsers() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.body != null) {
      final List<dynamic> data = jsonDecode(response.body);
      return data
          .map((user) => User(
                id: user['id'],
                name: user['name'],
                email: user['email'],
                street: user['address']['street'],
                suite: user['address']['suite'],
                city: user['address']['city'],
                zipcode: user['address']['zipcode'],
                long: double.parse(user['address']['geo']['lng']),
                lat: double.parse(user['address']['geo']['lat']),
              ))
          .toList();
    } else {
      throw Exception('Failed to fetch users');
    }
  }
}

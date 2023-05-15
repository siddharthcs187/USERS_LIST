import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:users_list/user_model.dart';
import 'package:users_list/user_widget.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool friendsOnly = false;
  TextEditingController _controller = TextEditingController();
  List<User> allUsers = [];
  List<User> filteredUsers = [];
  double sliderValue = 0.0;

  Future<List<User>> getUsers() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
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

  Future<List<User>> getFriends() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('friends').get();

      List<User> friends = [];

      querySnapshot.docs.forEach((doc) {
        User friend = User(
          id: doc['id'] as int,
          name: doc['name'],
          email: doc['email'],
          street: doc['street'],
          suite: doc['suite'],
          city: doc['city'],
          zipcode: doc['zipcode'],
          long: doc['long'] as double,
          lat: doc['lat'] as double,
        );

        friends.add(friend);
      });

      return friends;
    } catch (e) {
      print('Error fetching friends: $e');
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUsersAndFriends();
  }

  void fetchUsersAndFriends() async {
    try {
      List<User> apiUsers = await getUsers();
      List<User> firebaseFriends = await getFriends();

      List<User> mergedData = [];

      mergedData.addAll(apiUsers);

      for (User firebaseFriend in firebaseFriends) {
        bool isDuplicate =
            apiUsers.any((apiUser) => apiUser.id == firebaseFriend.id);
        if (!isDuplicate) {
          mergedData.add(firebaseFriend);
        }
      }

      mergedData.forEach((user) {
        if (firebaseFriends.any((friend) => friend.id == user.id)) {
          user.isFriend = true;
        }
      });

      setState(() {
        allUsers = mergedData;
        filterUsers(_controller.text, sliderValue);
      });
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  void filterUsers(String searchText, double sliderValue) {
    setState(() {
      if (friendsOnly) {
        if (sliderValue == 0) {
          filteredUsers = allUsers
              .where((user) =>
                  user.name.toLowerCase().contains(searchText.toLowerCase()) &&
                  user.isFriend)
              .toList();
        } else {
          filteredUsers = allUsers
              .where((user) =>
                  user.name.toLowerCase().contains(searchText.toLowerCase()) &&
                  user.isFriend &&
                  user.long == sliderValue)
              .toList();
        }
      } else {
        if (sliderValue == 0) {
          filteredUsers = allUsers
              .where((user) =>
                  user.name.toLowerCase().contains(searchText.toLowerCase()))
              .toList();
        } else {
          filteredUsers = allUsers
              .where((user) =>
                  user.name.toLowerCase().contains(searchText.toLowerCase()) &&
                  user.long == sliderValue)
              .toList();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1E1E),
      body: SafeArea(
        child: Stack(children: [
          SvgPicture.asset('Vector 72.svg'),
          SvgPicture.asset('Vector 75.svg'),
          SvgPicture.asset('Vector 76.svg'),
          SvgPicture.asset('Vector 80.svg'),
          SvgPicture.asset('Vector 81.svg'),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF1E1E1E),
            ),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Users',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          friendsOnly = !friendsOnly;
                          filterUsers(_controller.text, sliderValue);
                        },
                        icon: Icon(
                          Icons.person_2_outlined,
                          color: friendsOnly ? Colors.amber : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Color(0xFFF8D848).withOpacity(0.45)),
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFA46C00).withOpacity(0.15),
                        const Color(0xFFD19A08).withOpacity(0.15),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: const [0.1, 0.8],
                    ),
                  ),
                  child: TextField(
                    style: const TextStyle(color: Color(0xFFC0C0C0)),
                    controller: _controller,
                    onChanged: (value) {
                      filterUsers(value, sliderValue);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search for name...',
                      hintStyle: const TextStyle(color: Color(0xFFC0C0C0)),
                      border: InputBorder.none,
                      prefixIcon:
                          const Icon(Icons.search, color: Color(0xFFC0C0C0)),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear, color: Color(0xFFC0C0C0)),
                        onPressed: () {
                          setState(() {
                            _controller.clear();
                            filterUsers('', sliderValue);
                          });
                        },
                      ),
                      contentPadding: const EdgeInsets.all(8.0),
                      filled: true,
                      fillColor: Colors.transparent,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onDoubleTap: () {
                    setState(() {
                      sliderValue = 0;
                      filterUsers(_controller.text, 0.0);
                    });
                  },
                  child: Slider(
                    activeColor: Colors.amber,
                    inactiveColor: Colors.white,
                    value: sliderValue,
                    min: -200,
                    max: 200,
                    onChanged: (value) {
                      setState(() {
                        sliderValue = value;
                        filterUsers(_controller.text, sliderValue);
                      });
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final user = filteredUsers[index];
                        return UserWidget(user: user);
                      },
                      itemCount: filteredUsers.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

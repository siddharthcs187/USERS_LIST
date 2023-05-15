import 'package:flutter/material.dart';

import 'firebase_service.dart';
import 'package:users_list/user_model.dart';

class UserWidget extends StatefulWidget {
  final User user;

  const UserWidget({Key? key, required this.user}) : super(key: key);

  @override
  _UserWidgetState createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  FirebaseService firebaseService = FirebaseService();

  Future<void> _toggleFriendship() async {
    if (widget.user.isFriend) {
      await firebaseService.removeFriend(widget.user);
    } else {
      await firebaseService.addFriend(widget.user);
    }
    setState(() {
      widget.user.isFriend = !widget.user.isFriend;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF7B7B7B)),
        gradient: LinearGradient(colors: [
          const Color(0xFFFFA800).withOpacity(0.12),
          const Color(0xFFE79900).withOpacity(0.098),
          const Color(0xFF9E6900).withOpacity(0),
        ], stops: const [
          0.0,
          0.6414,
          1.0
        ], begin: Alignment.bottomRight, end: Alignment.topLeft),
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Expanded(
            child: GestureDetector(
              onTap: _toggleFriendship,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.user.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: widget.user.isFriend ? Colors.amber : Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.user.email,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.amber,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${widget.user.street} - ${widget.user.suite}",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${widget.user.city} - ${widget.user.zipcode}",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "${widget.user.long}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        width: 120,
                      ),
                      const Icon(
                        (IconData(0xee2d, fontFamily: 'MaterialIcons')),
                        color: Colors.white,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "${widget.user.lat}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

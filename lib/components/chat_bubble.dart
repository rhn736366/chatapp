import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  //show options
  void _showOption(BuildContext context, String messageId, String userId) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
            child:
            Wrap(
            children: [
              // report message button
              ListTile(
                leading: const Icon(Icons.flag),
                title: const Text('Report'),
                onTap: (){

                },
              )

        ]));
      },
    );
  }

  // report message

  // block user

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onLongPress: () {
        if (!isCurrentUser) {
          // show options
          _showOption()
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        decoration: BoxDecoration(
          color: isCurrentUser
              ? (isDarkMode ? Colors.green.shade600 : Colors.grey.shade500)
              : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: Radius.circular(isCurrentUser ? 12 : 0),
            bottomRight: Radius.circular(isCurrentUser ? 0 : 12),
          ),
        ),
        child: Text(
          message,
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}

import 'package:chatapp/pages/login_page.dart';
import 'package:chatapp/pages/settings_pages.dart';
import 'package:flutter/material.dart';

import '../service/auth/auth_service.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    final _auth = AuthService();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Center(child: Icon(Icons.message_rounded, size: 40)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: ListTile(
                  title: Text("H O M E"),
                  leading: Icon(Icons.home),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: ListTile(
                  title: Text("S E T T I N G S"),
                  leading: Icon(Icons.settings),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsPages()),
                    );
                  },
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(left: 18.0, bottom: 20),
            child: ListTile(
              title: Text("L O G O U T"),
              leading: Icon(Icons.logout),
              onTap: () {
                final color = Theme.of(context).colorScheme.inversePrimary;
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    title: Text(
                      "Confirm Logout",
                      style: TextStyle(color: color),
                    ),
                    content: Text(
                      "Are you sure you want to log out?",
                      style: TextStyle(color: color.withOpacity(0.7)),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: TextButton.styleFrom(foregroundColor: color),
                        child: Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          logout();
                        },
                        style: TextButton.styleFrom(foregroundColor: color),
                        child: Text("Logout"),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

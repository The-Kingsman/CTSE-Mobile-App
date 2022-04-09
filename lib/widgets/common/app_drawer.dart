import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teach_rate/models/User.dart';
import 'package:teach_rate/screens/auth/signin_screen.dart';
import 'package:teach_rate/screens/auth/user_profile_screen.dart';
import 'package:teach_rate/screens/class/classes_screen.dart';
import 'package:teach_rate/screens/teacher/teachers_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.teal.shade400,
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: mediaQuery.padding.top + 20),
            Image.asset(
              'assets/images/logo.png',
              width: 220,
            ),
            const SizedBox(height: 20),
            const Divider(
              height: 1,
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(
                Icons.portrait,
                color: Colors.white,
              ),
              title: const Text(
                'Profile',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                User user = User.fromJson(
                    json.decode(prefs.getString('user').toString()));
                user.id = prefs.getString('userID').toString();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewUserProfileScreen(user),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              title: const Text(
                'Teachers',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TeachersScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: const Text(
                'Classes',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ClassesScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 50.0),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              title: const Text(
                'Sign Out',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    content: const Text('Are you sure you want to logout?'),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    backgroundColor: Colors.teal.shade400,
                    contentTextStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    titleTextStyle:
                        const TextStyle(color: Colors.white, fontSize: 23),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        child: const Text(
                          'No',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      FlatButton(
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.clear();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignInScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        child: const Text(
                          'Yes',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

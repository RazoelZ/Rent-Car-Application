import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rentvehicle_application/screen/login.dart';
import 'package:rentvehicle_application/screen/profile.dart';
import 'package:rentvehicle_application/screen/mainpage.dart';
import 'package:rentvehicle_application/screen/historypeminjaman.dart';
import 'package:rentvehicle_application/screen/scan.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  final callPage = [
    MainPage(),
    HistoryPeminjamanPage(),
    ScanPage(),
    ProfilePage()
  ];

  startLaunching() async {
    final prefs = await SharedPreferences.getInstance();
    bool? isLogin = prefs.getBool("isLogin") ?? false;
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) {
          return isLogin ? HomePage() : LoginPage();
        },
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
            context: context,
            builder: ((context) {
              return AlertDialog(
                title: Text("Keluar Aplikasi"),
                content: Text("Apakah anda yakin ingin keluar dari aplikasi?"),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text("Tidak"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text("Ya"),
                  ),
                ],
              );
            }));
        if (value != null) {
          return Future.value(value);
        } else {
          return Future.value(false);
        }
      },
      child: Scaffold(
        body: IndexedStack(index: currentIndex, children: callPage),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          showUnselectedLabels: false,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: "Peminjaman",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: "Scan"),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}

////////////////////////

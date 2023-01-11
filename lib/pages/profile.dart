import 'package:flutter/material.dart';
import 'package:rentvehicle_application/pages/login.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Akun"),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(50),
        child: Column(
          children: <Widget>[
            Container(
              child: Image(image: AssetImage("assets/images/logo.png")),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                "Arka Joko Pranoto",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                "arkadiojoko@gmail.com",
                style: TextStyle(fontSize: 15),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 100),
              child: ElevatedButton(
                child: Text("Logout"),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) {
                    return LoginPage();
                  })));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

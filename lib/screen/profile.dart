import 'package:flutter/material.dart';
import 'package:rentvehicle_application/screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _nama = TextEditingController();

  pref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username.text = prefs.getString("username")!;
      _nama.text = prefs.getString("nama")!;
    });
  }

  @override
  void initState() {
    super.initState();
    pref();
  }

  _logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLogin", false);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
              child: Text(_nama.text, style: TextStyle(fontSize: 20)),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(_username.text, style: TextStyle(fontSize: 20)),
            ),
            Container(
              margin: EdgeInsets.only(top: 100),
              child: ElevatedButton(
                child: Text("Logout"),
                onPressed: () {
                  _logOut();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

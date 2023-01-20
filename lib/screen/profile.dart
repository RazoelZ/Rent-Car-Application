import 'package:flutter/material.dart';
import 'package:rentvehicle_application/model/UserModel.dart';
import 'package:rentvehicle_application/core/repository.dart';
import 'package:rentvehicle_application/screen/login.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User user = User();
  UserRepository repository = UserRepository();

  getData() async {
    var data = await repository.getData();
    setState(() {
      user = data;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
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
              child: Text((user != null) ? user.nama.toString() : "Loading...",
                  style: TextStyle(fontSize: 15)),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                  (user != null) ? user.username.toString() : "Loading...",
                  style: TextStyle(fontSize: 15)),
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

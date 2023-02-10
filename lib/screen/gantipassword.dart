import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class GantiPasswordPage extends StatefulWidget {
  const GantiPasswordPage({super.key});

  @override
  State<GantiPasswordPage> createState() => _GantiPasswordPageState();
}

final TextEditingController passwordlama = TextEditingController();
final TextEditingController passwordbaru = TextEditingController();
final TextEditingController passwordbaru2 = TextEditingController();

class _GantiPasswordPageState extends State<GantiPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ganti Password"),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(50, 50, 50, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text("Ganti Password Anda",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey)),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: TextFormField(
                controller: passwordlama,
                decoration: InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: TextFormField(
                controller: passwordbaru,
                decoration: InputDecoration(
                  labelText: "Password Baru",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: TextFormField(
                controller: passwordbaru2,
                decoration: InputDecoration(
                  labelText: "Ulangi Password Baru",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

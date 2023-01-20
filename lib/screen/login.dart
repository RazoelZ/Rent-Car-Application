import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentvehicle_application/core/api_client.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:http/http.dart' as http;
import 'package:rentvehicle_application/screen/forgotpassword.dart';
import 'package:rentvehicle_application/screen/home.dart';

class LoginPage extends StatelessWidget {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Container(
          padding: EdgeInsets.fromLTRB(70, 0, 70, 0),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 250,
                  padding: EdgeInsets.all(3),
                  child: Image(
                    image: AssetImage("assets/images/logo.png"),
                    fit: BoxFit.contain,
                  ),
                ),
                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                      labelText: "Email",
                      icon: Icon(Icons.email_outlined),
                      hintText: "Masukan Email"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Masukan Email!";
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      labelText: "Password",
                      icon: Icon(Icons.lock_outline),
                      hintText: "Masukan Password"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Masukan Password!";
                    } else {
                      return null;
                    }
                  },
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        onPressed: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        }),
                        child: Text("Login"))),
                Container(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPasswordPage()));
                    },
                    child: Text(
                      "Lupa Password?",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )));
  }

//   Future<void> login() async {
//     if (usernameController.text.isNotEmpty &&
//         passwordController.text.isNotEmpty) {
//       var response = await http.post(
//           Uri.parse(ApiEndPoints.BASE_URL + ApiEndPoints.auth.login),
//           body: ({
//             "email": usernameController.text,
//             "password": passwordController.text
//           }));
//       if (response.statusCode == 200) {
//         Get.offAll(HomePage());
//       } else {
//         SnackBar(content: Text("Login Gagal"));
//       }
//     } else {
//       SnackBar(content: Text("Masukan Email dan Password"));
//     }
//   }
}

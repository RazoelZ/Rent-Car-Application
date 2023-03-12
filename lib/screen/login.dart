import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:DESARMADA/constants.dart';
import 'package:DESARMADA/screen/forgotpassword.dart';
import 'package:DESARMADA/screen/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slider_captcha/slider_capchar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _iscaptcha = false;
  final SliderController controller = SliderController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obsecuretext = true;
  bool visible = false;
  final String sUrl = "$kBASE_URL/api/UserAuthentication";

  //fungsi captcha
  _onCaptcha() {
    setState(() {
      _iscaptcha = true;
    });
  }

  //fungsi cek login
  _cekLogin() async {
    if (_iscaptcha == false) {
      AlertDialog alert = AlertDialog(
        title: Text("Login Gagal"),
        content: Text("Captcha belum diisi"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"))
        ],
      );
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          });
      return;
    }

    setState(() {
      visible = true;
    });
    final prefs = await SharedPreferences.getInstance();

    var params =
        "?username=${usernameController.text}&password=${passwordController.text}";
    try {
      var res = await http.get(Uri.parse(sUrl + params));
      if (res.statusCode == 200) {
        var response = json.decode(res.body);
        prefs.setString("id_user", response['data']['id_user']);
        prefs.setString("username", response['data']['username']);
        prefs.setString("nama", response['data']['nama']);
        prefs.setBool("isLogin", true);
        setState(() {
          visible = false;
        });
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => HomePage()));
      } else {
        setState(() {
          visible = false;
        });
        AlertDialog alert = AlertDialog(
          title: Text("Login Gagal"),
          content: Text("Username atau Password Salah"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"))
          ],
        );
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert;
            });
      }
    } catch (e) {
      print(e);
    }
  }

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
                  controller: usernameController..text = "randika@gmail.com",
                  decoration: InputDecoration(
                      labelText: "username",
                      icon: Icon(Icons.person_outline),
                      hintText: "Masukan username"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Masukan Username!";
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  controller: passwordController..text = "123456",
                  obscureText: _obsecuretext,
                  decoration: InputDecoration(
                      labelText: "Password",
                      icon: Icon(Icons.lock_outline),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obsecuretext = !_obsecuretext;
                            });
                          },
                          child: _obsecuretext
                              ? Icon(Icons.remove_red_eye)
                              : Icon(Icons.remove_red_eye_outlined)),
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
                    margin: const EdgeInsets.only(top: 10),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Center(
                                      child: Container(
                                        margin: const EdgeInsets.all(30),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(40)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: SliderCaptcha(
                                            title: "Geser untuk verifikasi",
                                            titleStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                            controller: controller,
                                            image: Image.asset(
                                              'assets/images/captcha.jpg',
                                              fit: BoxFit.fitWidth,
                                            ),
                                            onConfirm: (value) async {
                                              if (value == true) {
                                                _onCaptcha();
                                                Navigator.pop(context);
                                              }
                                            },
                                            colorBar: Colors.white,
                                            colorCaptChar: Colors.blue,
                                            space: 30,
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: Text("Verifikasi anda bukan robot!")),
                        Container(
                            child: (_iscaptcha == true)
                                ? Container(
                                    width: 20,
                                    height: 20,
                                    color: Colors.green,
                                  )
                                : Container(
                                    width: 20,
                                    height: 20,
                                    color: Colors.red,
                                  )),
                      ],
                    )),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        onPressed: (() {
                          _cekLogin();
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
}

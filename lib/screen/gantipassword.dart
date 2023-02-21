import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:rentvehicle_application/core/repository.dart';
import 'package:rentvehicle_application/model/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GantiPasswordPage extends StatefulWidget {
  const GantiPasswordPage({super.key});

  @override
  State<GantiPasswordPage> createState() => _GantiPasswordPageState();
}

class _GantiPasswordPageState extends State<GantiPasswordPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pref();
    getData();
  }

  @override
  pref() async {
    final prefs = await SharedPreferences.getInstance();
    _iduser.text = prefs.getString("id_user")!;
  }

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  getData() async {
    var data = await userRepository.getData();
    setState(() {
      data.forEach((element) {
        if (element.id_user.toString() == _iduser.text) {
          userData.add(element);
        }
      });
    });
  }

  bool _obsecuretext = true;
  bool _obsecuretext1 = true;
  bool _obsecuretext2 = true;
  final _formState = GlobalKey<FormState>();
  final TextEditingController _iduser = TextEditingController();
  final TextEditingController passwordlama = TextEditingController();
  final TextEditingController passwordbaru = TextEditingController();
  final TextEditingController passwordbaru2 = TextEditingController();
  UserRepository userRepository = UserRepository();
  List<User> userData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ganti Password"),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(50, 50, 50, 40),
        child: Form(
          key: _formState,
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
                  obscureText: _obsecuretext,
                  decoration: InputDecoration(
                    labelText: "Password Lama",
                    border: OutlineInputBorder(),
                    suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obsecuretext = !_obsecuretext;
                          });
                        },
                        child: _obsecuretext
                            ? Icon(Icons.remove_red_eye)
                            : Icon(Icons.remove_red_eye_outlined)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Masukan Password lama anda!";
                    } else if (generateMd5(passwordlama.text) !=
                        userData[0].password.toString()) {
                      return "Password lama anda salah!";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: TextFormField(
                  controller: passwordbaru,
                  obscureText: _obsecuretext1,
                  decoration: InputDecoration(
                    labelText: "Password Baru",
                    border: OutlineInputBorder(),
                    suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obsecuretext1 = !_obsecuretext1;
                          });
                        },
                        child: _obsecuretext
                            ? Icon(Icons.remove_red_eye)
                            : Icon(Icons.remove_red_eye_outlined)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Masukan Password anda yang baru!";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: TextFormField(
                  controller: passwordbaru2,
                  obscureText: _obsecuretext2,
                  decoration: InputDecoration(
                    labelText: "Ulangi Password Baru",
                    border: OutlineInputBorder(),
                    suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obsecuretext2 = !_obsecuretext2;
                          });
                        },
                        child: _obsecuretext
                            ? Icon(Icons.remove_red_eye)
                            : Icon(Icons.remove_red_eye_outlined)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Masukan Password anda yang baru !";
                    } else if (passwordbaru.text != passwordbaru2.text) {
                      return "Password tidak sama";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formState.currentState!.validate()) {
                      bool response = await userRepository.updatePassword(
                        _iduser.text,
                        generateMd5(passwordbaru.text),
                      );
                      if (response == true) {
                        CoolAlert.show(
                          context: context,
                          type: CoolAlertType.success,
                          text: "Password berhasil diubah",
                          onConfirmBtnTap: () {
                            Navigator.pop(context);
                          },
                        );
                      } else {
                        CoolAlert.show(
                          context: context,
                          type: CoolAlertType.error,
                          text: "Password gagal diubah",
                          onConfirmBtnTap: () {
                            Navigator.pop(context);
                          },
                        );
                      }
                    }
                  },
                  child: Text("Ganti Password"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

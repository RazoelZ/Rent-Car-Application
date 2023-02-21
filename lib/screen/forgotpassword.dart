import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:rentvehicle_application/core/repository.dart';
import 'package:rentvehicle_application/model/UserModel.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  List<User> user = [];
  UserRepository userRepository = UserRepository();
  final TextEditingController _username = TextEditingController();
  final _formState = GlobalKey<FormState>();

  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    var data = await userRepository.getData();
    setState(() {
      user = data;
    });
  }

  Future<void> sendMail() async {
    try {
      // var userEmail = user
      //     .where((element) => element.username == _username.text)
      //     .toList()[0]
      //     .username;
      var userEmail = 'dany.razoel69@gmail.com';
      var message = Message();
      message.subject = 'Lupa Password';
      message.text = 'Halo ini saya flutter';
      message.from = Address(userEmail.toString());
      message.recipients.add('jokopranowow99@gmail.com');
      var smtpServer = gmailRelaySaslXoauth2(userEmail, 'geawdutmyzsuypwm');
      send(message, smtpServer);
      print("Email berhasil dikirim");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Email berhasil dikirim")));
    } catch (e) {
      print(e.toString());
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Form(
          key: _formState,
          child: Container(
            padding: EdgeInsets.fromLTRB(70, 0, 70, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  child: Text("Lupa Password?",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue)),
                ),
                TextFormField(
                  controller: _username,
                  decoration: InputDecoration(
                      labelText: "Email",
                      icon: Icon(Icons.email_outlined),
                      hintText: "Masukan Email"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Masukan Email!";
                    }
                    //cek username ada atau tidak
                    else if (user
                            .where((element) => element.username == value)
                            .toList()
                            .length ==
                        0) {
                      return "Email tidak terdaftar!";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        onPressed: (() {
                          if (_formState.currentState!.validate()) {
                            sendMail();
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Processing Data")));
                          }
                        }),
                        child: Text("Submit"))),
                Container(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Sudah ingat?",
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

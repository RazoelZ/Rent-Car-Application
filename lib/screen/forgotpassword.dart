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
    String username = 'dany.razoel69@gmail.com';
    String password = 'geawdutmyzsuypwm';

    final smtpServer = gmail(username, password);
    final equivalentMessage = Message()
      ..from = Address(username, 'Your name')
      ..recipients.add(Address('jokopranowow99@gmail.com'))
      ..subject = 'Ganti Password'
      ..html =
          "<h1>Hallo user!</h1><p>Email ini dikirim untuk me reset password.</p><p><a href=\"http://localhost:8080/lupa_password/reset_password/c4ca4238a0b923820dcc509a6f75849b\">Click disini untuk me reset password anda</a></p><img src=\"https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png\" /> ";
    await send(equivalentMessage, smtpServer);
    print('Message sent: ' + equivalentMessage.toString());
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

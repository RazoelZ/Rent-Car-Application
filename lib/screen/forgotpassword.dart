import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:DESARMADA/core/repository.dart';
import 'package:DESARMADA/model/UserModel.dart';
import 'package:DESARMADA/screen/login.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  List<User> user = [];
  UserRepository userRepository = UserRepository();
  final TextEditingController _username = TextEditingController();
  final _formState = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getData();
  }

  //mengambil data dari user
  getData() async {
    var data = await userRepository.getData();
    setState(() {
      user = data;
    });
  }

  //Mengirim email ke untuk mendapatkan link ganti password
  Future<void> sendMail() async {
    String username = 'dany.razoel69@gmail.com';
    String password = 'geawdutmyzsuypwm';

    final smtpServer = gmail(username, password);
    final equivalentMessage = Message()
      ..from = Address(username, 'DESARMADA Reset Password')
      ..recipients.add(Address('jokopranowow99@gmail.com'))
      ..subject = 'Reset Password'
      ..html =
          "<p>Klik link ini untuk reset password anda : <a href=\"http://localhost:8080/lupa_password/reset_password/c4ca4238a0b923820dcc509a6f75849b\">Reset Password</a></p><p><b>Noted:</b> Jika anda tidak merasa melakukan reset password, abaikan email ini!.</p> ";
    await send(equivalentMessage, smtpServer);
    if (smtpServer != null) {
      AlertDialog alert = AlertDialog(
        title: Text("Email Berhasil Dikirim"),
        content: Text("Silahkan cek inbox email anda"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage()));
              },
              child: Text("Kembali ke halaman login"))
        ],
      );
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          });
    } else {
      AlertDialog alert = AlertDialog(
        title: Text("Email gagal dikirim "),
        content: Text("Silahkan cek koneksi internet anda"),
        actions: [TextButton(onPressed: () {}, child: Text("OK"))],
      );
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          });
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
                        .isEmpty) {
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

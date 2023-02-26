import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rentvehicle_application/constants.dart';
import 'package:rentvehicle_application/core/repository.dart';
import 'package:rentvehicle_application/screen/home.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PeminjamanPage extends StatefulWidget {
  final String id_kendaraan;
  final String tipe_kendaraan;

  const PeminjamanPage(
      {Key? key, required this.id_kendaraan, required this.tipe_kendaraan})
      : super(key: key);
  @override
  State<PeminjamanPage> createState() => _PeminjamanPageState();
}

class _PeminjamanPageState extends State<PeminjamanPage> {
  @override
  void initState() {
    super.initState();
    _idkendaraan.text = widget.id_kendaraan;
    pref();
    print(widget.tipe_kendaraan);
  }

  pref() async {
    final prefs = await SharedPreferences.getInstance();
    _iduser.text = prefs.getString("id_user")!;
  }

  int _index = 0;

  PeminjamanRepository peminjamanRepository = PeminjamanRepository();
  KendaraanRepository kendaraanRepository = KendaraanRepository();

  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];
  DateTime? _selectedDate;
  final TextEditingController _idkendaraan = TextEditingController();
  final TextEditingController _iduser = TextEditingController();
  final TextEditingController _tanggalpinjamController =
      TextEditingController();
  final TextEditingController _jampinjamController = TextEditingController();
  final TextEditingController _kmawalController = TextEditingController();
  final TextEditingController _saldoawalController = TextEditingController();
  final TextEditingController _tujuan = TextEditingController();
  final TextEditingController _keperluanController = TextEditingController();
  final TextEditingController _driverController = TextEditingController();

  List<Step> steps() => [
        Step(
            isActive: _index >= 0 ? true : false,
            title: const Text('Langkah 1'),
            content: Form(
              key: _formKeys[0],
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Tanggal Pinjam",
                        icon: Icon(Icons.calendar_month)),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2015),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _tanggalpinjamController.text =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                        });
                      }
                    },
                    controller: _selectedDate == null
                        ? _tanggalpinjamController
                        : TextEditingController(
                            text: _selectedDate!
                                .toLocal()
                                .toString()
                                .split(' ')[0]),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Masukan Tanggal Pinjam!";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _jampinjamController,
                    decoration: InputDecoration(
                        labelText: "Jam Pinjam",
                        icon: Icon(Icons.punch_clock_outlined)),
                    readOnly: true,
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                      );
                      if (pickedTime != null) {
                        setState(() {
                          _jampinjamController.text =
                              pickedTime.format(context);
                        });
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Masukan Jam Pinjam!";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _kmawalController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "KM Awal",
                        icon: Icon(Icons.speed),
                        suffixText: "KM"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Masukan Tanggal Pinjam!";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _saldoawalController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Saldo Awal",
                        icon: const Icon(Icons.money),
                        prefixText: "Rp. "),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Masukan Tanggal Pinjam!";
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              ),
            )),
        Step(
            isActive: _index >= 1 ? true : false,
            title: const Text('Langkah 2'),
            content: Form(
              key: _formKeys[1],
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _tujuan,
                    decoration: const InputDecoration(
                        labelText: "Kota Tujuan",
                        icon: Icon(Icons.location_on_outlined)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Masukan Kota Tujuan Anda!";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _keperluanController,
                    decoration: const InputDecoration(
                      labelText: "Keperluan",
                      icon: Icon(Icons.text_fields),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Masukan Keperluan Anda!";
                      } else {
                        return null;
                      }
                    },
                  ),
                  DropdownSearch<String>(
                    dropdownSearchDecoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: "Driver",
                    ),
                    dropdownButtonBuilder: (context) {
                      return Container(
                        margin: EdgeInsets.only(right: 20),
                        child: Icon(Icons.arrow_drop_down),
                      );
                    },
                    mode: Mode.MENU,
                    enabled: true,
                    showSearchBox: true,
                    onFind: (text) async {
                      var response = await http.get(Uri.parse(
                          '$kBASE_URL/api/driver'));
                      if (response.statusCode != 200) {
                        return [];
                      }
                      List data = json.decode(response.body);
                      List<String> Listdrivernama = [];
                      data.forEach((element) {
                        Listdrivernama.add(element['nama']);
                      });
                      return Listdrivernama;
                    },
                    onChanged: (value) {
                      setState(() {
                        _driverController.text = value!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Masukan Driver Anda!";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKeys[0].currentState!.validate() &&
                            _formKeys[1].currentState!.validate()) {
                          bool response =
                              await peminjamanRepository.postPeminjamanData(
                                  _idkendaraan.text,
                                  _iduser.text,
                                  _tanggalpinjamController.text,
                                  _jampinjamController.text,
                                  _kmawalController.text,
                                  _saldoawalController.text,
                                  _keperluanController.text,
                                  _driverController.text,
                                  _tujuan.text);
                          bool responseUpdate =
                              await kendaraanRepository.updateStatusKendaraan(
                            _idkendaraan.text,
                            1,
                          );
                          if (response == true && responseUpdate == true) {
                            //harus check message 500
                            CoolAlert.show(
                                context: context,
                                type: CoolAlertType.success,
                                text: "Peminjaman Anda Berhasil!",
                                confirmBtnText: "Selesai",
                                onConfirmBtnTap: (() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()));
                                }));
                          } else {
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.error,
                              text: "Peminjaman Anda gagal :(",
                              confirmBtnText: "Kembali",
                            );
                          }
                        }
                      },
                      child: Text("Submit"),
                    ),
                  )
                ],
              ),
            )),
      ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Form Peminjaman ' + widget.tipe_kendaraan),
        ),
        body: Stepper(
            controlsBuilder: (context, _) {
              return Row(
                children: <Widget>[
                  Container(
                    child: TextButton(
                      onPressed: onStepContinue,
                      child: const Text('Selanjutnya'),
                    ),
                  ),
                  Container(
                    child: TextButton(
                      onPressed: onStepCancel,
                      child: const Text('Sebelumnya'),
                    ),
                  ),
                ],
              );
            },
            currentStep: _index,
            type: StepperType.horizontal,
            steps: steps()));
  }

  void onStepContinue() {
    if (!_formKeys[_index].currentState!.validate()) {
      return null;
    }
    if (_index < steps().length - 1) {
      setState(() {
        _index += 1;
      });
    }
  }

  void onStepCancel() {
    if (_index == 0) {
      return null;
    } else {
      setState(() {
        _index -= 1;
      });
    }
  }
}

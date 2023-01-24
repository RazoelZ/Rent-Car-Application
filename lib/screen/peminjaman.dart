import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rentvehicle_application/core/repository.dart';
import 'package:rentvehicle_application/screen/home.dart';

class PeminjamanPage extends StatefulWidget {
  const PeminjamanPage({super.key});

  @override
  State<PeminjamanPage> createState() => _PeminjamanPageState();
}

class _PeminjamanPageState extends State<PeminjamanPage> {
  int _index = 0;

  PeminjamanRepository peminjamanRepository = PeminjamanRepository();

  List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];
  DateTime? _selectedDate;
  TextEditingController _idkendaraan = TextEditingController();
  TextEditingController _iduser = TextEditingController();
  TextEditingController _tanggalpinjamController = TextEditingController();
  TextEditingController _jampinjamController = TextEditingController();
  TextEditingController _kmawalController = TextEditingController();
  TextEditingController _saldoawalController = TextEditingController();
  TextEditingController _tujuan = TextEditingController();
  TextEditingController _keperluanController = TextEditingController();
  TextEditingController _driverController = TextEditingController();

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
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate ?? DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          _selectedDate = selectedDate;
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
                    decoration: InputDecoration(
                        labelText: "Saldo Awal",
                        icon: Icon(Icons.money),
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
                    controller: _iduser,
                    inputFormatters: [],
                    decoration: InputDecoration(
                        labelText: "Id User",
                        icon: Icon(Icons.indeterminate_check_box)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Masukan id user Anda!";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _idkendaraan,
                    decoration: InputDecoration(
                        labelText: "Id Kendaraan",
                        icon: Icon(Icons.woman_rounded)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Masukan Id Kendaraan Anda!";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _tujuan,
                    decoration: InputDecoration(
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
                    decoration: InputDecoration(
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
                  TextFormField(
                    controller: _driverController,
                    decoration: InputDecoration(
                        labelText: "Driver", icon: Icon(Icons.person)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Masukan Driver anda!";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                          onPressed: () async {
                            bool response =
                                await peminjamanRepository.postPeminjamanData(
                                    _iduser.text,
                                    _idkendaraan.text,
                                    _tanggalpinjamController.text,
                                    _jampinjamController.text,
                                    _kmawalController.text,
                                    _saldoawalController.text,
                                    _tujuan.text,
                                    _keperluanController.text,
                                    _driverController.text);
                            if (response) {
                              SnackBar(
                                content: Text("Berhasil"),
                              );
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                            } else {
                              SnackBar(
                                content: Text("Gagal"),
                              );
                            }
                          },
                          child: Text("Submit")))
                ],
              ),
            )),
      ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pengisian Form Peminjaman'),
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

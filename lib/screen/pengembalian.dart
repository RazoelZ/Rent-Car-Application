import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rentvehicle_application/constants.dart';
import 'package:rentvehicle_application/core/repository.dart';
import 'package:rentvehicle_application/model/PeminjamanModel.dart';
import 'package:rentvehicle_application/screen/uploadimage.dart';
import 'package:rentvehicle_application/screen/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PengembalianPage extends StatefulWidget {
  final String? id_kendaraan;
  final String? km;
  final String? total_saldo_tol;

  const PengembalianPage(
      {Key? key, this.id_kendaraan, this.km, this.total_saldo_tol})
      : super(key: key);
  @override
  State<PengembalianPage> createState() => _PengembalianPageState();
}

class _PengembalianPageState extends State<PengembalianPage> {
  @override
  void initState() {
    super.initState();
    pref();
    updatePengembalian();
  }

  //mengambil data login
  pref() async {
    final prefs = await SharedPreferences.getInstance();
    _iduser.text = prefs.getString("id_user")!;
  }

  bool _isLoading = false;
  int _index = 0;
  PeminjamanRepository peminjamanRepository = PeminjamanRepository();
  KendaraanRepository kendaraanRepository = KendaraanRepository();
  List<Peminjaman> peminjaman = [];

  // cari dlu kendaraan yang dipinjam lalu dicocokin sama nomor polisi yang di scan!
  // fungsion pengembalian
  updatePengembalian() async {
    var data = await peminjamanRepository.getData();
    setState(() {
      data.forEach((element) {
        if (element.id_kendaraan.toString() == widget.id_kendaraan &&
            element.id_user.toString() == _iduser.text) {
          peminjaman.add(element);
        }
      });
    });
  }

  //controller form
  final TextEditingController _iduser = TextEditingController();
  final TextEditingController _idpengembalian = TextEditingController();
  final TextEditingController _tanggalkembaliController =
      TextEditingController();
  final TextEditingController _jamkembaliController = TextEditingController();
  final TextEditingController _saldotolakhir = TextEditingController();
  final TextEditingController _kmakhir = TextEditingController();
  final TextEditingController _hargabbm = TextEditingController();

  String? uploadedImageTol;
  String? uploadedImageBBM;

  //convert jam ke detik
  int hoursToSeconds(String value) {
    List<String> timeParts = value.split(":");
    int hours = int.parse(timeParts[0]);
    int minutes = int.parse(timeParts[1]);
    Duration duration = Duration(hours: hours, minutes: minutes);
    int seconds = duration.inSeconds;
    return seconds;
  }

  //menghitung saldo tol akhir
  int totalSaldo() {
    int saldo = int.parse(widget.total_saldo_tol!);
    String saldoawal = peminjaman[0].saldo_tol_awal.toString();
    int saldoakhir =
        (int.parse(saldoawal) - int.parse(_saldotolakhir.text)).abs();
    int totalAkhir = saldoakhir + saldo;
    return totalAkhir;
  }

  //menghitung km akhir
  int totalKm() {
    int km = int.parse(widget.km!);
    String kmawal = peminjaman[0].km_awal.toString();
    int kmakhir = (int.parse(kmawal) - int.parse(_kmakhir.text)).abs();
    int totalAkhir = kmakhir + km;
    return totalAkhir;
  }

  //menghitung selisih km
  int selisihKm() {
    String kmawal = peminjaman[0].km_awal.toString();
    int selisihKM = (int.parse(kmawal) - int.parse(_kmakhir.text)).abs();
    return selisihKM;
  }

  //global key form
  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];
  List<Step> steps() => [
        Step(
            isActive: _index >= 0 ? true : false,
            title: const Text('Waktu Pengembalian'),
            content: Form(
              key: _formKeys[0],
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _tanggalkembaliController,
                    decoration: InputDecoration(
                        labelText: "Tanggal Kembali",
                        icon: Icon(Icons.calendar_month)),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _tanggalkembaliController.text =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                        });
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Masukan Tanggal Kembali!";
                      } else if (DateTime.parse(value).day <
                          DateTime.parse(peminjaman[0].tgl_peminjaman!).day) {
                        return "Tanggal kembali tidak boleh lebih awal dari tanggal peminjaman!";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Jam Kembali",
                        icon: Icon(Icons.punch_clock_outlined)),
                    controller: _jamkembaliController,
                    readOnly: true,
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                      );
                      if (pickedTime != null) {
                        setState(() {
                          _jamkembaliController.text =
                              pickedTime.format(context);
                        });
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Masukan Jam Kembali!";
                      } else if (DateTime.parse(_tanggalkembaliController.text)
                              .day ==
                          DateTime.parse(peminjaman[0].tgl_peminjaman!).day) {
                        if (hoursToSeconds(value) ==
                            hoursToSeconds(
                                peminjaman[0].jam_peminjaman!.toString())) {
                          return "Jam kembali tidak boleh sama dengan jam peminjaman!";
                        }
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _kmakhir,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      suffixText: "KM",
                      labelText: "KM Akhir",
                      icon: Icon(Icons.speed_rounded),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Masukan KM Akhir!";
                      } else if (int.parse(value) <=
                          int.parse(peminjaman[0].km_awal!)) {
                        return "KM Akhir tidak boleh lebih kecil dari KM Awal!";
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
            title: const Text('Total ongkos kendaraan'),
            content: Form(
              key: _formKeys[1],
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _saldotolakhir,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Saldo Tol Akhir",
                      prefixText: "Rp. ",
                      icon: Icon(Icons.money),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Masukan Saldo Tol Anda!";
                      } else if (int.parse(value) < 0) {
                        return "Saldo Tol tidak boleh kurang dari 0!";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _hargabbm,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixText: "Rp. ",
                      labelText: "Saldo bensin yang digunakan",
                      icon: Icon(Icons.attach_money_outlined),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Masukan Harga BBM Anda!";
                      } else if (int.parse(value) < 0) {
                        return "Harga BBM tidak boleh kurang dari 0!";
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              ),
            )),
        Step(
            isActive: _index >= 2 ? true : false,
            title: const Text('Upload Lampiran'),
            content: Form(
              key: _formKeys[2],
              child: Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(32.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: const Offset(0, 3)),
                      ],
                    ),
                    child: uploadedImageTol != null
                        ? Image.network(
                            '$kBASE_URL/assets/lampiran_tol/$uploadedImageTol',
                            fit: BoxFit.contain,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                              return Center(
                                  child: Text(
                                      'Bukti tidak ditemukan, silahkan upload ulang'));
                            },
                          )
                        : Center(
                            child: Text(
                                'Bukti Foto Lampiran Saldo Tol tidak ditemukan')),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FotoPage(
                                  id_peminjaman:
                                      peminjaman[0].id_peminjaman.toString(),
                                  category: 'lampiran_tol',
                                ),
                              ),
                            ).then((value) {
                              setState(() {
                                uploadedImageTol = value;
                              });
                            });
                          },
                          child: Text("Upload Foto Lampiran Saldo Tol"))),
                  SizedBox(
                    height: 32,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(32.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: const Offset(0, 3)),
                      ],
                    ),
                    child: uploadedImageBBM != null
                        ? Image.network(
                            '$kBASE_URL/assets/lampiran_bbm/$uploadedImageBBM',
                            fit: BoxFit.contain,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                              return Center(
                                  child: Text(
                                      'Bukti tidak ditemukan, silahkan upload ulang'));
                            },
                          )
                        : Center(
                            child: Text(
                                'Bukti Foto Lampiran Saldo BBM tidak ditemukan')),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FotoPage(
                                    id_peminjaman:
                                        peminjaman[0].id_peminjaman.toString(),
                                    category: 'lampiran_bbm'),
                              ),
                            ).then((value) {
                              setState(() {
                                uploadedImageBBM = value;
                              });
                            });
                          },
                          child: Text("Upload Foto Lampiran Saldo BBM"))),
                  SizedBox(
                    height: 8,
                  ),
                  (uploadedImageBBM != null && uploadedImageTol != null)
                      ? Container(
                          margin: EdgeInsets.only(top: 10),
                          child: ElevatedButton(
                            onPressed: () async {
                              if (uploadedImageBBM != null &&
                                  uploadedImageTol != null) {
                                setState(() {
                                  _isLoading = true;
                                });
                                bool response = await peminjamanRepository
                                    .putPeminjamanData(
                                        _idpengembalian.text = peminjaman[0]
                                            .id_peminjaman
                                            .toString(),
                                        _tanggalkembaliController.text,
                                        _jamkembaliController.text,
                                        _kmakhir.text,
                                        _saldotolakhir.text,
                                        _hargabbm.text,
                                        uploadedImageTol!,
                                        uploadedImageBBM!,
                                        selisihKm().toString());

                                bool responseUpdate = await kendaraanRepository
                                    .updateStatusKendaraanKembali(
                                  widget.id_kendaraan.toString(),
                                  0,
                                  totalKm().toString(),
                                  totalSaldo().toString(),
                                );
                                if (response == true &&
                                    responseUpdate == true) {
                                  CoolAlert.show(
                                    context: context,
                                    type: CoolAlertType.success,
                                    text: "Pengembalian Anda Berhasil!",
                                    confirmBtnText: "Selesai",
                                    onConfirmBtnTap: (() {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()),
                                      );
                                    }),
                                  );
                                } else {
                                  CoolAlert.show(
                                    context: context,
                                    type: CoolAlertType.error,
                                    text: "Pengembalian Anda gagal :(",
                                    confirmBtnText: "Kembali",
                                  );
                                }
                              }
                            },
                            child: _isLoading
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('Loading...'),
                                    ],
                                  )
                                : Text('Submit'),
                          ))
                      : Container()
                ],
              ),
            )),
      ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pengisian Form Pengembalian'),
        ),
        body: Stepper(
            controlsBuilder: (context, _) {
              return Row(
                children: <Widget>[
                  _index != 0
                      ? TextButton(
                          onPressed: onStepCancel,
                          child: const Text('Sebelumnya'),
                        )
                      : Container(),
                  _index != 2
                      ? TextButton(
                          onPressed: onStepContinue,
                          child: const Text('Selanjutnya'),
                        )
                      : Container(),
                ],
              );
            },
            currentStep: _index,
            steps: steps()));
  }

  //step continue stepper form
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

  //step cancel stepper form
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

//

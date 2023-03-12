import 'package:flutter/material.dart';
import 'package:DESARMADA/core/repository.dart';
import 'package:DESARMADA/model/MainKendaraanModel.dart';
import 'package:DESARMADA/screen/detailpeminjaman.dart';

import '../constants.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _allpressed = true;
  bool _mobilpressed = false;
  bool _motorpressed = false;
  List<MainKendaraan> mainKendaraan = [];
  MainKendaraanRepository repository = MainKendaraanRepository();

  //Mengambil data dari main kendaraan
  getData() async {
    var data = await repository.getData();
    setState(() {
      data.forEach((element) {
        if (element.pinjam.toString() == "0") {
          mainKendaraan.add(element);
        }
      });
    });
  }

  //Mengambil data mobil
  getMobilData() async {
    var data = await repository.getData();
    setState(() {
      data.forEach((element) {
        if (element.pinjam.toString() == "0" &&
            element.jenis_kendaraan == "mobil") {
          mainKendaraan.add(element);
        }
      });
    });
  }

  //Mengambil data motor
  getMotorData() async {
    var data = await repository.getData();
    setState(() {
      data.forEach((element) {
        if (element.pinjam.toString() == "0" &&
            element.jenis_kendaraan == "motor") {
          mainKendaraan.add(element);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Peminjaman Kendaraan')),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
                onChanged: (value) {
                  if (value.isEmpty) {
                    setState(() {
                      mainKendaraan.clear();
                      getData();
                    });
                  } else {
                    setState(() {
                      mainKendaraan = mainKendaraan
                          .where((element) => element.tipe_kendaraan!
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                    });
                  }
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),
                  suffixIcon: Icon(Icons.search),
                  labelText: 'Cari Kendaraan',
                )),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _mobilpressed = false;
                          _motorpressed = false;
                          _allpressed = true;
                          mainKendaraan.clear();
                          getData();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              _allpressed ? Colors.blue : Colors.grey[200],
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      child: const Text("Semua"),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _allpressed = false;
                          _motorpressed = false;
                          _mobilpressed = true;
                          mainKendaraan.clear();
                          getMobilData();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              _mobilpressed ? Colors.blue : Colors.grey[200],
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      child: const Text("Mobil"),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _allpressed = false;
                          _mobilpressed = false;
                          _motorpressed = true;
                          mainKendaraan.clear();
                          getMotorData();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              _motorpressed ? Colors.blue : Colors.grey[200],
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      child: const Text("Motor"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 200.0,
              child: Container(
                margin: EdgeInsets.only(top: 10),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailKendaraanPage(
                              id_kendaraan: mainKendaraan[index].id_kendaraan,
                              tipe_kendaraan:
                                  mainKendaraan[index].tipe_kendaraan,
                              nomor_polisi: mainKendaraan[index].nomor_polisi,
                              nama_departemen:
                                  mainKendaraan[index].nama_departemen,
                              jenis_kendaraan:
                                  mainKendaraan[index].jenis_kendaraan,
                              km: mainKendaraan[index].km,
                              gambar: mainKendaraan[index].gambar,
                            ),
                          ),
                        );
                      },
                      leading:
                          // Image(image: AssetImage("assets/images/logo.png"))
                          Image.network(
                              '$kBASE_URL/assets/img_kendaraan/${mainKendaraan[index].gambar}',
                              fit: BoxFit.contain,
                              width: 80,
                              height: 70),
                      title: Text((mainKendaraan != null)
                          ? mainKendaraan[index].tipe_kendaraan.toString()
                          : "Loading..."),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text((mainKendaraan != null)
                              ? "Lokasi : ${mainKendaraan[index].nama_departemen}"
                              : "Loading..."),
                          Text((mainKendaraan != null)
                              ? "Jenis : ${mainKendaraan[index].jenis_kendaraan}"
                              : "Loading..."),
                        ],
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text((mainKendaraan != null)
                              ? "No.Polisi : ${mainKendaraan[index].nomor_polisi}"
                              : "Loading..."),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(height: 10);
                  },
                  itemCount: mainKendaraan.length,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

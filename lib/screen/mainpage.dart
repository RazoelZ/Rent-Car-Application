import 'package:flutter/material.dart';
import 'package:rentvehicle_application/core/repository.dart';
import 'package:rentvehicle_application/model/MainKendaraanModel.dart';
import 'package:rentvehicle_application/screen/detailpeminjaman.dart';

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
                      child: const Text("Semua"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              _allpressed ? Colors.blue : Colors.grey[200],
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
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
                      child: const Text("Mobil"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              _mobilpressed ? Colors.blue : Colors.grey[200],
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
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
                          _mobilpressed = false;
                          _motorpressed = true;
                          mainKendaraan.clear();
                          getMotorData();
                        });
                      },
                      child: const Text("Motor"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              _motorpressed ? Colors.blue : Colors.grey[200],
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
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
                          Image(image: AssetImage("assets/images/logo.png")),
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
                              ? "Plat : ${mainKendaraan[index].nomor_polisi}"
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

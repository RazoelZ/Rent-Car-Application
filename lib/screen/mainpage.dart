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
  List<MainKendaraan> mainKendaraan = [];
  MainKendaraanRepository repository = MainKendaraanRepository();

  getData() async {
    var data = await repository.getData();
    setState(() {
      mainKendaraan = data;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
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
          // Container(
          //   margin: EdgeInsets.only(top: 10),
          //   child: Row(
          //     children: [
          //       Container(
          //         margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
          //         child: ElevatedButton(
          //           onPressed: () {},
          //           child: const Text('Mobil'),
          //         ),
          //       ),

          //       Container(
          //         child: ElevatedButton(
          //           onPressed: () {

          //           },
          //           child: const Text('Motor'),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
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
                              ? "Lokasi : " +
                                  mainKendaraan[index]
                                      .nama_departemen
                                      .toString()
                              : "Loading..."),
                          Text((mainKendaraan != null)
                              ? "Jenis_kendaraan : " +
                                  mainKendaraan[index]
                                      .jenis_kendaraan
                                      .toString()
                              : "Loading..."),
                        ],
                      ),
                      trailing: Text((mainKendaraan != null)
                          ? "Plat nomor : " +
                              mainKendaraan[index].nomor_polisi.toString()
                          : "Loading..."),
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

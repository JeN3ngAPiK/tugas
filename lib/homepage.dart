import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tugas1/edit.dart';
import 'package:tugas1/tambahdata.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _listdata = [];
  bool _isloading = true;
  Future _getdata() async {
    try {
      final respone =
          await http.get(Uri.parse('http://localhost/mobile/db.php'));
      if (respone.statusCode == 200) {
        //print(respone.body);
        final data = jsonDecode(respone.body);
        setState(() {
          _listdata = data;
          _isloading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future _hapus(String id) async {
    try {
      final respone = await http
          .post(Uri.parse('http://localhost/mobile/hapus.php'), body: {
        "id": id,
      });
      if (respone.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _getdata();
    //print(_listdata);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("home")),
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _listdata.length,
              itemBuilder: ((context, index) {
                return Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => EditPage(
                                ListData: {
                                  "id": _listdata[index]['id'],
                                  "nama_ikan": _listdata[index]['nama_ikan'],
                                  "jenis": _listdata[index]['jenis'],
                                  "tempat_hidup": _listdata[index]
                                      ['tempat_hidup'],
                                },
                              )),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text(_listdata[index]['nama_ikan']),
                      subtitle: Text(_listdata[index]['jenis']),
                      trailing: IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: ((context) {
                                  return AlertDialog(
                                    content:
                                        Text("yakin atau tidak mengubah data"),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: (() {
                                            _hapus(_listdata[index]['id'])
                                                .then((value) {
                                              if (value) {
                                                final snackBar = SnackBar(
                                                  content: const Text(
                                                      'Data berhasil dihapus'),
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                              } else {
                                                final snackBar = SnackBar(
                                                  content: const Text(
                                                      'Data gagal dihapus'),
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                              }
                                            });
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (((context) =>
                                                        HomePage()))),
                                                (route) => false);
                                          }),
                                          child: Text("hapus")),
                                      ElevatedButton(
                                          onPressed: (() {
                                            Navigator.of(context).pop();
                                          }),
                                          child: Text("batal"))
                                    ],
                                  );
                                }));
                          },
                          icon: Icon(Icons.delete)),
                    ),
                  ),
                );
              }),
            ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (() {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => TambahDataPage())));
          })),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tugas1/homepage.dart';

class EditPage extends StatefulWidget {
  final Map ListData;
  const EditPage({super.key, required this.ListData});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final formkey = GlobalKey<FormState>();
  TextEditingController id = TextEditingController();
  TextEditingController nama_ikan = TextEditingController();
  TextEditingController jenis = TextEditingController();
  TextEditingController tempat_hidup = TextEditingController();
  Future _update() async {
    final respone =
        await http.post(Uri.parse('http://localhost/mobile/edit.php'), body: {
      "id": id.text,
      "nama_ikan": nama_ikan.text,
      "jenis": jenis.text,
      "tempat_hidup": tempat_hidup.text,
    });
    if (respone.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    id.text = widget.ListData['id'];
    nama_ikan.text = widget.ListData['nama_ikan'];
    jenis.text = widget.ListData['jenis'];
    tempat_hidup.text = widget.ListData['tempat_hidup'];
    return Scaffold(
      appBar: AppBar(
        title: Text("edit"),
      ),
      body: Form(
          key: formkey,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(children: [
              //nama ikan
              TextFormField(
                controller: nama_ikan,
                decoration: InputDecoration(
                  hintText: "nama ikan",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "nama ikan tidak boleh kosong";
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              //jenis ikan
              TextFormField(
                  controller: jenis,
                  decoration: InputDecoration(
                    hintText: "jenis ikan",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "jenis ikan tidak boleh kosong";
                    }
                  }),
              SizedBox(
                height: 10,
              ),
              //tempat hidup
              TextFormField(
                  controller: tempat_hidup,
                  decoration: InputDecoration(
                    hintText: "tempat hidup",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "tempat hidup tidak boleh kosong";
                    }
                  }),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: (() {
                    if (formkey.currentState!.validate()) {
                      _update().then((value) {
                        if (value) {
                          final snackBar = SnackBar(
                            content: const Text('berhasil update'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          final snackBar = SnackBar(
                            content: const Text('gagal update'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      });
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (((context) => HomePage()))),
                          (route) => false);
                    }
                  }),
                  child: Text("update"))
            ]),
          )),
    );
  }
}

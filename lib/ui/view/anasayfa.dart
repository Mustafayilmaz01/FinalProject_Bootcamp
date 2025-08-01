import 'package:flutter/material.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  var tf = TextEditingController();
  bool aramaVarMi = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: TextField(
            controller: tf,
            decoration: InputDecoration(
              prefixIcon: IconButton(
                onPressed: () {},
                icon: Icon(Icons.home, color: Colors.deepPurple),
              ),
              suffixIcon: Icon(Icons.search),
              label: Text("Kayıtlı Adres"),
            ),
          ),
        ),
      ),
      body: Center(child: Column(children: [Image.asset("resimler/indirim.png")])),
    );
  }
}

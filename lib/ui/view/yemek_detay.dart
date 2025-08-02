import 'package:flutter/material.dart';
import 'package:bitirme_projesi/data/entity/yemekler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bitirme_projesi/ui/cubit/anasayfa_cubit.dart';

class YemekDetay extends StatefulWidget {
  final Yemekler yemek;

  const YemekDetay({super.key, required this.yemek});

  @override
  State<YemekDetay> createState() => _YemekDetayState();
}

class _YemekDetayState extends State<YemekDetay> {
  int adet = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.yemek.yemek_adi)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${widget.yemek.yemek_resim_adi}", height: 200),
            const SizedBox(height: 20),
            Text("${widget.yemek.yemek_fiyat} ₺", style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    if (adet > 1) {
                      setState(() {
                        adet--;
                      });
                    }
                  },
                  icon: const Icon(Icons.remove),
                ),
                Text(adet.toString(), style: const TextStyle(fontSize: 20)),
                IconButton(
                  onPressed: () {
                    setState(() {
                      adet++;
                    });
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                context.read<AnasayfaCubit>().sepeteEkle(widget.yemek, adet);

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("${widget.yemek.yemek_adi} sepete eklendi")));

                Navigator.pop(context);
              },
              child: Text("Sepete Ekle"),
            ),
          ],
        ),
      ),
    );
  }
}

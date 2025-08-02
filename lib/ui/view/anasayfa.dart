import 'package:bitirme_projesi/data/entity/yemekler.dart';
import 'package:bitirme_projesi/ui/cubit/anasayfa_cubit.dart';
import 'package:bitirme_projesi/ui/cubit/sepet_cubit.dart';
import 'package:bitirme_projesi/ui/view/sepet.dart';
import 'package:bitirme_projesi/ui/view/yemek_detay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  var tf = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.deepOrangeAccent,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.home_filled)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const Sepet()));
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.shopping_basket),
      ),
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: TextField(
            controller: tf,
            decoration: const InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(Icons.home, color: Colors.deepPurple),
              suffixIcon: Icon(Icons.search),
              label: Text("Kayıtlı Adres"),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Image.asset("resimler/indirim.png"), // kampanya görseli
          Expanded(
            child: BlocBuilder<AnasayfaCubit, List<Yemekler>>(
              builder: (context, yemekListesi) {
                if (yemekListesi.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView.builder(
                  itemCount: yemekListesi.length,
                  itemBuilder: (context, index) {
                    var yemek = yemekListesi[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: ListTile(
                        leading: Image.network(
                          "http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}",
                          width: 60,
                          height: 60,
                        ),
                        title: Text(yemek.yemek_adi),
                        subtitle: Text("${yemek.yemek_fiyat} ₺"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.add_shopping_cart, color: Colors.deepPurple),
                              onPressed: () {
                                // sepete ekle
                                context.read<AnasayfaCubit>().sepeteEkle(yemek, 1);
                                // Snackbar
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(SnackBar(content: Text("${yemek.yemek_adi} sepete eklendi")));
                                // sepeti güncelle
                                context.read<SepetCubit>().sepettekiYemekleriYukle();
                              },
                            ),
                            const Icon(Icons.arrow_forward_ios, size: 16),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => YemekDetay(yemek: yemek)));
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

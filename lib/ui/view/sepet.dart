import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bitirme_projesi/ui/cubit/sepet_cubit.dart';
import 'package:bitirme_projesi/data/entity/sepet_yemekler.dart';

class Sepet extends StatelessWidget {
  const Sepet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sepetim")),
      body: BlocBuilder<SepetCubit, List<SepetYemekler>>(
        builder: (context, sepetListesi) {
          if (sepetListesi.isEmpty) {
            return const Center(child: Text("Sepet boş"));
          }

          int toplam = 0;
          for (var item in sepetListesi) {
            toplam += int.parse(item.yemek_fiyat) * int.parse(item.yemek_siparis_adet);
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: sepetListesi.length,
                  itemBuilder: (context, index) {
                    var yemek = sepetListesi[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      child: ListTile(
                        leading: Image.network(
                          "http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}",
                          width: 60,
                          height: 60,
                        ),
                        title: Text(yemek.yemek_adi),
                        subtitle: Text("${yemek.yemek_fiyat} ₺ x ${yemek.yemek_siparis_adet}"),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            context.read<SepetCubit>().sepettenSil(yemek.sepet_yemek_id);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text("Toplam: $toplam ₺", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ),
            ],
          );
        },
      ),
    );
  }
}

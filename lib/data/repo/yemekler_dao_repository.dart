import 'dart:convert';

import 'package:dio/dio.dart';
import '../entity/yemekler.dart';
import '../entity/sepet_yemekler.dart';

class YemeklerDaoRepository {
  var dio = Dio();

  Future<List<Yemekler>> tumYemekleriGetir() async {
    var url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var response = await dio.get(url);

    List<Yemekler> yemekListesi = [];

    try {
      var jsonCevap = response.data is String ? jsonDecode(response.data) : response.data;
      var yemekler = jsonCevap["yemekler"];

      if (yemekler != null) {
        for (var item in yemekler) {
          yemekListesi.add(Yemekler.fromJson(item));
        }
      }
    } catch (e) {
      print(" Hata oluştu: $e");
    }

    return yemekListesi;
  }

  Future<void> sepeteYemekEkle(
    String yemek_adi,
    String yemek_resim_adi,
    int yemek_fiyat,
    int yemek_siparis_adet,
    String kullanici_adi,
  ) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";

    var veri = {
      "yemek_adi": yemek_adi,
      "yemek_resim_adi": yemek_resim_adi,
      "yemek_fiyat": yemek_fiyat,
      "yemek_siparis_adet": yemek_siparis_adet,
      "kullanici_adi": kullanici_adi,
    };

    await dio.post(url, data: FormData.fromMap(veri));
  }

  Future<List<SepetYemekler>> sepettekiYemekleriGetir(String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    var veri = {"kullanici_adi": kullanici_adi};

    var response = await dio.post(url, data: FormData.fromMap(veri));

    List<SepetYemekler> sepetListesi = [];

    try {
      var jsonCevap = response.data is String ? jsonDecode(response.data) : response.data;
      print("📦 Sepet JSON: $jsonCevap");

      if (jsonCevap["sepet_yemekler"] != null) {
        var liste = jsonCevap["sepet_yemekler"];
        for (var item in liste) {
          sepetListesi.add(SepetYemekler.fromJson(item));
        }
      } else {
        print("🚫 Sepet boş");
      }
    } catch (e) {
      print(" Sepeti çekerken hata: $e");
    }

    return sepetListesi;
  }

  Future<void> sepettenYemekSil(String sepet_yemek_id, String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    var veri = {"sepet_yemek_id": sepet_yemek_id, "kullanici_adi": kullanici_adi};

    await dio.post(url, data: FormData.fromMap(veri));
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bitirme_projesi/data/entity/yemekler.dart';
import 'package:bitirme_projesi/data/repo/yemekler_dao_repository.dart';

class AnasayfaCubit extends Cubit<List<Yemekler>> {
  AnasayfaCubit() : super(<Yemekler>[]);

  var yemekRepo = YemeklerDaoRepository();

  void yemekleriYukle() async {
    var liste = await yemekRepo.tumYemekleriGetir();
    emit(liste);
  }

  void sepeteEkle(Yemekler yemek, int adet) async {
    await yemekRepo.sepeteYemekEkle(
      yemek.yemek_adi,
      yemek.yemek_resim_adi,
      int.tryParse(yemek.yemek_fiyat) ?? 0,
      adet,
      "mustafa01",
    );
  }
}

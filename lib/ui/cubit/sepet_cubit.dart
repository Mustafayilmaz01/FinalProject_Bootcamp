import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bitirme_projesi/data/entity/sepet_yemekler.dart';
import 'package:bitirme_projesi/data/repo/yemekler_dao_repository.dart';

class SepetCubit extends Cubit<List<SepetYemekler>> {
  SepetCubit() : super(<SepetYemekler>[]);

  var yemekRepo = YemeklerDaoRepository();

  void sepettekiYemekleriYukle() async {
    var liste = await yemekRepo.sepettekiYemekleriGetir("mustafa01");
    emit(liste);
  }

  void sepettenSil(String sepet_yemek_id) async {
    await yemekRepo.sepettenYemekSil(sepet_yemek_id, "mustafa01");
    sepettekiYemekleriYukle(); // tekrar yükle
  }
}

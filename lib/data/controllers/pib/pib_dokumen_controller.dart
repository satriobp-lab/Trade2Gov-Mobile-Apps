import '../../repositories/pib/pib_dokumen_repository.dart';
import '../../models/pib/pib_dokumen_response_model.dart';

class PibDokumenController {
  static final PibDokumenRepository _repo =
  PibDokumenRepository();

  static Future<List<PibDokumenResponseModel>> getDokumen(String car) async {
    return await _repo.fetchDokumen(car);
  }
}

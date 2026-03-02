import '../../repositories/pibk/pibk_dokumen_repository.dart';
import '../../models/pibk/pibk_dokumen_response_model.dart';

class PibkDokumenController {
  static final PibkDokumenRepository _repo =
  PibkDokumenRepository();

  static Future<List<PibkDokumenResponseModel>> getPibkDokumen(String car) async {
    return await _repo.fetchPibkDokumen(car);
  }
}
import '../../repositories/peb/peb_dokumen_repository.dart';
import '../../models/peb/peb_dokumen_response_model.dart';

class PebDokumenController {
  static final PebDokumenRepository _repo = PebDokumenRepository();

  static Future<List<PebDokumenResponseModel>> getPebDokumen(String car) async {
    final data = await _repo.fetchPebDokumen(car);
    return data;
  }
}
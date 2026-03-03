import '../../repositories/pibk/pibk_databarang_repository.dart';
import '../../models/pibk/pibk_databarang_response_model.dart';

class PibkDataBarangController {
  static final PibkDataBarangRepository _repo =
  PibkDataBarangRepository();

  static Future<PibkDataBarangResponseModel?> getDataBarangDetail({
    required String car,
    required int serial,
  }) async {
    return await _repo.fetchDataBarangDetail(
      car: car,
      serial: serial,
    );
  }
}
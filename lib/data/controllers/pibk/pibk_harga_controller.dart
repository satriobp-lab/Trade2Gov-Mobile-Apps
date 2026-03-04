import '../../repositories/pibk/pibk_harga_repository.dart';
import '../../models/pibk/pibk_harga_response_model.dart';

class PibkHargaController {
  static final PibkHargaRepository _repo = PibkHargaRepository();

  static Future<PibkHargaResponseModel?> getPibkHarga(String car) async {
    return await _repo.fetchPibkHarga(car);
  }
}
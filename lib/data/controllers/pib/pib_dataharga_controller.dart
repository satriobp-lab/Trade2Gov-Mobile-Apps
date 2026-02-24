import '../../models/pib/pib_dataharga_response_model.dart';
import '../../repositories/pib/pib_dataharga_repository.dart';

class PibDataHargaController {
  static final PibDataHargaRepository _repository =
  PibDataHargaRepository();

  static Future<PibDataHargaResponseModel> getDataHarga(
      String car) async {
    return await _repository.fetchDataHarga(car);
  }
}
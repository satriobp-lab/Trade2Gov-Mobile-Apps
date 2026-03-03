import '../../repositories/pibk/pibk_listdatabarang_repository.dart';
import '../../models/pibk/pibk_listdatabarang_response_model.dart';

class PibkListDataBarangController {
  static final PibkListDataBarangRepository _repo =
  PibkListDataBarangRepository();

  static Future<List<PibkListDataBarangResponseModel>> getListDataBarang(String car) async {
    return await _repo.fetchListDataBarang(car);
  }
}
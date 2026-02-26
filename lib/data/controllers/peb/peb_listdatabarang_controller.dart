import '../../repositories/peb/peb_listdatabarang_repository.dart';
import '../../models/peb/peb_listdatabarang_response_model.dart';

class PebListDataBarangController {
  static final PebListDataBarangRepository _repo =
  PebListDataBarangRepository();

  static Future<List<PebListDataBarangResponseModel>> getListDataBarang({
    required String car,
  }) async {
    return await _repo.fetchListDataBarang(car: car);
  }
}
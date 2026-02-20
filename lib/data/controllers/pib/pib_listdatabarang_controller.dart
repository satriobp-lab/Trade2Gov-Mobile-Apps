import '../../repositories/pib/pib_listdatabarang_repository.dart';
import '../../models/pib/pib_listdatabarang_response_model.dart';

class PibListDataBarangController {
  static final PibListDataBarangRepository _repo =
  PibListDataBarangRepository();

  static Future<List<PibListDataBarangResponseModel>> getListDataBarang(
      String car) async {
    return await _repo.fetchListDataBarang(car);
  }
}
import '../../repositories/peb/peb_transaksiekspor_repository.dart';
import '../../models/peb/peb_transaksiekspor_response_model.dart';

class PebTransaksiEksporController {
  static final PebTransaksiEksporRepository _repo =
  PebTransaksiEksporRepository();

  static Future<PebTransaksiEksporResponseModel?> getTransaksiEkspor({
    required String car,
  }) async {
    return await _repo.fetchTransaksiEkspor(car: car);
  }
}
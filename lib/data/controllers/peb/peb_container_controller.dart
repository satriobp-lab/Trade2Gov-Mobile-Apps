import '../../repositories/peb/peb_container_repository.dart';
import '../../models/peb/peb_container_response_model.dart';

class PebContainerController {
  static final PebContainerRepository _repo =
  PebContainerRepository();

  static Future<List<PebContainerResponseModel>> getContainers({
    required String car,
  }) async {
    return await _repo.fetchContainers(car: car);
  }
}
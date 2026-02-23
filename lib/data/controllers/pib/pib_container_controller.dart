import '../../repositories/pib/pib_container_repository.dart';
import '../../models/pib/pib_container_response_model.dart';

class PibContainerController {
  static final PibContainerRepository _repo =
  PibContainerRepository();

  static Future<List<PibContainerResponseModel>> getContainers(
      String car) async {
    return await _repo.fetchContainers(car);
  }
}
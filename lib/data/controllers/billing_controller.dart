import '../repositories/billing_repository.dart';
import '../models/billing_response_model.dart';

class BillingController {
  static final BillingRepository _repo = BillingRepository();

  static Future<List<BillingResponseModel>> fetchBilling() async {
    return await _repo.getBilling();
  }
}

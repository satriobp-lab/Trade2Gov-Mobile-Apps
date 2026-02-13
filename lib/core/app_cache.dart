import '../data/models/billing_response_model.dart';
import '../data/models/mailbox_response_model.dart';
import '../data/models/profile_response_model.dart';
import '../data/models/edec_response_model.dart';

class AppCache {
  static List<BillingResponseModel> billingList = [];
  static List<MailboxResponseModel> mailboxList = [];
  static ProfileResponseModel? profile;
  static EdecResponseModel? edecDashboard;

  static bool welcomeShown = false; // 👈 TAMBAHKAN INI
}
import '../repositories/mailbox_repository.dart';
import '../models/mailbox_response_model.dart';

class MailboxController {
  static final MailboxRepository _repo = MailboxRepository();

  static Future<List<MailboxResponseModel>> fetchMailbox() async {
    return await _repo.getMailbox();
  }
}

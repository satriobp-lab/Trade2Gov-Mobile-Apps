import '../../services/api_service.dart';
import '../../securestorage/secure_storage_service.dart';
import '../../models/peb/peb_header_response_model.dart';

class PebHeaderRepository {
  final ApiService _api = ApiService();
  final SecureStorageService _storage = SecureStorageService();

  // KHUSUS IMPLEMENTASI SESUAI USER LOGIN (JANGAN DIHAPUS - NANTI DIPAKAI)
  /*
  Future<PebHeaderResponseModel?> fetchPebHeader(String car) async {

    final userId = await _storage.getUserId();

    final response = await _api.postRaw(
      'edeclaration/bc30/header/header',
      {
        "USER_ID": userId,
        "CAR": car,
      },
    );

    if (response == null) return null;

          if (response is Map<String, dynamic>) {
  final header = response['HEADER'];

     if (header is Map<String, dynamic>) {

        final model = PebHeaderResponseModel.fromJson(header);

        final jneksMap = response['JNEKS'] as Map<String, dynamic>?;
        final kateksMap = response['KATEKS'] as Map<String, dynamic>?;
        final jndagMap = response['JNDAG'] as Map<String, dynamic>?;
        final jnbyrMap = response['JNBYR'] as Map<String, dynamic>?;
        final statusMap = response['STATUSH'] as Map<String, dynamic>?;
        final modaMap = response['MODA'] as Map<String, dynamic>?;
        final kmdtMap = response['KMDT'] as Map<String, dynamic>?;

        String? getDescription(
            String? code,
            Map<String, dynamic>? map,
        ) {
          if (code == null || map == null) return null;

          final fullValue = map[code];
          if (fullValue == null) return null;

          // buang angka depan "1 - "
          return fullValue.toString().replaceFirst(
            RegExp(r'^\d+\s*-\s*'),
            '',
          );
        }

        return PebHeaderResponseModel(
          // semua field lama
          car: model.car,
          kdKtr: model.kdKtr,
          urKdKtr: model.urKdKtr,
          kdKtrEks: model.kdKtrEks,
          urKdKtrEks: model.urKdKtrEks,
          noDaft: model.noDaft,
          tgDaft: model.tgDaft,
          jneks: model.jneks,
          kateks: model.kateks,
          jndag: model.jndag,
          jnbyr: model.jnbyr,
          urJneks: getDescription(model.jneks, jneksMap),
          urKateks: getDescription(model.kateks, kateksMap),
          urJndag: getDescription(model.jndag, jndagMap),
          urJnbyr: getDescription(model.jnbyr, jnbyrMap),
          urStatusH: getDescription(model.statusH, statusMap),
          urModa: getDescription(model.moda, modaMap),
          urKmdt: getDescription(model.kmdt, kmdtMap),
          npwpEks: model.npwpEks,
          namaEks: model.namaEks,
          alamatEks: model.alamatEks,
          statusH: model.statusH,
          niper: model.niper,
          namaBeli: model.namaBeli,
          alamatBeli: model.alamatBeli,
          negBeli: model.negBeli,
          urNegBeli: model.urNegBeli,
          namaBeli2: model.namaBeli2,
          alamatBeli2: model.alamatBeli2,
          negBeli2: model.negBeli2,
          urNegBeli2: model.urNegBeli2,
          npwpPpjk: model.npwpPpjk,
          namaPpjk: model.namaPpjk,
          alamatPpjk: model.alamatPpjk,
          moda: model.moda,
          tgEks: model.tgEks,
          carrier: model.carrier,
          voy: model.voy,
          bendera: model.bendera,
          urBendera: model.urBendera,
          pelMuat: model.pelMuat,
          urPelMuat: model.urPelMuat,
          pelMuatEks: model.pelMuatEks,
          urPelMuatEks: model.urPelMuatEks,
          pelBongkar: model.pelBongkar,
          urPelBongkar: model.urPelBongkar,
          pelTujuan: model.pelTujuan,
          urPelTujuan: model.urPelTujuan,
          negTuju: model.negTuju,
          urNegTuju: model.urNegTuju,
          kdLokBrg: model.kdLokBrg,
          kdKtrPriks: model.kdKtrPriks,
          urKdKtrPriks: model.urKdKtrPriks,
          gudangPlb: model.gudangPlb,
          delivery: model.delivery,
          kmdt: model.kmdt,
          volume: model.volume,
          bruto: model.bruto,
          netto: model.netto,
          jumlahBarang: model.jumlahBarang,
          nilKurs: model.nilKurs,
          nilPe: model.nilPe,
          nilPajakLain: model.nilPajakLain,
        );
      }
    }

    return null;
  }
  */

  // FORCE USER 175
  Future<PebHeaderResponseModel?> fetchPebHeader(String car) async {

    // final userId = await _storage.getUserId();
    final userId = "175"; // paksa 175

    final response = await _api.postRaw(
      'edeclaration/bc30/header/header',
      {
        "USER_ID": userId,
        "CAR": car,
      },
    );

    if (response == null) {
      return null;
    }

    if (response is Map<String, dynamic>) {
      final header = response['HEADER'];

      if (header is Map<String, dynamic>) {

        final model = PebHeaderResponseModel.fromJson(header);

        // ambil mapping dari root response
        final jneksMap = response['JNEKS'] as Map<String, dynamic>?;
        final kateksMap = response['KATEKS'] as Map<String, dynamic>?;
        final jndagMap = response['JNDAG'] as Map<String, dynamic>?;
        final jnbyrMap = response['JNBYR'] as Map<String, dynamic>?;

        final statusMap = response['STATUSH'] as Map<String, dynamic>?;
        final modaMap = response['MODA'] as Map<String, dynamic>?;
        final kmdtMap = response['KMDT'] as Map<String, dynamic>?;

        String? getDescription(
            String? code,
            Map<String, dynamic>? map,
            ) {
          if (code == null || map == null) return null;

          final fullValue = map[code];
          if (fullValue == null) return null;

          return fullValue.toString().replaceFirst(
            RegExp(r'^\d+\s*-\s*'),
            '',
          );
        }

        return PebHeaderResponseModel(
          car: model.car,
          kdKtr: model.kdKtr,
          urKdKtr: model.urKdKtr,
          kdKtrEks: model.kdKtrEks,
          urKdKtrEks: model.urKdKtrEks,
          noDaft: model.noDaft,
          tgDaft: model.tgDaft,
          jneks: model.jneks,
          kateks: model.kateks,
          jndag: model.jndag,
          jnbyr: model.jnbyr,
          urJneks: getDescription(model.jneks, jneksMap),
          urKateks: getDescription(model.kateks, kateksMap),
          urJndag: getDescription(model.jndag, jndagMap),
          urJnbyr: getDescription(model.jnbyr, jnbyrMap),
          urStatusH: getDescription(model.statusH, statusMap),
          urModa: getDescription(model.moda, modaMap),
          urKmdt: getDescription(model.kmdt, kmdtMap),
          npwpEks: model.npwpEks,
          namaEks: model.namaEks,
          alamatEks: model.alamatEks,
          statusH: model.statusH,
          niper: model.niper,
          namaBeli: model.namaBeli,
          alamatBeli: model.alamatBeli,
          negBeli: model.negBeli,
          urNegBeli: model.urNegBeli,
          namaBeli2: model.namaBeli2,
          alamatBeli2: model.alamatBeli2,
          negBeli2: model.negBeli2,
          urNegBeli2: model.urNegBeli2,
          npwpPpjk: model.npwpPpjk,
          namaPpjk: model.namaPpjk,
          alamatPpjk: model.alamatPpjk,
          moda: model.moda,
          tgEks: model.tgEks,
          carrier: model.carrier,
          voy: model.voy,
          bendera: model.bendera,
          urBendera: model.urBendera,
          pelMuat: model.pelMuat,
          urPelMuat: model.urPelMuat,
          pelMuatEks: model.pelMuatEks,
          urPelMuatEks: model.urPelMuatEks,
          pelBongkar: model.pelBongkar,
          urPelBongkar: model.urPelBongkar,
          pelTujuan: model.pelTujuan,
          urPelTujuan: model.urPelTujuan,
          negTuju: model.negTuju,
          urNegTuju: model.urNegTuju,
          kdLokBrg: model.kdLokBrg,
          kdKtrPriks: model.kdKtrPriks,
          urKdKtrPriks: model.urKdKtrPriks,
          gudangPlb: model.gudangPlb,
          delivery: model.delivery,
          kmdt: model.kmdt,
          volume: model.volume,
          bruto: model.bruto,
          netto: model.netto,
          jumlahBarang: model.jumlahBarang,
          nilKurs: model.nilKurs,
          nilPe: model.nilPe,
          nilPajakLain: model.nilPajakLain,
        );
      }
    }

    return null;
  }
}
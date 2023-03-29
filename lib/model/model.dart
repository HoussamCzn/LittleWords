import 'package:cv/cv.dart';
import 'package:tekartik_notepad_sqflite_app/db/db.dart';
import 'package:tekartik_notepad_sqflite_app/model/model_constant.dart';

class DbNote extends DbRecord {
  final noteLastName = CvField<String>(lastName);
  final noteFirstName = CvField<String>(firstName);
  final noteDate = CvField<int>(date);
  final notePhone = CvField<String>(phone);
  final noteAddress = CvField<String>(address);
  final noteLatitude = CvField<double>(latitude);
  final noteLongitude = CvField<double>(longitude);

  @override
  List<CvField> get fields =>
      [id, noteLastName, noteFirstName, noteDate, notePhone, noteAddress, noteLatitude, noteLongitude];
}

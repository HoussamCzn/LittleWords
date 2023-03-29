import 'package:cv/cv.dart';
import 'package:tekartik_notepad_sqflite_app/db/db.dart';
import 'package:tekartik_notepad_sqflite_app/model/model_constant.dart';

class DbNote extends DbRecord {
  final usernameField = CvField<String>(username);
  final wordField = CvField<String>(word);

  @override
  List<CvField> get fields =>
      [id, usernameField, wordField];
}

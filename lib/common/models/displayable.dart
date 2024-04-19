import 'atoms.dart';
import 'attachement.dart';

abstract class Displayable {
  String get id;
  Translation<String> get title;
  Translation<String>? get subtitle;
  Translation<String>? get overline;
  Attachement? get image;
}

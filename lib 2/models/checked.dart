import 'package:mycgem/language_params/linkom_texts.dart';

class Checkedd {
  String id;
  String name;
  bool isselected = false;

  static List<Checkedd> check_list(context) => [
    Checkedd.fromDoc({"name": LinkomTexts.of(context).publi(), "checked": false}),
 ///   Checkedd.fromDoc({"name": LinkomTexts.of(context).commission(), "checked": false}),
  ///  Checkedd.fromDoc({"name": LinkomTexts.of(context).fed() , "cheked": false})
  ];

  Checkedd({this.id, this.name, this.isselected});

  factory Checkedd.fromDoc(Map<String, dynamic> document) {
    return new Checkedd(
        //id: document.documentID,
        name: document["name"],
        isselected: document["checked"]);
  }
}

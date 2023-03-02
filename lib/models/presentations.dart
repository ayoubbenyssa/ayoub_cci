class presentation{
String objectId ;
String text_ar;
String avantages;
List pic;
String text;
String updateAt;
String docUrl;
String doc ;
String craeteAt;
presentation(){}

// presentation({
//   this.objectId,this.text_ar,this.avantages,this.pic,this.text,this.updateAt,this.docUrl,this.doc,this.craeteAt
// });
// factory presentation.fromDoc(Map<String,dynamic> document) {
  fromJson_presentation(Map map){
      objectId = map["objectId"];
    text_ar = map["text_ar"];
    avantages =map["avantages"];
    pic = map["pic"];
    text = map["text"];
    updateAt = map["updatedAt"];
    docUrl = map["docUrl"];
    doc = map["doc"];
    craeteAt = map["createdAt"];
}
// }
}
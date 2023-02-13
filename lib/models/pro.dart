class Pro {
  String name;
  bool check = false;

  Pro({
    this.name,this.check
  });

  factory Pro.fromDoc(Map<String, dynamic> document) {
    return new Pro(name: document["name"],check:false);
  }
}

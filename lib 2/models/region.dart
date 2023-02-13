class Region {
  String id;
  String name;
  var num;
  bool check = false;
  String img;
  String vice_chef;
  String vice_image;
  String chef_image;
  String address;
  String tel;
  String fax;
  String email;
  String chef_name;
  String docUrl;
  String description;
  String im;
  String chef_civilite;
  String vice_civilite;

  Region(
      this.id,
      this.name,
      this.num,
      this.email,
      this.check,
      this.fax,
      this.tel,
      this.address,
      this.chef_image,
      this.vice_chef,
      this.vice_image,
      this.chef_civilite,
      this.vice_civilite,
      this.chef_name,
      this.img);

  Region.fromMap(Map<String, dynamic> document)
      : id = document["objectId"],
        name = document["region"],
        check = false,
        num = document["num"],
        img = document["picture"],
        tel = document["tel"],
        fax = document["fax"],
        chef_civilite = document["chef_civilite"],
        vice_civilite = document["vice_civilite"],
        address = document["address"],
        email = document["email"],
        im = document["picture"],
        docUrl = document["document"],
        vice_chef = document["vice_name"],
        description = document["description"],
        chef_image = document["chef_image"],
        vice_image = document["vice_image"],
        chef_name = document["chef_name"];
}

class SSRegion {
  String id;
  String name;

  bool check = false;

  SSRegion(this.id, this.name);

  SSRegion.fromMap(Map<String, dynamic> document)
      : id = document["objectId"],
        name = document["name"],
        check = false;
}

import 'package:intl/intl.dart';
import 'package:mycgem/models/membre.dart';
import 'package:mycgem/models/option.dart';
import 'package:mycgem/models/partner.dart';
import 'package:mycgem/models/user.dart';

class Offers {
  var objectId;
  var type = "";
  var address = "";
  var createdDate = "";
  var description = "";
  var service;
  var endDate;
  var type_offre_or_demande = '';
  var sector;
  String link_id;

  var initialPrice = "";
  bool wawitlike = false;
  var latLng = "";
  var name = "";
  var partnerKey = "";
  var quantity = "";
  var rate = "";
  var sellingPrice = "";
  String startDate = "";
  String tarif_url;
  var hour;
  var sponsorise;
  var rating;
  var condition;
  var title;
  var count_r;
  var summary = "";
  var urlVideo = "";
  List pic;
  var updatedAt = "";
  static var formatter = new DateFormat('yyyy-MM-dd');
  var dis;
  var created;
  var liked;
  var activatedDate;
  var numberlikes;
  User author;
  var aut;
  Membre partner;
  String phone;

  int numb;
  int nboost;
  int count = 0;
  User author1;
  var create;
  var budget;
  var cautions;
  var delete = false;
  var isLiked = false;
  var likesCount = 0;
  String numbercommenttext = "";
  var docUrl;
  String from_place;
  String to_place;
  String price;
  String date_cov;
  String nb_places;
  var page_number;
  List station;
  var hour_d;
  var createdAt;
  var lat;
  int didd = 0;

  var dte;
  var lng;
  var image;
  var views;
  var type_op;
  List items;
  List<dynamic> options = [];
  List<String> tags = [];
  List<String> categories = [];

  int length_option;
  String likes_post = "0";

  Offers(
      {this.objectId,
        this.type,
        this.dte,
        this.address,
        this.createdDate,
        this.likes_post,
        this.didd = 0,
        this.description,
        this.options,
        this.tags,
        this.categories,
        this.page_number,
        this.link_id,
        this.phone,
        this.condition,
        this.endDate,
        this.activatedDate,
        this.initialPrice,
        this.price,
        this.latLng,
        this.views,
        this.created,
        this.docUrl,
        this.tarif_url,
        this.count,
        this.create,
        this.name,
        this.budget,
        this.numb,
        this.wawitlike,
        this.cautions,
        this.author1,
        this.updatedAt,
        this.partnerKey,
        this.quantity,
        this.to_place,
        this.type_offre_or_demande,
        this.rating,
        this.nb_places,
        this.rate,
        this.count_r,
        this.partner,
        this.author,
        this.date_cov,
        this.title,
        this.station,
        this.startDate,
        this.hour,
        this.service,
        this.sellingPrice,
        this.summary,
        this.lat,
        this.lng,
        this.sponsorise,
        this.image,
        this.hour_d,
        this.urlVideo,
        this.from_place,
        this.createdAt,
        this.pic});

  Offers.fromMap(Map<String, dynamic> document)
      : objectId = document["objectId"],
        hour_d = document["hour_d"],
        sector = document["sector_"],
        lat = document["lat"],
        lng = document["lng"],
        tarif_url = "",
        service = document["service"],
        page_number = document["page_number"],
        numbercommenttext = document["comments_post"].toString() == "null"
            ? "0"
            : document["comments_post"].toString(),
        likes_post = document["likes_post"].toString() == "null"
            ? "0"
            : document["likes_post"].toString(),
        image = document["image"],
        wawitlike = false,
        hour = document["time"],
        items = document["items"],
        type_op = document["type_op"],
        docUrl = document["document"],
        sponsorise = document["sponsorise"],
        title = document["title"],
        options = document["options"].toString() == "null"
            ? []
            : document["options"]
            .map((val) => new Option.fromMap(val))
            .toList(),
        tags = document["tags"].toString() == "null"
            ? []
            : List<String>.from(document["tags"]),
        categories = document["categories"].toString() == "null"
            ? []
            : List<String>.from(document["categories"]),
        from_place = document["depart"],
        nboost = document["boostn"],
        views = document["views"].toString() == "null" ? 0 : document["views"],
        count = document["count"].toString() == "null" ? 0 : document["count"],
        link_id = document["link"],

      rating =
        document["rating"].toString() == "null" ? 0 : document["rating"],
        author1 = document["author"].toString() == "null"
            ? null
            : new User.fromMap(document["author"]),
        price = document["price"],
        to_place = document["destination"],
        date_cov = document["time_dep"],
        condition = document["condition"],
        station = document["station"],
        createdAt = document["createdAt"],
        numb = 0,
        created = document["createdDate"],
        nb_places = document["nb_place"],
        numberlikes = document["numberlikes"].toString(),
        pic = document["pictures"],
        type = document["type"],
        dte = document["time_an"],
        updatedAt = document["updatedAt"],
        create = DateTime.parse(document["createdAt"]),
        address = document["address"],
        count_r =
        document["count_r"].toString() == "null" ? 0 : document["count_r"],
        createdDate = document["createdDate"].toString(),
        description = document["description"],
        endDate = document["eventDate"].toString() == "null"
            ? ""
            : document["eventDate"],
        activatedDate = document["activateDate"].toString() == "null"
            ? DateTime.now().millisecondsSinceEpoch
            : document["activateDate"],
        initialPrice = document["initialPrice"].toString(),
        latLng = document["latLng"].toString(),
        name = document["name"],
        budget = document["budget"],
        type_offre_or_demande = document["type_offre_or_demande"],
        cautions = document["caution"],
        partnerKey = document["partnerKey"],
        quantity = document["quantity"].toString(),
        rate = document["rate"].toString(),
        startDate = document["activatedDate"].toString() == "null"
            ? ""
            : formatter
            .format(DateTime.fromMillisecondsSinceEpoch(1567353839080)),
        sellingPrice = document["sellingPrice"].toString(),
        summary = document["summary"].toString(),
        urlVideo = document["urlVideo"].toString(),
        aut = document["author"].toString(),
        partner = document["membre"].toString() == "null"
            ? null
            : new Membre.fromMap(document["membre"]),
        author = document["author"].toString() == "null"
            ? null
            : new User.fromMap(document["author"]);
}

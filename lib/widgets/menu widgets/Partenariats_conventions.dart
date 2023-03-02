import 'package:flutter/material.dart';
import 'package:mycgem/models/patner.dart';
import 'package:mycgem/services/partners_list.dart';

import '../widgets.dart';

class Partenariats_conventions extends StatefulWidget {

  @override
  _Partenariats_conventionsState createState() => _Partenariats_conventionsState();
}

class _Partenariats_conventionsState extends State<Partenariats_conventions> {

  List<Partnr> gal = [];
  bool load = true;

  getAll() async {
    var a = await PartnersList.get_list_partners_all();
    if (!this.mounted) return;
    setState(() {
      gal = a;
      // gal.insert(0, Partnr(date: "Date", name: "Convention", country: "Pays"));

      load = false;
    });
  }

  Widget items_cart(image,title,text,iconH,iconW){
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 5),

        margin: EdgeInsets.only(bottom: 5),
        child :
        Wrap(
          children: [
            Row(
              children: [
                Container(
                  child: Image.asset(image,height: iconH,width: iconW,fit: BoxFit.cover,),
                ),
                SizedBox(width: 6,),
                Container(
                  child: Text(title, maxLines: 3,style: TextStyle(
                      color: Color(0xff262B6D),fontFamily: "Louis George Cafe",fontSize: 13,fontWeight: FontWeight.bold
                  ),),
                ),

              ],
            ),
            SizedBox(height: 10,),

            Wrap(children: [
              Container(
                padding: EdgeInsets.only(left: 19,top: 2),
                child: Text(text, maxLines: 3,style: TextStyle(
                    color: Color(0xffBCBCBC),fontFamily: "Louis George Cafe",fontSize: 13,fontWeight: FontWeight.bold
                ),),
              ),
            ],),
            SizedBox(height: 5,),

          ],
        )
    );
  }

  Widget cart_item(date  , CONVENTION ,PAYS){
    return  Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
      // height: 165,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        border: Border.all(color: Color(0xffC9C9CE),width: 0.5),

      ),
      child: Column(
        children: [
          items_cart("images/date.png","DATE :" , date,20.00,17.00)   ,
          items_cart("images/handshake.png","CONVENTION :" ,CONVENTION,15.00,14.00)   ,
          items_cart("images/localisation.png","PAYS : " , PAYS,20.00,17.00)   ,
        ],
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Color.fromRGBO(247, 247, 247, 100),
    elevation: 0.0,
    iconTheme: IconThemeData(color: Color(0xff272C6E)),
    title: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text("Partenariats et conventions", style: TextStyle(color: Color(0xff272C6E),fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "louis george cafe"),),
    Container(
    margin: EdgeInsets.only(right: 10,),
    height: 40,
    width: 40,
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(9)),

    ),
    child: Center(
    child: Image.asset("images/logo.png"),
    ),
    ),
    ],
    ),

    ),
      body: Container(
        color: Color.fromRGBO(247, 247, 247, 100),
        child: Container(
            height: double.infinity,
            width: MediaQuery.of(context).size.width *1 ,
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            margin: EdgeInsets.only(left: 27, right: 27,top: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 0.5),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                topLeft: Radius.circular(25),
              ),
              color: Colors.white,
            ),

            child: load ? Center(child: Widgets.load()) : SingleChildScrollView(
              child: Column(

                  children: gal
                      .map(
                        (e) =>
                        cart_item(e.date.split("T")[0],e.name,e.country)
                  )
                      .toList()),

        ),
      ))
    );
  }
}


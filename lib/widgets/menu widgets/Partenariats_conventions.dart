import 'package:flutter/material.dart';

class Partenariats_conventions extends StatefulWidget {

  @override
  _Partenariats_conventionsState createState() => _Partenariats_conventionsState();
}

class _Partenariats_conventionsState extends State<Partenariats_conventions> {

  Widget items_cart(image,title,text){
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 5),

        margin: EdgeInsets.only(bottom: 5),
        child :
        Wrap(
          children: [
            Row(
              children: [
                Container(
                  child: Image.asset(image,height: 15,width: 14,fit: BoxFit.cover,),
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

  Widget cart_item(image  , title ,text){
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
          items_cart("images/phonex.png","DATE :" , "19/05/1994")   ,
          items_cart("images/phonex.png","CONVENTION :" ,"Concention de collaboration  Concention de collaboration Concention de collaboration,Concention de collaboration ,Concention de collaboration")   ,
          items_cart("images/phonex.png","PAYS : " , "LES ILES CANARIES")   ,
        ],
      ),
    );
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

            child: SingleChildScrollView(
              child: Column(
                children: [
                  cart_item("images/phonex.png","DATE :" , "19/05/1994")   ,
                  cart_item("images/phonex.png","CONVENTION :" ," Concention de collaboration  Concention de collaboration Concention de collaboration,Concention de collaboration ,Concention de collaboration")   ,
                  cart_item("images/phonex.png","PAYS : " , "LES ILES CANARIES")   ,


                ],
              ),
            )
        ),
      ),
    );
  }
}


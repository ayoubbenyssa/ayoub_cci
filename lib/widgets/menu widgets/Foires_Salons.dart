import 'package:flutter/material.dart';

class Foires_Salons extends StatefulWidget {

  @override
  _Foires_SalonsState createState() => _Foires_SalonsState();
}

class _Foires_SalonsState extends State<Foires_Salons> {
  Widget items_cart(image,text,ht ,wd){
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child :
      Row(
        children: [
          Container(
            child: Image.asset(image,height: ht ,width: wd,fit: BoxFit.fill,),
          ),
          SizedBox(width: 4,),
          Container(
            child: Text(text, style: TextStyle(
              color: Color(0xffC9C9C9),fontFamily: "Louis George Cafe",fontSize: 10,fontWeight: FontWeight.w400
            ),),
          ),
        ],
      )
    );
  }

  Widget cart_item(image,title ,desc, adresse, date ,org,tell ,site_web ,email ){
    return  Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.symmetric(horizontal: 9,vertical: 8),
      // height: 165,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        border: Border.all(color: Color(0xffC9C9CE),width: 0.5),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),

            ),
            height: 80,width: 110,
            padding: EdgeInsets.symmetric(horizontal: 9.0,vertical: 8),
            child: Image.asset(image,fit: BoxFit.cover,),
          ),
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 9,vertical: 2),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisAlignment: MainAxisAlignment.start,
               children: [
               Container(child: Text(title,
               maxLines: 1,
               textAlign: TextAlign.start,
               style: TextStyle(
                   color: Color(0xff262B6D),fontWeight: FontWeight.bold,fontSize: 13,fontFamily: "Louis George Cafe"
               ),
               ),
               ),
               SizedBox(height: 5,),
               Container(
                 child: Text(desc,
                   textAlign: TextAlign.start,
                   maxLines: 2,
                 style: TextStyle(
                     color: Color(0xffC9C9C9),fontWeight: FontWeight.w400,fontSize: 10,fontFamily: "Louis George Cafe"
                 ),
               ),
               ),
               SizedBox(height: 5,),

                 adresse != "" ?  items_cart("images/edittt.png",adresse,8.0,9.0) : Container(),
                 date != "" ?   items_cart("images/edittt.png",date,8.0,9.0) : Container(),
                 org != "" ? items_cart("images/edittt.png",org,8.0,9.0) : Container(),
                 tell != "" ?items_cart("images/phonex.png",tell,8.0,9.0) : Container(),
                 email != "" ? items_cart("images/attchaa.png",email,8.0,9.0) : Container(),


             ],),
            ),
          )
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
            Text("Foires & Salons", style: TextStyle(color: Color(0xff272C6E),fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "louis george cafe"),),
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
                  cart_item("assets/images/logo.png","FI EUROPE & NI 2015","Salon international des ingrédients alimentaires","Paris / France","Du 01 au 03 décembre 2015","United Business Media","+31 20 40 99 544","http://www.ubm.com/",""),
                  cart_item("assets/images/logo.png","FI EUROPE & NI 2015","Salon international des ingrédients alimentaires","Paris / France","Du 01 au 03 décembre 2015","United Business Media","+31 20 40 99 544","http://www.ubm.com/",""),
                  cart_item("assets/images/logo.png","FI EUROPE & NI 2015","Salon international des ingrédients alimentaires","Paris / France","Du 01 au 03 décembre 2015","United Business Media","+31 20 40 99 544","http://www.ubm.com/",""),
                  cart_item("assets/images/logo.png","FI EUROPE & NI 2015","Salon international des ingrédients alimentaires","Paris / France","Du 01 au 03 décembre 2015","United Business Media","+31 20 40 99 544","http://www.ubm.com/",""),


                ],
              ),
            )
        ),
      ),
    );  }
}

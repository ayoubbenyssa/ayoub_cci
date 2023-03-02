import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/models/presentations.dart';

class Presentations extends StatefulWidget {


  @override
  _PresentationsState createState() => _PresentationsState();
}

class _PresentationsState extends State<Presentations> {

  bool plus_presentation = false ;

  styleText(){
    return TextStyle(fontFamily: "louis george cafe", fontSize: 15,fontWeight: FontWeight.bold,color: Color(0xff707070));
  }
  Widget title(x){
    return     Wrap(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(x,
            style: styleTitle(),),
        ),
      ],
    );
  }
  Widget item(text){
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      decoration: BoxDecoration(
          color: Color(0xffF8F8F8),
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        // direction: Axis.horizontal,
        children: [
          Container(
            child: CircleAvatar(
              backgroundColor: Color(0xff218BB1),
              radius: 4,
            ),
          ),
          SizedBox(width: 7,),
          Flexible(
            child: Container(
              child: Text(text,
                style: TextStyle(color: Color(0xff707070),fontSize: 11,fontWeight: FontWeight.bold,fontFamily: "louis george cafe"),),
            ),
          ),


        ],
      ),
    );
  }
  styleTitle(){
    return TextStyle(
      color: Color(0xff187FB2),
      fontWeight: FontWeight.bold,
      fontSize: 25,
      fontFamily:"louis george cafe",
    );
  }
  ParseServer parse_s = new ParseServer();
  presentation pres = new presentation();

  getPresntation() async {
    var a = await parse_s
        .getparse('presentation');
    print("aaaaaa $a");
    print("********** Nom 8 ***********");
    print("aaaaaa");

    // var responsebody = jsonDecode(a);
    print("********** Nom 1 ***********");

    var presontation_ccis ;

    print("********** Nom 2 ***********");

    presontation_ccis = a['results'] ;

    return presontation_ccis ;
  }

  get_info() async{
    print("********** Nom 3***********");

    var compt = await getPresntation() ;
    print("********** Nom 4 ***********");
    print("aaaaaa ${compt}");

    if(!this.mounted) return;
    print("********** Nom 5***********");
    print("aaaaaa111 ${compt[0]}");

    setState(() {
      pres.fromJson_presentation(compt[0]);
    });
    print("********** Nom ***********");
    print(pres.craeteAt);
    print("********** Nom ***********");

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPresntation();
    print("********** @@@@***********");
    get_info() ;
    print("********** !!!!***********");

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
            Text("Présentation", style: TextStyle(color: Color(0xff272C6E),fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "louis george cafe"),),
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            title("Présentation"),

            Wrap(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xffF8F8F8),
                      borderRadius: BorderRadius.all(Radius.circular(25))
                  ),
                  padding: EdgeInsets.only(left: 18,right: 18,top: 15,bottom: 15),
                  child: Column(
                    children: [
                      Container(
                        child:
                        Text( pres.text.toString()
                      .replaceAll(RegExp(r'(\\n)+'), ''),
                          maxLines: ! plus_presentation ? 14 : null,
                          // "Créée en 1962, la Chambre de Commerce, d’Industrie et de Services de Souss Massa « CCISSM », Chambre professionnelle est un organisme public chargé de représenter, défendre et développer les intérêts de l’ensemble des entreprises patentées, sises dans sa circonscription territoriale qui s’étend sur une superficie de 52.064 km2 et englobe plus de 64000 entreprises.",
                          style: styleText(),
                        ),
                      ),
                      SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: (){
                              setState(() {
                                plus_presentation = plus_presentation ? false : true ;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xff187FB2),width: 0.5),
                                  color: Color(0xffF8F8F8),
                                  borderRadius: BorderRadius.all(Radius.circular(25))
                              ),
                              child: Text(plus_presentation ? "voir moins" : "Voir plus",style: TextStyle(
                                  color: Color(0xff187FB2),fontWeight: FontWeight.w400,fontSize: 11,fontFamily: "louis george cafe"
                              ),),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),

              ],
            ),

            SizedBox(height: 7,),

            title("La CCISSM des missions accomplies :"),

            SizedBox(height: 7,),

            Wrap(children: [
              Container(
                child: Text("La loi 38-12 portant statut des CCIS du Maroc, promulguée par le dahir n°1-13-09 du 21 Février 2013, attribue aux CCIS trois missions : ",
                  style: styleText(),
                ),
              )
            ],),
            SizedBox(height: 7.5,),
            Wrap(
              spacing: 10,
              runSpacing: 12,
              
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 11,vertical: 6),
                  decoration: BoxDecoration(
                    color: Color(0xffF7F7F7),
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    border: Border.all(color : Color(0xffF8F8F8) ,width: 0.5),
                  ),
                  child: Text("Représentative",
                    style: TextStyle(fontFamily: "louis george cafe", fontSize: 11,fontWeight: FontWeight.bold,color: Color(0xff187FB2)),
                  ),
                ),
                SizedBox(width: 13,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 11,vertical: 6),
                  decoration: BoxDecoration(
                    color: Color(0xffF7F7F7),
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    border: Border.all(color : Color(0xffF8F8F8) ,width: 0.5),
                  ),
                  child: Text("Consultative",
                    style: TextStyle(fontFamily: "louis george cafe", fontSize: 11,fontWeight: FontWeight.bold,color: Color(0xff187FB2)),
                  ),
                ),
                SizedBox(width: 13,),


                Container(

                  padding: EdgeInsets.symmetric(horizontal: 11,vertical: 6),
                  decoration: BoxDecoration(
                    color: Color(0xffF7F7F7),
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    border: Border.all(color : Color(0xffF8F8F8) ,width: 0.5),
                  ),
                  child: Text("Appui économique",
                    style: TextStyle(fontFamily: "louis george cafe", fontSize: 11,fontWeight: FontWeight.bold,color: Color(0xff187FB2)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 7.5,),

            Wrap(children: [
              Container(
                child: Text(" Ainsi, selon ces nouveaux statuts, de nouveaux mécanismes d’appui et de promotion ont été crées en vue d’adapter le rôle des CCIS aux nouvelles donnes de l’économie nationale et aux besoins spécifiques de leurs ressortissants.",
                  style: styleText(),
                ),
              )
            ],),

            SizedBox(height: 7,),

            title("La CCISSM à votre service"),

            SizedBox(height: 7.5,),

            Wrap(children: [
              Container(
                child: Text("la CCISSM, important réseau d’entreprises, force de proposition et interlocuteur privilégiés des industriels , commerçants et prestataires de services auprès des pouvoirs publics, œuvre via ses conseils, ses avis, ses propositions et ses aides et déploie des efforts considérables pour accomplir ses missions et répondre à vos attentes. Soucieuse du développement économique régional et de la modernisation et la pérennité de votre entreprise et en vue de mieux vous servir, vous investisseurs, chef d’entreprise commerciale, industrielle ou de services, porteur d’idée de création d’entreprise ou étudiant, la CCISSM :",
                  style: styleText(),
                ),
              )
            ],),
            SizedBox(height: 7,),

            item("S’est dotée d’outils et de structures nécessaires et adéquates, de ressources humaines ayant développé une expertise dans des domaines variés et a élaboré une gamme de services adaptésà vos besoins spécifiques."),
            item("Promeut et s’implique activement dans les différents programmes gouvernementaux visant la modernisation, la mise à niveau technologique, humaine de votre entreprise et son ouverture sur le monde"),
            item("Travaille en étroite collaboration et concertation avec un vaste réseau de partenaires, régionaux, nationaux et internationaux, en vue de développer l’économie régionale et de vous aider à créer de la richesse."),

            SizedBox(height: 7,),

            title("La CCISSM : des prestations ciblées"),

            SizedBox(height: 7,),

            item("Une assistance personnalisée, des conseils pratiques, un accompagnement à tous les stades de création et de développement de votre entreprise."),



          ],
        ),
      ),
    ),

      ),


    );
  }

}

import 'package:flutter/material.dart';
import 'package:mycgem/models/patner.dart';
import 'package:mycgem/services/partners_list.dart';
import 'package:mycgem/widgets/app_appbar.dart';
import 'package:mycgem/widgets/widgets.dart';

class Partners extends StatefulWidget {
  const Partners({Key key}) : super(key: key);

  @override
  _PartnersState createState() => _PartnersState();
}

class _PartnersState extends State<Partners> {
  List<Partnr> gal = [];
  bool load = true;

  getAll() async {
    var a = await PartnersList.get_list_partners_all();
    if (!this.mounted) return;
    setState(() {
      gal = a;
      gal.insert(0, Partnr(date: "Date", name: "Convention", country: "Pays"));

      load = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAll();
  }

  @override
  Widget build(BuildContext context) {
    /**
     *   TableRow(children: [
        Column(children: [

        Text('Date')
        ]),
        Column(children: [

        Text('Convention')
        ]),
        Column(children: [

        Text('Pays')
        ]),
        ])
     */
    return Scaffold(
        appBar: MyCgemBarApp(
          "Partenaires",
          actionswidget: Container(),
        ),
        body: Center(
            child: load
                ? Widgets.load()
                : ListView(padding: EdgeInsets.all(12), children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(12),
                      child: Table(

                          border: TableBorder.all(),
                          children: gal
                              .map(
                                (e) => TableRow(children: [
                                  Text(e.date),
                                  Text(e.name),
                                  Text(e.country),
                                ]),
                              )
                              .toList()),
                    ),
                  ])));
  }
}

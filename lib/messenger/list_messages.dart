import 'package:flutter/material.dart';
import 'package:mycgem/messenger/message_item.dart';
import 'package:mycgem/models/conversation.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/conversation_services.dart';
import 'package:mycgem/widgets/widgets.dart';


class ListMessages extends StatefulWidget {
  ListMessages(this.user,this.chng);
  User user ;
  var chng;


  @override
  _ListMessagesState createState() => _ListMessagesState();
}

class _ListMessagesState extends State<ListMessages> {

  List<Conversation> list_m =  new   List<Conversation>();
  bool loading = true;


  getLIst_messages() async {
    var a = await ConversationServices.get_list_conv(widget.user.id);
    print("<3");
    print(a);
    if(!this.mounted)
      return;
    setState(() {
      list_m = a;
      loading = false;
    });
}

  @override
  void initState() {

    getLIst_messages();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return list_m.isEmpty
        ?Center(child: Text("Aucun message trouvé!"),):loading ?Widgets.load()
        :  Center(
        child: ListView(
          padding: EdgeInsets.all(0.0),
          children: List.generate(list_m.length, (index) {
            return MessageItem(list_m[index],widget.user, widget.chng);
          }),

    ));
  }
}

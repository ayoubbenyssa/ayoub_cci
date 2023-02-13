import 'package:http/http.dart' as clientHttp;


class EmailService {


  static sendCustomMail(String emails, subject, message)  async{
   var res =  await clientHttp.post(
        "https://us-central1-raja-connect.cloudfunctions.net/sendCustomMailToUser4",
        body: {"subject": subject, "message": message, "email": emails});
   return res.body;

  }



  static sendCustomMail2(String emails, subject, message)  async{
    var res =  await clientHttp.post(
        "https://us-central1-raja-connect.cloudfunctions.net/sendCustomMailToUser4",
        body: {"subject": subject, "message": message, "email": emails});
    return res.body;

  }


  static sendCustomMail3(String emails, subject, message)  async{
    var res =  await clientHttp.post(
        "https://us-central1-raja-connect.cloudfunctions.net/sendCustomMailToUser4",
        body: {"subject": subject, "message": message, "email": emails});
    return res.body;

  }





}

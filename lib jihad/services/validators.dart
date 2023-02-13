import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:regexed_validator/regexed_validator.dart';

class Validators {
  Validators({this.context});

  var context;

  String validatephonenumber(String value) {

    final regexp = RegExp(r'^[0|212|+212][0-9]{9}$');
    if (value.length <= 0)
      return "Entrez le numéro de téléphone !";
    else if (!regexp.hasMatch(value) || value.length > 10) {
      return 'Veuillez renseigner un numéro de téléphone valide selon le format 06xxxxxxxx';
    }
    return null;


    return LinkomTexts.of(context).num_tel();
  }

  String validateEmail(String value) {
    if (value.isEmpty) {
      // The form is empty
      return LinkomTexts.of(context).ent_mail();
    }
    // This is just a regular expression for email addresses
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(p);

    if (regExp.hasMatch(value)) {
      // So, the email is valid
      return null;
    }
    return LinkomTexts.of(context).email_not();
  }
// errorStyle: TextStyle(
//       fontSize: 16.0,
//     ),
  String validatePassword1(String value) {
    print("noooo");
    print(validator.password(value));

    if (value.length <= 5) {
      return LinkomTexts.of(context).mot_n();
    } else if (validator.password(value) == false)
      return 'Le mot de passe doit contenir au minimum 1 Majuscule, 1 Chiffre et un Symbole !';
    else
      return null;
  }

  String validatePassword2(String value) {
    if (value.length <= 5) {
      return LinkomTexts.of(context).mot_n();
    } /*else if (regExp.hasMatch(value) == false)
      return 'le mot de passe doit respecter des exigences de complexité';*/
    else
      return null;
  }

  String validatedesc(String value) {
    if (value.length > 0) {
      return null;
    }
    return "Entrez la description";
  }

  String validatecont(String value) {
    if (value.length > 0) {
      return null;
    }
    return "L'email ou numéro de téléphone";
  }

  String validatename(String value) {
    if (value.isEmpty) return "Entrez votre nom";
    /*final RegExp nameExp = new RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value))
      return LoDocText.of(context).alpha_n();*/
    return null;
  }

  String valprofile(String value) {
    if (value.length <= 0) return "Entrez le titre de votre profile";
    /*final RegExp nameExp = new RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value))
      return LoDocText.of(context).alpha_n();*/
    return null;
  }

  String valorganisme(String value) {
    if (value.length <= 0) return "Entrez l'organisme actuel";
    /*final RegExp nameExp = new RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value))
      return LoDocText.of(context).alpha_n();*/
    return null;
  }

  String titrre(String value) {
    if (value.length <= 0) return "Entrez le titre";
    /*final RegExp nameExp = new RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value))
      return LoDocText.of(context).alpha_n();*/
    return null;
  }

  String bud(String value) {
    if (value.length <= 0) return "Entrez le budget estimatif";
    /*final RegExp nameExp = new RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value))
      return LoDocText.of(context).alpha_n();*/
    return null;
  }

  String caut(String value) {
    if (value.length <= 0) return "Entrez la caution";
    /*final RegExp nameExp = new RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value))
      return LoDocText.of(context).alpha_n();*/
    return null;
  }

  String descc(String value) {
    if (value.length <= 0) return "Entrez une description";
    /*final RegExp nameExp = new RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value))
      return LoDocText.of(context).alpha_n();*/
    return null;
  }

  String addre(String value) {
    if (value.length <= 0) return "Entrez l'adresse";
    /*final RegExp nameExp = new RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value))
      return LoDocText.of(context).alpha_n();*/
    return null;
  }

  String validatetitre(String value) {
    if (value.length > 0) {
      return null;
    }
    return "Entrer votre fonction";
  }

  String validaten(String value) {
    if (value.length > 0) {
      return null;
    }
    return "Entrer le nom de l'entreprise";
  }

  String validateorganisme(String value) {
    if (value.length > 0) {
      return null;
    }
    return "Entrer le ICE";
  }

  String validateAddress(String value) {
    if (value.length > 0) {
      return null;
    }
    return "Entrez l'adresse";
  }
}

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

final _keepAnalysisHappy = Intl.defaultLocale;

class MessageLookup extends MessageLookupByLibrary {
  get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);

  static _notInlinedMessages(_) => {
        "login": MessageLookupByLibrary.simpleMessage("Se connecter"),
        "sve": MessageLookupByLibrary.simpleMessage("Enregistrer".toUpperCase()),
        "search_r": MessageLookupByLibrary.simpleMessage("Cherchez une responsabilité"),
        "len": MessageLookupByLibrary.simpleMessage("Organismes"),
        "group": MessageLookupByLibrary.simpleMessage("Groupe"),
        "priv": MessageLookupByLibrary.simpleMessage("Privée"),

        "dem": MessageLookupByLibrary.simpleMessage("Demande de connexion"),

        "no_not": MessageLookupByLibrary.simpleMessage('Aucune notification trouvée'),
        "no_mess": MessageLookupByLibrary.simpleMessage('Aucun message trouvé '),
        "block": MessageLookupByLibrary.simpleMessage('Bloquer cet utilisateur '),


        "activate": MessageLookupByLibrary.simpleMessage('Activer le compte'),
        "disa": MessageLookupByLibrary.simpleMessage("Votre compte est désactivé, voulez vous réactiver votre compte"),


        "contact": MessageLookupByLibrary.simpleMessage("CONTACTER"),



        "aucun_g": MessageLookupByLibrary.simpleMessage("Aucun résultat trouvé !"),
        "continue": MessageLookupByLibrary.simpleMessage("Continuer"),
        "valid": MessageLookupByLibrary.simpleMessage("Valable jusqu'à"),
        "budget": MessageLookupByLibrary.simpleMessage("Budget estimatif"),
        "caut": MessageLookupByLibrary.simpleMessage("Caution"),

        "disa": MessageLookupByLibrary.simpleMessage(""),
        "disa": MessageLookupByLibrary.simpleMessage(""),
        "disa": MessageLookupByLibrary.simpleMessage(""),
        "disa": MessageLookupByLibrary.simpleMessage(""),
        "disa": MessageLookupByLibrary.simpleMessage(""),
        "disa": MessageLookupByLibrary.simpleMessage(""),
        "disa": MessageLookupByLibrary.simpleMessage(""),
        "disa": MessageLookupByLibrary.simpleMessage(""),
        "disa": MessageLookupByLibrary.simpleMessage(""),
        "disa": MessageLookupByLibrary.simpleMessage(""),
        "disa": MessageLookupByLibrary.simpleMessage(""),
        "disa": MessageLookupByLibrary.simpleMessage(""),



        "resps": MessageLookupByLibrary.simpleMessage('Veuillez choisir une responsablité'),
        "lresp": MessageLookupByLibrary.simpleMessage('Responsabilités'),

        "fed": MessageLookupByLibrary.simpleMessage('Fédérations statutaires'),
        "option": MessageLookupByLibrary.simpleMessage("Cette option est réservée aux membres vérifiés ! Contactez l'administrateur pour valider votre compte"),
        "bén": MessageLookupByLibrary.simpleMessage("Bénéficiez"),
        "here": MessageLookupByLibrary.simpleMessage('Cliquez ici pour voir plus de details '),
        "ve_e": MessageLookupByLibrary.simpleMessage("Veuillez choisir l'entreprise"),


        "rej_c": MessageLookupByLibrary.simpleMessage("Groupes de discussion"),
        "rej_f": MessageLookupByLibrary.simpleMessage("Groupes de discussion"),
        "searchc": MessageLookupByLibrary.simpleMessage('Rechercher une conversation '),

        "login_google":
            MessageLookupByLibrary.simpleMessage("SE CONNECTER AVEC GOOGLE"),
        "login_facebook":
            MessageLookupByLibrary.simpleMessage("SE CONNECTER AVEC FACEBOOK"),
        "filtrer": MessageLookupByLibrary.simpleMessage('Filtrer par'),
        "commission": MessageLookupByLibrary.simpleMessage('Commissions '),
        "actu": MessageLookupByLibrary.simpleMessage('Actualités '),
        "oppo":
            MessageLookupByLibrary.simpleMessage("Opportunités d'affaires"),
        "CGEM": MessageLookupByLibrary.simpleMessage('La CGEM'),
        "ava": MessageLookupByLibrary.simpleMessage('Avantages '),
        "prodss": MessageLookupByLibrary.simpleMessage(
            'Marketplace '),
        "tarifs":
            MessageLookupByLibrary.simpleMessage('Avantages+ by CGEM'),
        "vids": MessageLookupByLibrary.simpleMessage('Vidéothèque'),
        "pres": MessageLookupByLibrary.simpleMessage('La voix du secteur privé marocain'),
        "services": MessageLookupByLibrary.simpleMessage('Services aux membres'),
        "comms": MessageLookupByLibrary.simpleMessage('Commissions permanentes '),
        "fids":
            MessageLookupByLibrary.simpleMessage('Fédérations statutaires'),
        "entrep": MessageLookupByLibrary.simpleMessage('Organismes'),
        "ccom": MessageLookupByLibrary.simpleMessage('Choisir une commission'),
        "cfed": MessageLookupByLibrary.simpleMessage('Choisir une féderation '),
        "cent": MessageLookupByLibrary.simpleMessage('Rechercher votre organisme '),

        "search_opp":
            MessageLookupByLibrary.simpleMessage('Rechercher une opportunité'),
        "type_opp": MessageLookupByLibrary.simpleMessage("Type d'opportunité"),
        "mone": MessageLookupByLibrary.simpleMessage('Mon entreprise '),
        "suivi": MessageLookupByLibrary.simpleMessage('Suivi'),
        "typ": MessageLookupByLibrary.simpleMessage("Type "),



        "sui": MessageLookupByLibrary.simpleMessage('SUIVRE'),
        "sui_ent": MessageLookupByLibrary.simpleMessage('Suivre cette entreprise'),

        "sector": MessageLookupByLibrary.simpleMessage('Secteur '),
        "g_n": MessageLookupByLibrary.simpleMessage('Groupes nationaux'),

        "g_r": MessageLookupByLibrary.simpleMessage('Groupes régionaux'),





        "notm":
            MessageLookupByLibrary.simpleMessage("C’est votre premier accès ?"),
        "ent_mail": MessageLookupByLibrary.simpleMessage(
            "Entrez votre email"),
        "mot_n": MessageLookupByLibrary.simpleMessage(
            "Le mot de passe doit contenir au moins 6 caractères "),
        "email_not":
            MessageLookupByLibrary.simpleMessage("L'email n'est pas valide"),
        "macc": MessageLookupByLibrary.simpleMessage("CRÉER UN COMPTE"),
        "details": MessageLookupByLibrary.simpleMessage("En savoir plus"),
        "proff": MessageLookupByLibrary.simpleMessage("Profession"),
        "pre": MessageLookupByLibrary.simpleMessage("Prénom"),
        "organisme": MessageLookupByLibrary.simpleMessage("Organisme"),
        "biblio":
            MessageLookupByLibrary.simpleMessage("Bibliothèque électronique"),
        "publi": MessageLookupByLibrary.simpleMessage("Actualités"),
        "agenda": MessageLookupByLibrary.simpleMessage("Événements"),
        "forms": MessageLookupByLibrary.simpleMessage("Formations"),
        "btk": MessageLookupByLibrary.simpleMessage("Boutique en ligne"),
        "casc": MessageLookupByLibrary.simpleMessage("Cas clinique"),
        "conv": MessageLookupByLibrary.simpleMessage("Conventions"),
        "ann": MessageLookupByLibrary.simpleMessage("Annonces"),
        "cartem": MessageLookupByLibrary.simpleMessage("Carte"),
        "invite": MessageLookupByLibrary.simpleMessage("Invitez vos contacts"),
        /*  à rejoindre SANTÉ CONNECT*/
        "po": MessageLookupByLibrary.simpleMessage(" Powerd by: "),
        "fils": MessageLookupByLibrary.simpleMessage("Fil d'actualités"),
        "netw": MessageLookupByLibrary.simpleMessage("Networking"),
        "poli": MessageLookupByLibrary.simpleMessage(
            "Politique de confidentialité "),
        "messg": MessageLookupByLibrary.simpleMessage("Messagerie"),
        "phone": MessageLookupByLibrary.simpleMessage("GSM"),
        "password": MessageLookupByLibrary.simpleMessage("Mot de passe"),
        "register_new": MessageLookupByLibrary.simpleMessage("Register"),
        "forget_pass":
            MessageLookupByLibrary.simpleMessage("Mot de passe oublié ?"),
        "register": MessageLookupByLibrary.simpleMessage("S'inscrire"),
        "fullname": MessageLookupByLibrary.simpleMessage("Nom"),
        "alllist": MessageLookupByLibrary.simpleMessage('All posts'),
        "chatb": MessageLookupByLibrary.simpleMessage("Chat inbox"),
        "edit": MessageLookupByLibrary.simpleMessage('Modify'),
        "change": MessageLookupByLibrary.simpleMessage('FERMER'),
        "chatg": MessageLookupByLibrary.simpleMessage('Chat group'),
        "members": MessageLookupByLibrary.simpleMessage('Membres'),
        "editp": MessageLookupByLibrary.simpleMessage("Edit profil"),
        "submedit": MessageLookupByLibrary.simpleMessage('EDIT YOUR PROFIL'),
        "editprof": MessageLookupByLibrary.simpleMessage("UPDATE"),
        "search": MessageLookupByLibrary.simpleMessage("RECHERCHER"),
        "center_rec":
            MessageLookupByLibrary.simpleMessage("Centre de réclamation"),
        "client": MessageLookupByLibrary.simpleMessage("CLIENT"),
        "rec": MessageLookupByLibrary.simpleMessage("RÉCAPITULATIF"),
        "votre": MessageLookupByLibrary.simpleMessage("VOTRE CARTE"),
        "carte": MessageLookupByLibrary.simpleMessage("CARTE"),
        "compte": MessageLookupByLibrary.simpleMessage("COMPTE"),
        "pa": MessageLookupByLibrary.simpleMessage("PAIEMENT"),
        "montr": MessageLookupByLibrary.simpleMessage("MON TRAJET"),
        "typed": MessageLookupByLibrary.simpleMessage("Type d'abonnement"),
        "classe": MessageLookupByLibrary.simpleMessage("Classe"),
        "dte_v": MessageLookupByLibrary.simpleMessage("Date de validité"),
        "dur": MessageLookupByLibrary.simpleMessage("Durée de l'abonnement"),
        "ma_d": MessageLookupByLibrary.simpleMessage("Ma gare de départ"),
        "ma_a": MessageLookupByLibrary.simpleMessage("Ma gare d'arrivée"),
        "infos": MessageLookupByLibrary.simpleMessage("Mes Informations"),
        "nv": MessageLookupByLibrary.simpleMessage("Nouvel abonné"),
        "vis": MessageLookupByLibrary.simpleMessage("Visiteur"),
        "nom": MessageLookupByLibrary.simpleMessage("Nom"),
        "pr": MessageLookupByLibrary.simpleMessage("Prénom"),
        "nat": MessageLookupByLibrary.simpleMessage("Nationalité"),
        "prof": MessageLookupByLibrary.simpleMessage("Profession"),
        "fixe": MessageLookupByLibrary.simpleMessage("Fixe"),
        "port": MessageLookupByLibrary.simpleMessage("GSM"),
        "daten": MessageLookupByLibrary.simpleMessage("Né(e) le"),
        "mac": MessageLookupByLibrary.simpleMessage("MA CARTE"),
        "bienvenue": MessageLookupByLibrary.simpleMessage("Bienvenue"),
        "adrv":
            MessageLookupByLibrary.simpleMessage("Adresse complète et ville"),
        "confirm_password":
            MessageLookupByLibrary.simpleMessage("Confirmer le mot de passe"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "address": MessageLookupByLibrary.simpleMessage("Title"),
        "registerr": MessageLookupByLibrary.simpleMessage("Identifiant"),
        "send_pass": MessageLookupByLibrary.simpleMessage("Send password"),
        "language": MessageLookupByLibrary.simpleMessage("Langue"),
        "contact_us": MessageLookupByLibrary.simpleMessage("CONTACTEZ-NOUS"),
        "agree": MessageLookupByLibrary.simpleMessage(
            "I agree terms and conditions"),
        "loc_v": MessageLookupByLibrary.simpleMessage(" Localisation visible"),
        "online": MessageLookupByLibrary.simpleMessage("Je veux être visible"),
        "about": MessageLookupByLibrary.simpleMessage("About"),
        "condit": MessageLookupByLibrary.simpleMessage(
            "Conditions générales d'utilisation :"),
        "logout": MessageLookupByLibrary.simpleMessage("Se déconnecter"),
        "confirm": MessageLookupByLibrary.simpleMessage("CONFIRMER"),
        "skip": MessageLookupByLibrary.simpleMessage("PASSER"),
        "title": MessageLookupByLibrary.simpleMessage('ONCF INKHIRAT'),
        "mesc": MessageLookupByLibrary.simpleMessage('MES CARTES'),
        "home": MessageLookupByLibrary.simpleMessage("Accueil"),
        "mylist": MessageLookupByLibrary.simpleMessage('My listing'),
        "pay": MessageLookupByLibrary.simpleMessage(' Payment history'),
        "myp": MessageLookupByLibrary.simpleMessage('MON PROFIL '),
        "partn": MessageLookupByLibrary.simpleMessage("Partenaires"),
        "tous": MessageLookupByLibrary.simpleMessage("Tout"),
        "pers": MessageLookupByLibrary.simpleMessage("Personnes"),
        "typeb": MessageLookupByLibrary.simpleMessage("Type de publication"),
        "sond": MessageLookupByLibrary.simpleMessage("Sondages"),
        "offe": MessageLookupByLibrary.simpleMessage("Offre Emploi/Stage"),
        "compe": MessageLookupByLibrary.simpleMessage("Domaines d’expertise"),
        "objs": MessageLookupByLibrary.simpleMessage("Centres d’intérêt "),
        "infos": MessageLookupByLibrary.simpleMessage("Informations"),
        "event": MessageLookupByLibrary.simpleMessage("Événement "),
        "cov": MessageLookupByLibrary.simpleMessage("Covoiturages "),
        "int": MessageLookupByLibrary.simpleMessage("Intéressé "),
        "annuler": MessageLookupByLibrary.simpleMessage("Annuler "),
        "num_tel": MessageLookupByLibrary.simpleMessage("Numéro de téléphone"),
        "km": MessageLookupByLibrary.simpleMessage("Km(s)"),
        "se_con": MessageLookupByLibrary.simpleMessage("SE CONNECTER "),
        "skip": MessageLookupByLibrary.simpleMessage("PASSER "),
        "inactive": MessageLookupByLibrary.simpleMessage("Inactive "),
        "aucun": MessageLookupByLibrary.simpleMessage("Aucun résultat trouvé"),
        "no_co": MessageLookupByLibrary.simpleMessage(
            "Aucune compétence n'a été mentionnée "),
        "no_obj": MessageLookupByLibrary.simpleMessage(
            " Aucun objectif n'a été mentionné "),
        "params": MessageLookupByLibrary.simpleMessage("Paramètres "),
        "accepter": MessageLookupByLibrary.simpleMessage("ACCEPTER"),
        "enligne": MessageLookupByLibrary.simpleMessage("En ligne "),
        "no_msg": MessageLookupByLibrary.simpleMessage("Aucun message trouvé"),
        "particip": MessageLookupByLibrary.simpleMessage("Participants"),
        "not_int": MessageLookupByLibrary.simpleMessage("Plus intéressé"),
        "je_int": MessageLookupByLibrary.simpleMessage("Je suis intéressé"),
        "je_vis": MessageLookupByLibrary.simpleMessage("Je veux être visible "),
        "linkedin": MessageLookupByLibrary.simpleMessage("Profil linkedin "),
        "insta1": MessageLookupByLibrary.simpleMessage("Profil Instagram "),
        "twitter1": MessageLookupByLibrary.simpleMessage("Profil Twitter "),
        "je_des": MessageLookupByLibrary.simpleMessage(
            "Je veux désactiver mon compte"),
        "je_notif": MessageLookupByLibrary.simpleMessage(
            "Je veux recevoir des notifications"),
        "add_desc":
            MessageLookupByLibrary.simpleMessage("Ajouter une description .."),
        "add_num": MessageLookupByLibrary.simpleMessage(
            "Ajouter votre numéro de téléphone"),
        "accepta": MessageLookupByLibrary.simpleMessage(
            " a accepté votre demande de connexion "),
        "sendi": MessageLookupByLibrary.simpleMessage(
            " vous a envoyé une demande de connexion"),
        "retourner": MessageLookupByLibrary.simpleMessage("RETOURNER "),
        "message": MessageLookupByLibrary.simpleMessage("MESSAGE"),
        "myf": MessageLookupByLibrary.simpleMessage('My favorites'),
        "not": MessageLookupByLibrary.simpleMessage('Notifications'),
        "insta": MessageLookupByLibrary.simpleMessage('Like us on Instagram '),
        "face": MessageLookupByLibrary.simpleMessage('Like us on Facebook'),
        "twitter": MessageLookupByLibrary.simpleMessage('Like us on Twitter '),
        "send": MessageLookupByLibrary.simpleMessage('Send'),
        "last": MessageLookupByLibrary.simpleMessage('Latest additions'),
        "welcome": MessageLookupByLibrary.simpleMessage(
            "Bienvenue sur CCIS Connect"),

        "suc": MessageLookupByLibrary.simpleMessage('Success '),
        "success": MessageLookupByLibrary.simpleMessage(
            'Your message has been sent! '),
        "desc":
            MessageLookupByLibrary.simpleMessage("Please enter a description"),
        "selectp": MessageLookupByLibrary.simpleMessage(
            'Please enter at least one image'),
        "delm": MessageLookupByLibrary.simpleMessage('Delete conversation'),
        "delm": MessageLookupByLibrary.simpleMessage('Delete post'),
        "delpost": MessageLookupByLibrary.simpleMessage(
            'Do you realy want to delete this post ? '),
        "delc": MessageLookupByLibrary.simpleMessage(
            'Do you realy want to delete this conversation ? '),
        "balance":
            MessageLookupByLibrary.simpleMessage("Insufficient balance "),
        "solde": MessageLookupByLibrary.simpleMessage(
            'You must recharge the credit to complete the publication'),
        "confirm_logout": MessageLookupByLibrary.simpleMessage(
            "Are ypu sure you want to logout?"),
        "wrong": MessageLookupByLibrary.simpleMessage('Wrong password'),
        "inbox": MessageLookupByLibrary.simpleMessage("Inbox"),
        "menu": MessageLookupByLibrary.simpleMessage("Menu"),
        "profile": MessageLookupByLibrary.simpleMessage("Profil"),
        "add_pic": MessageLookupByLibrary.simpleMessage("Add picture"),
        "specs": MessageLookupByLibrary.simpleMessage("Specialities"),
        "time": MessageLookupByLibrary.simpleMessage("   Waiting time "),
        "res": MessageLookupByLibrary.simpleMessage("Reservation data file"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "assur": MessageLookupByLibrary.simpleMessage("Enter health insurance"),
        "patient": MessageLookupByLibrary.simpleMessage("Patient name"),
        "mobile": MessageLookupByLibrary.simpleMessage("Mobile number"),
        "animal": MessageLookupByLibrary.simpleMessage("Animals"),
        "date_r": MessageLookupByLibrary.simpleMessage("Reservation date"),
        "ask": MessageLookupByLibrary.simpleMessage('Ask me a quesion'),
        "more": MessageLookupByLibrary.simpleMessage('More'),
        "safe": MessageLookupByLibrary.simpleMessage('Be Healthy'),
        "cat": MessageLookupByLibrary.simpleMessage('Categories'),
        "view": MessageLookupByLibrary.simpleMessage('View all'),
        "hospital": MessageLookupByLibrary.simpleMessage('Hospital'),
        "hospital_n": MessageLookupByLibrary.simpleMessage('Hospital name'),
        "lnge": MessageLookupByLibrary.simpleMessage('English'),
        "no": MessageLookupByLibrary.simpleMessage('No result found'),
        "cancel": MessageLookupByLibrary.simpleMessage('Cancel'),
        "choose_c": MessageLookupByLibrary.simpleMessage('Choose a city'),
        "choose_q": MessageLookupByLibrary.simpleMessage('neighbourhood'),
        "add_n": MessageLookupByLibrary.simpleMessage('Please enter the title'),
        "name_n":
            MessageLookupByLibrary.simpleMessage('Please enter your name'),
        "phone_n": MessageLookupByLibrary.simpleMessage(
            'Please enter you phone number'),
        "alpha_n": MessageLookupByLibrary.simpleMessage(
            'Please enter only alphabetical characters.'),
        "pass_n": MessageLookupByLibrary.simpleMessage(
            'Password must be upto 6 characters'),
        "fix": MessageLookupByLibrary.simpleMessage(
            "Veuillez corriger les erreurs en rouge"),
        "pass_nn":
            MessageLookupByLibrary.simpleMessage('Please enter a password'),
        "pass_dn":
            MessageLookupByLibrary.simpleMessage('The passwords don\'t match'),
        "email_isn": MessageLookupByLibrary.simpleMessage('Email is not valid'),
        "email_n": MessageLookupByLibrary.simpleMessage(
            'Please enter your Email address'),
        "noin": MessageLookupByLibrary.simpleMessage('No internet connexion'),
        "error": MessageLookupByLibrary.simpleMessage('Error from the server'),
        "not_r": MessageLookupByLibrary.simpleMessage(
            'this account is not registerd'),
        "exist": MessageLookupByLibrary.simpleMessage(
            'This account already existed'),
        "invalid":
            MessageLookupByLibrary.simpleMessage('Invalid Phone or Password'),
        "load": MessageLookupByLibrary.simpleMessage('Loading'),
        "co": MessageLookupByLibrary.simpleMessage('MON COMPTE'),
        "del": MessageLookupByLibrary.simpleMessage('Deleted from favorite'),
        "only": MessageLookupByLibrary.simpleMessage(
            'Only registred users have access to the reservation list'),
        "onlyf": MessageLookupByLibrary.simpleMessage(
            'Only registred users have access to the favorite list'),
        "dte":
            MessageLookupByLibrary.simpleMessage('Choose the reservation date'),
        "insu": MessageLookupByLibrary.simpleMessage(
            'Please Enter the health insurance'),
        "take": MessageLookupByLibrary.simpleMessage('Take a picture'),
        "upload":
            MessageLookupByLibrary.simpleMessage('Upload picture from gallery'),
        "en_com_no": MessageLookupByLibrary.simpleMessage(
            'Please enter your Commercial Registration No'),
        "level": MessageLookupByLibrary.simpleMessage('Level'),
        "fill": MessageLookupByLibrary.simpleMessage('Please fill this field'),
        "exit": MessageLookupByLibrary.simpleMessage('Exit'),
        "exit_a": MessageLookupByLibrary.simpleMessage(
            'Do you Really want to exit Kwtpet'),
        "cancel_a": MessageLookupByLibrary.simpleMessage('Cancel'),
        "t2": MessageLookupByLibrary.simpleMessage(
            "Créez votre compte en quelques clics "),
        "t4": MessageLookupByLibrary.simpleMessage(
            "L'avenir se lit sur nos lignes "),
        "t5": MessageLookupByLibrary.simpleMessage(
            "Merci pour votre fidélité, L'Oncf vous souhaite une excellente navigation "),
        "t3": MessageLookupByLibrary.simpleMessage(
            "Scannez votre CIN pour un maximum de confort \nPayez en ligne ou à la gare de votre choix\nBénéficiez immédiatement de votre carte d’abonnement dématérialisée"),
        "start": MessageLookupByLibrary.simpleMessage('DÉMARRER'),
        "ads": MessageLookupByLibrary.simpleMessage('Sponsored ads'),
        "subm": MessageLookupByLibrary.simpleMessage('Submission'),
        "sub":
            MessageLookupByLibrary.simpleMessage('By signing up you agree to'),
        "privacy": MessageLookupByLibrary.simpleMessage(
            'POLITIQUE DE CONFIDENTIALITÉ'),
        "terms":
            MessageLookupByLibrary.simpleMessage("CONDITIONS D'UTILISATION"),
        "and": MessageLookupByLibrary.simpleMessage("and"),
        "iss":
            MessageLookupByLibrary.simpleMessage(' Already have an account? '),
        "th": MessageLookupByLibrary.simpleMessage(
            "PARTAGER L'APP AVEC VOS CONTACTS"),
        "addpet": MessageLookupByLibrary.simpleMessage(
            'Your pet has been successfully added'),
        "view": MessageLookupByLibrary.simpleMessage('View your submission'),
        "choose": MessageLookupByLibrary.simpleMessage('SELECT A CATEGORY '),
        "pl": MessageLookupByLibrary.simpleMessage(
            'Please register to be able to use this feature'),
        "Address": MessageLookupByLibrary.simpleMessage("Title"),
        "description": MessageLookupByLibrary.simpleMessage("description"),
        "ev": MessageLookupByLibrary.simpleMessage("ÉVALUER L'APPLICATION"),
        "ver": MessageLookupByLibrary.simpleMessage(
            "VÉRIFIER LA MISE À JOUR DE L'APP"),
      };
}

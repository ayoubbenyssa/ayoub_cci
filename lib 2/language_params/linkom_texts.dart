import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mycgem/i18/ar_en.dart';

class LinkomTexts {
  LinkomTexts(Locale locale) : _localeName = locale.toString();

  final String _localeName;

  static Future<LinkomTexts> load(Locale locale) {
    return initializeMessages(locale.toString()).then((v) {
      return new LinkomTexts(locale);
    });
  }

  static LinkomTexts of(BuildContext context) {
    return Localizations.of<LinkomTexts>(context, LinkomTexts);
  }

  String priv() => Intl.message(
    ' ',
    name: 'priv',
    desc: '',
    locale: _localeName,
  );

  String group() => Intl.message(
    ' ',
    name: 'group',
    desc: '',
    locale: _localeName,
  );
  String login_google() => Intl.message(
        '',
        name: 'login_google',
        desc: '',
        locale: _localeName,
      );

  String lresp() => Intl.message(
        '',
        name: 'lresp',
        desc: '',
        locale: _localeName,
      );

  String dem() => Intl.message(
        '',
        name: 'dem',
        desc: '',
        locale: _localeName,
      );

  String no_not() => Intl.message(
        '',
        name: 'no_not',
        desc: '',
        locale: _localeName,
      );

  String search_r() => Intl.message(
        '',
        name: 'search_r',
        desc: '',
        locale: _localeName,
      );

  String no_mess() => Intl.message(
        '',
        name: 'no_mess',
        desc: '',
        locale: _localeName,
      );

  String block() => Intl.message(
        '',
        name: 'block',
        desc: '',
        locale: _localeName,
      );

  String activate() => Intl.message(
        '',
        name: 'activate',
        desc: '',
        locale: _localeName,
      );

  String disa() => Intl.message(
        '',
        name: 'disa',
        desc: '',
        locale: _localeName,
      );

  String contact() => Intl.message(
        '',
        name: 'contact',
        desc: '',
        locale: _localeName,
      );

  String valid() => Intl.message(
    '',
    name: 'valid',
    desc: '',
    locale: _localeName,
  );

  String caut() => Intl.message(
    '',
    name: 'caut',
    desc: '',
    locale: _localeName,
  );

  String budget() => Intl.message(
    '',
    name: 'budget',
    desc: '',
    locale: _localeName,
  );


  String cent() => Intl.message(
        '',
        name: 'cent',
        desc: '',
        locale: _localeName,
      );

  String typ() => Intl.message(
    '',
    name: 'typ',
    desc: '',
    locale: _localeName,
  );

  String sui_ent() => Intl.message(
    '',
    name: 'sui_ent',
    desc: '',
    locale: _localeName,
  );


  String aucun_g() => Intl.message(
        '',
        name: 'aucun_g',
        desc: '',
        locale: _localeName,
      );

  String continu() => Intl.message(
        '',
        name: 'continue',
        desc: '',
        locale: _localeName,
      );

  String g_n() => Intl.message(
        '',
        name: 'g_n',
        desc: '',
        locale: _localeName,
      );

  String len() => Intl.message(
        '',
        name: 'len',
        desc: '',
        locale: _localeName,
      );

  String resps() => Intl.message(
        '',
        name: 'resps',
        desc: '',
        locale: _localeName,
      );

  String sve() => Intl.message(
        '',
        name: 'sve',
        desc: '',
        locale: _localeName,
      );

  String ve_e() => Intl.message(
        '',
        name: 've_e',
        desc: '',
        locale: _localeName,
      );

  String g_r() => Intl.message(
        '',
        name: 'g_r',
        desc: '',
        locale: _localeName,
      );

  String searchc() => Intl.message(
        '',
        name: 'searchc',
        desc: '',
        locale: _localeName,
      );

  String rej_c() => Intl.message(
        '',
        name: 'rej_c',
        desc: '',
        locale: _localeName,
      );

  String sector() => Intl.message(
        '',
        name: 'sector',
        desc: '',
        locale: _localeName,
      );

  String here() => Intl.message(
        '',
        name: 'here',
        desc: '',
        locale: _localeName,
      );

  String rej_f() => Intl.message(
        '',
        name: 'rej_f',
        desc: '',
        locale: _localeName,
      );

  String ben() => Intl.message(
        '',
        name: 'bén',
        desc: '',
        locale: _localeName,
      );

  String option() => Intl.message(
        '',
        name: 'option',
        desc: '',
        locale: _localeName,
      );

  String fed() => Intl.message(
        '',
        name: 'fed',
        desc: '',
        locale: _localeName,
      );

  String prodss() => Intl.message(
        '',
        name: 'prodss',
        desc: '',
        locale: _localeName,
      );

  String commission() => Intl.message(
        '',
        name: 'commission',
        desc: '',
        locale: _localeName,
      );

  String ava() => Intl.message(
        '',
        name: 'ava',
        desc: '',
        locale: _localeName,
      );

  String CGEM() => Intl.message(
        '',
        name: 'CGEM',
        desc: '',
        locale: _localeName,
      );

  String oppo() => Intl.message(
        '',
        name: 'oppo',
        desc: '',
        locale: _localeName,
      );

  String actu() => Intl.message(
        '',
        name: 'actu',
        desc: '',
        locale: _localeName,
      );

  String filtrer() => Intl.message(
        '',
        name: 'filtrer',
        desc: '',
        locale: _localeName,
      );

  String login_facebook() => Intl.message(
        '',
        name: 'login_facebook',
        desc: '',
        locale: _localeName,
      );

  String details() => Intl.message(
        '',
        name: 'details',
        desc: '',
        locale: _localeName,
      );

  String no_co() => Intl.message(
        '',
        name: 'no_co',
        desc: '',
        locale: _localeName,
      );

  String linkedin() => Intl.message(
        '',
        name: 'linkedin',
        desc: '',
        locale: _localeName,
      );

  String insta() => Intl.message(
        '',
        name: 'insta',
        desc: '',
        locale: _localeName,
      );

  String twitter() => Intl.message(
        '',
        name: 'twitter',
        desc: '',
        locale: _localeName,
      );

  String add_desc() => Intl.message(
        '',
        name: 'add_desc',
        desc: '',
        locale: _localeName,
      );

  String je_notif() => Intl.message(
        '',
        name: 'je_notif',
        desc: '',
        locale: _localeName,
      );

  String online() => Intl.message(
        '',
        name: 'online',
        desc: '',
        locale: _localeName,
      );

  String loc_v() => Intl.message(
        '',
        name: 'loc_v',
        desc: '',
        locale: _localeName,
      );

  String poli() => Intl.message(
        '',
        name: 'poli',
        desc: '',
        locale: _localeName,
      );

  String je_des() => Intl.message(
        '',
        name: 'je_des',
        desc: '',
        locale: _localeName,
      );

  String je_vis() => Intl.message(
        '',
        name: 'je_vis',
        desc: '',
        locale: _localeName,
      );

  String params() => Intl.message(
        '',
        name: 'params',
        desc: '',
        locale: _localeName,
      );

  String no_obj() => Intl.message(
        '',
        name: 'no_obj',
        desc: '',
        locale: _localeName,
      );

  String login() => Intl.message(
        '',
        name: 'login',
        desc: '',
        locale: _localeName,
      );

  String proff() => Intl.message(
        '',
        name: 'proff',
        desc: '',
        locale: _localeName,
      );

  String conv() => Intl.message(
        '',
        name: 'conv',
        desc: '',
        locale: _localeName,
      );

  String publi() => Intl.message(
        '',
        name: 'publi',
        desc: '',
        locale: _localeName,
      );

  String po() => Intl.message(
        '',
        name: 'po',
        desc: '',
        locale: _localeName,
      );

  String invite() => Intl.message(
        '',
        name: 'invite',
        desc: '',
        locale: _localeName,
      );

  String ann() => Intl.message(
        '',
        name: 'ann',
        desc: '',
        locale: _localeName,
      );

  String cartem() => Intl.message(
        '',
        name: 'cartem',
        desc: '',
        locale: _localeName,
      );

  String casc() => Intl.message(
        '',
        name: 'casc',
        desc: '',
        locale: _localeName,
      );

  String btk() => Intl.message(
        '',
        name: 'btk',
        desc: '',
        locale: _localeName,
      );

  String forms() => Intl.message(
        '',
        name: 'forms',
        desc: '',
        locale: _localeName,
      );

  String agenda() => Intl.message(
        '',
        name: 'agenda',
        desc: '',
        locale: _localeName,
      );

  String biblio() => Intl.message(
        '',
        name: 'biblio',
        desc: '',
        locale: _localeName,
      );

  String organisme() => Intl.message(
        '',
        name: 'organisme',
        desc: '',
        locale: _localeName,
      );

  String pre() => Intl.message(
        '',
        name: 'pre',
        desc: '',
        locale: _localeName,
      );

  String ent_mail() => Intl.message(
        '',
        name: 'ent_mail',
        desc: '',
        locale: _localeName,
      );

  String email_not() => Intl.message(
        '',
        name: 'email_not',
        desc: '',
        locale: _localeName,
      );

  String mot_n() => Intl.message(
        '',
        name: 'mot_n',
        desc: '',
        locale: _localeName,
      );

  String notm() => Intl.message(
        '',
        name: 'notm',
        desc: '',
        locale: _localeName,
      );

  String welcome() => Intl.message(
        'welcome',
        name: 'welcome',
        desc: '',
        locale: _localeName,
      );

  String t1() => Intl.message(
        't1',
        name: 't1',
        desc: '',
        locale: _localeName,
      );

  String sub() => Intl.message(
        'sub',
        name: 'sub',
        desc: '',
        locale: _localeName,
      );

  String by() => Intl.message(
        '',
        name: 'sub',
        desc: '',
        locale: _localeName,
      );

  String chat() => Intl.message(
        '',
        name: 'chat',
        desc: '',
        locale: _localeName,
      );

  String terms() => Intl.message(
        '',
        name: 'terms',
        desc: '',
        locale: _localeName,
      );

  String subm() => Intl.message(
        '',
        name: 'subm',
        desc: '',
        locale: _localeName,
      );

  String th() => Intl.message(
        '',
        name: 'th',
        desc: '',
        locale: _localeName,
      );

  String view() => Intl.message(
        '',
        name: 'view',
        desc: '',
        locale: _localeName,
      );

  String search_opp() => Intl.message(
        '',
        name: 'search_opp',
        desc: '',
        locale: _localeName,
      );

  String sui() => Intl.message(
        '',
        name: 'sui',
        desc: '',
        locale: _localeName,
      );

  String suivi() => Intl.message(
        '',
        name: 'suivi',
        desc: '',
        locale: _localeName,
      );

  String mone() => Intl.message(
        '',
        name: 'mone',
        desc: '',
        locale: _localeName,
      );

  String type_opp() => Intl.message(
        '',
        name: 'type_opp',
        desc: '',
        locale: _localeName,
      );

  String ccom() => Intl.message(
        '',
        name: 'ccom',
        desc: '',
        locale: _localeName,
      );

  String cfed() => Intl.message(
        '',
        name: 'cfed',
        desc: '',
        locale: _localeName,
      );

  String entrep() => Intl.message(
        '',
        name: 'entrep',
        desc: '',
        locale: _localeName,
      );

  String tarifs() => Intl.message(
        '',
        name: 'tarifs',
        desc: '',
        locale: _localeName,
      );

  String fids() => Intl.message(
        '',
        name: 'fids',
        desc: '',
        locale: _localeName,
      );

  String comms() => Intl.message(
        '',
        name: 'comms',
        desc: '',
        locale: _localeName,
      );

  String services() => Intl.message(
        '',
        name: 'services',
        desc: '',
        locale: _localeName,
      );

  String pres() => Intl.message(
        '',
        name: 'pres',
        desc: '',
        locale: _localeName,
      );

  String vids() => Intl.message(
        '',
        name: 'vids',
        desc: '',
        locale: _localeName,
      );

  /*
  submedit": MessageLookupByLibrary.simpleMessage('EDIT YOUR PROFILE'),

        "editprof": MessageLookupByLibrary.simpleMessage("UPDATE"),
        "mypets": MessageLookupByLibrary.simpleMessage(" MY PETS"),
   */

  String submedit() => Intl.message(
        '',
        name: 'submedit',
        desc: '',
        locale: _localeName,
      );

  String editprof() => Intl.message(
        '',
        name: 'editprof',
        desc: '',
        locale: _localeName,
      );

  String mypets() => Intl.message(
        '',
        name: 'mypets',
        desc: '',
        locale: _localeName,
      );

  String addpet() => Intl.message(
        '',
        name: 'addpet',
        desc: '',
        locale: _localeName,
      );

  String and() => Intl.message(
        '',
        name: 'and',
        desc: '',
        locale: _localeName,
      );

  String iss() => Intl.message(
        '',
        name: 'iss',
        desc: '',
        locale: _localeName,
      );

  String privacy() => Intl.message(
        '',
        name: 'privacy',
        desc: '',
        locale: _localeName,
      );

  String ads() => Intl.message(
        '',
        name: 'ads',
        desc: '',
        locale: _localeName,
      );

  String pl() => Intl.message(
        '',
        name: 'pl',
        desc: '',
        locale: _localeName,
      );

  String description() => Intl.message(
        '',
        name: 'description',
        desc: '',
        locale: _localeName,
      );

  String selectp() => Intl.message(
        '',
        name: 'selectp',
        desc: '',
        locale: _localeName,
      );

  String delc() => Intl.message(
        '',
        name: 'delc',
        desc: '',
        locale: _localeName,
      );

  String members() => Intl.message(
        '',
        name: 'members',
        desc: '',
        locale: _localeName,
      );

  String edit() => Intl.message(
        '',
        name: 'edit',
        desc: '',
        locale: _localeName,
      );

  String editp() => Intl.message(
        '',
        name: 'editp',
        desc: '',
        locale: _localeName,
      );

  String chatg() => Intl.message(
        '',
        name: 'chatg',
        desc: '',
        locale: _localeName,
      );

  String chatb() => Intl.message(
        '',
        name: 'chatb',
        desc: '',
        locale: _localeName,
      );

  String change() => Intl.message(
        '',
        name: 'change',
        desc: '',
        locale: _localeName,
      );

  String alllist() => Intl.message(
        '',
        name: 'alllist',
        desc: '',
        locale: _localeName,
      );

  String delm() => Intl.message(
        '',
        name: 'delm',
        desc: '',
        locale: _localeName,
      );

  String no_msg() => Intl.message(
        '',
        name: 'no_msg',
        desc: '',
        locale: _localeName,
      );

  String enligne() => Intl.message(
        '',
        name: 'enligne',
        desc: '',
        locale: _localeName,
      );

  String delpost() => Intl.message(
        '',
        name: 'delpost',
        desc: '',
        locale: _localeName,
      );

  String delp() => Intl.message(
        '',
        name: 'delp',
        desc: '',
        locale: _localeName,
      );

  String wrong() => Intl.message(
        '',
        name: 'wrong',
        desc: '',
        locale: _localeName,
      );

  String balance() => Intl.message(
        '',
        name: 'balance',
        desc: '',
        locale: _localeName,
      );

  String confirm_logout() => Intl.message(
        '',
        name: 'confirm_logout',
        desc: '',
        locale: _localeName,
      );

  String solde() => Intl.message(
        '',
        name: 'solde',
        desc: '',
        locale: _localeName,
      );

  String desc() => Intl.message(
        '',
        name: 'desc',
        desc: '',
        locale: _localeName,
      );

  //

  String breed() => Intl.message(
        '',
        name: 'breed',
        desc: '',
        locale: _localeName,
      );

  String Address() => Intl.message(
        '',
        name: 'pl',
        desc: '',
        locale: _localeName,
      );

  String center() => Intl.message(
        '',
        name: 'center',
        desc: '',
        locale: _localeName,
      );

  String ma_d() => Intl.message(
        '',
        name: 'ma_d',
        desc: '',
        locale: _localeName,
      );

  String votre() => Intl.message(
        '',
        name: 'votre',
        desc: '',
        locale: _localeName,
      );

  String nom() => Intl.message(
        '',
        name: 'nom',
        desc: '',
        locale: _localeName,
      );

  String bienvenue() => Intl.message(
        '',
        name: 'bienvenue',
        desc: '',
        locale: _localeName,
      );

  String prof() => Intl.message(
        '',
        name: 'prof',
        desc: '',
        locale: _localeName,
      );

  String nat() => Intl.message(
        '',
        name: 'nat',
        desc: '',
        locale: _localeName,
      );

  String adrv() => Intl.message(
        '',
        name: 'adrv',
        desc: '',
        locale: _localeName,
      );

  String infos() => Intl.message(
        '',
        name: 'infos',
        desc: '',
        locale: _localeName,
      );

  String daten() => Intl.message(
        '',
        name: 'daten',
        desc: '',
        locale: _localeName,
      );

  String port() => Intl.message(
        '',
        name: 'port',
        desc: '',
        locale: _localeName,
      );

  String fixe() => Intl.message(
        '',
        name: 'fixe',
        desc: '',
        locale: _localeName,
      );

  String pr() => Intl.message(
        '',
        name: 'pr',
        desc: '',
        locale: _localeName,
      );

  String client() => Intl.message(
        '',
        name: 'client',
        desc: '',
        locale: _localeName,
      );

  String pa() => Intl.message(
        '',
        name: 'pa',
        desc: '',
        locale: _localeName,
      );

  String compte() => Intl.message(
        '',
        name: 'compte',
        desc: '',
        locale: _localeName,
      );

  String rec() => Intl.message(
        '',
        name: 'rec',
        desc: '',
        locale: _localeName,
      );

  String carte() => Intl.message(
        '',
        name: 'carte',
        desc: '',
        locale: _localeName,
      );

  String ab() => Intl.message(
        '',
        name: 'ab',
        desc: '',
        locale: _localeName,
      );

  String ma_a() => Intl.message(
        '',
        name: 'ma_a',
        desc: '',
        locale: _localeName,
      );

  String dte_v() => Intl.message(
        '',
        name: 'dte_v',
        desc: '',
        locale: _localeName,
      );

  String dur() => Intl.message(
        '',
        name: 'dur',
        desc: '',
        locale: _localeName,
      );

  String classe() => Intl.message(
        '',
        name: 'classe',
        desc: '',
        locale: _localeName,
      );

  String montr() => Intl.message(
        '',
        name: 'montr',
        desc: '',
        locale: _localeName,
      );

  String center_rec() => Intl.message(
        '',
        name: 'center_rec',
        desc: '',
        locale: _localeName,
      );

  String ver() => Intl.message(
        '',
        name: 'ver',
        desc: '',
        locale: _localeName,
      );

  String macc() => Intl.message(
        '',
        name: 'macc',
        desc: '',
        locale: _localeName,
      );

  String typed() => Intl.message(
        '',
        name: 'typed',
        desc: '',
        locale: _localeName,
      );

  String tut() => Intl.message(
        '',
        name: 'tut',
        desc: '',
        locale: _localeName,
      );

  String mac() => Intl.message(
        '',
        name: 'mac',
        desc: '',
        locale: _localeName,
      );

  String ev() => Intl.message(
        '',
        name: 'ev',
        desc: '',
        locale: _localeName,
      );

  String del() => Intl.message(
        'Deleted from favorite',
        name: 'del',
        desc: '',
        locale: _localeName,
      );

  String phone() => Intl.message(
        'Phone number',
        name: 'phone',
        desc: '',
        locale: _localeName,
      );

  String error() => Intl.message(
        'Error from  the server',
        name: 'error',
        desc: '',
        locale: _localeName,
      );

  String not_r() => Intl.message(
        'this account is not registerd',
        name: 'not_r',
        desc: '',
        locale: _localeName,
      );

  String invalid() => Intl.message(
        'Invalid Phone or Password',
        name: 'invalid',
        desc: '',
        locale: _localeName,
      );

  String exist() => Intl.message(
        'this account already existed',
        name: 'exist',
        desc: '',
        locale: _localeName,
      );

  String phone_n() => Intl.message(
        'Please enter your Phone number',
        name: 'phone_n',
        desc: '',
        locale: _localeName,
      );

  String password() => Intl.message(
        'Password',
        name: 'password',
        desc: '',
        locale: _localeName,
      );

  String pass_n() => Intl.message(
        'Password must be upto 6 characters',
        name: 'pass_n',
        desc: '',
        locale: _localeName,
      );

  String alpha_n() => Intl.message(
        'Please enter only alphabetical characters.',
        name: 'alpha_n',
        desc: '',
        locale: _localeName,
      );

  String register_new() => Intl.message(
        'Register',
        name: 'register_new',
        desc: '',
        locale: _localeName,
      );

  String add_n() => Intl.message(
        'Please enter your address',
        name: 'add_n',
        desc: '',
        locale: _localeName,
      );

  String name_n() => Intl.message(
        'Please enter your name',
        name: 'name_n',
        desc: '',
        locale: _localeName,
      );

  String forgot_pass() => Intl.message(
        'Forgot password',
        name: 'forget_pass',
        desc: '',
        locale: _localeName,
      );

  String register() => Intl.message(
        'Register',
        name: 'register',
        desc: '',
        locale: _localeName,
      );

  String fullname() => Intl.message(
        'Username',
        name: 'fullname',
        desc: '',
        locale: _localeName,
      );

  String confirm_password() => Intl.message(
        'Confirm password',
        name: 'confirm_password',
        desc: '',
        locale: _localeName,
      );

  String email() => Intl.message(
        'Email',
        name: 'email',
        desc: '',
        locale: _localeName,
      );

  String nv() => Intl.message(
        '',
        name: 'nv',
        desc: '',
        locale: _localeName,
      );

  String vis() => Intl.message(
        '',
        name: 'vis',
        desc: '',
        locale: _localeName,
      );

  String co() => Intl.message(
        '',
        name: 'co',
        desc: '',
        locale: _localeName,
      );

  String address() => Intl.message(
        'Address',
        name: 'address',
        desc: '',
        locale: _localeName,
      );

  String registerr() => Intl.message(
        'Login',
        name: 'registerr',
        desc: '',
        locale: _localeName,
      );

  String loadi() => Intl.message(
        'Loading',
        name: 'load',
        desc: '',
        locale: _localeName,
      );

  String send_pass() => Intl.message(
        'Send password',
        name: 'send_pass',
        desc: '',
        locale: _localeName,
      );

  String language() => Intl.message(
        'Language',
        name: 'language',
        desc: '',
        locale: _localeName,
      );

  String contact_us() => Intl.message(
        'Contact us',
        name: 'contact_us',
        desc: '',
        locale: _localeName,
      );

  String mylist() => Intl.message(
        ' ',
        name: 'mylist',
        desc: '',
        locale: _localeName,
      );

  String pay() => Intl.message(
        ' ',
        name: 'pay',
        desc: '',
        locale: _localeName,
      );

  String myp() => Intl.message(
        ' ',
        name: 'myp',
        desc: '',
        locale: _localeName,
      );

  String not() => Intl.message(
        ' ',
        name: 'not',
        desc: '',
        locale: _localeName,
      );

  String face() => Intl.message(
        ' ',
        name: 'face',
        desc: '',
        locale: _localeName,
      );

  String send() => Intl.message(
        ' ',
        name: 'send',
        desc: '',
        locale: _localeName,
      );

  String insta1() => Intl.message(
        ' ',
        name: 'insta1',
        desc: '',
        locale: _localeName,
      );

  String accepta() => Intl.message(
        ' ',
        name: 'accepta',
        desc: '',
        locale: _localeName,
      );

  String accepter() => Intl.message(
        ' ',
        name: 'accepter',
        desc: '',
        locale: _localeName,
      );

  String message() => Intl.message(
        ' ',
        name: 'message',
        desc: '',
        locale: _localeName,
      );

  String retourner() => Intl.message(
        ' ',
        name: 'retourner',
        desc: '',
        locale: _localeName,
      );

  String sendi() => Intl.message(
        ' ',
        name: 'sendi',
        desc: '',
        locale: _localeName,
      );

  String add_num() => Intl.message(
        ' ',
        name: 'add_num',
        desc: '',
        locale: _localeName,
      );

  String twitter1() => Intl.message(
        ' ',
        name: 'twitter1',
        desc: '',
        locale: _localeName,
      );

  String myf() => Intl.message(
        ' ',
        name: 'myf',
        desc: '',
        locale: _localeName,
      );

  String lnge() => Intl.message(
        'ENGLISH',
        name: 'lnge',
        desc: '',
        locale: _localeName,
      );

  String join_us() => Intl.message(
        'Join us',
        name: 'join_us',
        desc: '',
        locale: _localeName,
      );

  String onlyf() => Intl.message(
        'Only registred users have access to the favorite list',
        name: 'onlyf',
        desc: '',
        locale: _localeName,
      );

  String only() => Intl.message(
        'Only registred users have access to the reservation list',
        name: 'only',
        desc: '',
        locale: _localeName,
      );

  String about() => Intl.message(
        'About',
        name: 'about',
        desc: '',
        locale: _localeName,
      );

  String home() => Intl.message(
        '',
        name: 'home',
        desc: '',
        locale: _localeName,
      );

  String suc() => Intl.message(
        '',
        name: 'suc',
        desc: '',
        locale: _localeName,
      );

  String success() => Intl.message(
        '',
        name: 'success',
        desc: '',
        locale: _localeName,
      );

  String mess() => Intl.message(
        '',
        name: 'mess',
        desc: '',
        locale: _localeName,
      );

  String since() => Intl.message(
        '',
        name: 'since',
        desc: '',
        locale: _localeName,
      );

  String profile() => Intl.message(
        '',
        name: 'profile',
        desc: '',
        locale: _localeName,
      );

  String cat() => Intl.message(
        '',
        name: 'cat',
        desc: '',
        locale: _localeName,
      );

  String last() => Intl.message(
        '',
        name: 'last',
        desc: '',
        locale: _localeName,
      );

  String more() => Intl.message(
        '',
        name: 'more',
        desc: '',
        locale: _localeName,
      );

  String vieww() => Intl.message(
        '',
        name: 'view',
        desc: '',
        locale: _localeName,
      );

  String choose() => Intl.message(
        '',
        name: 'choose',
        desc: '',
        locale: _localeName,
      );

  String menu() => Intl.message(
        '',
        name: 'menu',
        desc: '',
        locale: _localeName,
      );

  String inbox() => Intl.message(
        '',
        name: 'inbox',
        desc: '',
        locale: _localeName,
      );

  String agree() => Intl.message(
        '',
        name: 'agree',
        desc: '',
        locale: _localeName,
      );

  String upload() => Intl.message(
        'Upload picture from gallery',
        name: 'upload',
        desc: '',
        locale: _localeName,
      );

  String take() => Intl.message(
        'take',
        name: 'take',
        desc: '',
        locale: _localeName,
      );

  String insu() => Intl.message(
        'Please Enter the health insurance',
        name: 'insu',
        desc: '',
        locale: _localeName,
      );

  String dte() => Intl.message(
        'Choose the reservation date',
        name: 'dte',
        desc: '',
        locale: _localeName,
      );

  String condit() => Intl.message(
        'Conditions and terms',
        name: 'condit',
        desc: '',
        locale: _localeName,
      );

  String logout() => Intl.message(
        'Logout',
        name: 'logout',
        desc: '',
        locale: _localeName,
      );

  String confirm() => Intl.message(
        'Confirm',
        name: 'confirm',
        desc: '',
        locale: _localeName,
      );

  String start() => Intl.message(
        'GET STARTED',
        name: 'start',
        desc: '',
        locale: _localeName,
      );

  String skip() => Intl.message(
        'Skip',
        name: 'skip',
        desc: '',
        locale: _localeName,
      );

  String t4() => Intl.message(
        '',
        name: 't4',
        desc: '',
        locale: _localeName,
      );

  String title() => Intl.message(
        '',
        name: 'title',
        desc: '',
        locale: _localeName,
      );

  String t5() => Intl.message(
        '',
        name: 't5',
        desc: '',
        locale: _localeName,
      );

  String mesc() => Intl.message(
        '',
        name: 'mesc',
        desc: '',
        locale: _localeName,
      );

  String t2() => Intl.message(
        '',
        name: 't2',
        desc: '',
        locale: _localeName,
      );

  String t3() => Intl.message(
        '',
        name: 't3',
        desc: '',
        locale: _localeName,
      );

  String com_no() => Intl.message(
        'Commercial Registration No',
        name: 'com_number',
        desc: '',
        locale: _localeName,
      );

  String en_com_no() => Intl.message(
        'Please enter your Commercial Registration No',
        name: 'en_com_no',
        desc: '',
        locale: _localeName,
      );

  String fill() => Intl.message(
        'Please fill this field',
        name: 'fill',
        desc: '',
        locale: _localeName,
      );

  String level() => Intl.message(
        'Level',
        name: 'level',
        desc: '',
        locale: _localeName,
      );

  String exit() => Intl.message(
        'Exit',
        name: 'exit',
        desc: '',
        locale: _localeName,
      );

  String exit_a() => Intl.message(
        'Do you Really want to exit Kwtpet',
        name: 'exit_a',
        desc: '',
        locale: _localeName,
      );

  String hospital_n() => Intl.message(
        'Hospital name',
        name: 'hospital_n',
        desc: '',
        locale: _localeName,
      );

  String spec() => Intl.message(
        'Speciality',
        name: 'spec',
        desc: '',
        locale: _localeName,
      );

  String w_time() => Intl.message(
        'Waiting time',
        name: 'w_time',
        desc: '',
        locale: _localeName,
      );

  String price() => Intl.message(
        'Price',
        name: 'price',
        desc: '',
        locale: _localeName,
      );

  String add_pic() => Intl.message(
        'Add picture',
        name: 'add_pic',
        desc: '',
        locale: _localeName,
      );

  String specs() => Intl.message(
        'Specialities',
        name: 'specs',
        desc: '',
        locale: _localeName,
      );

  String time() => Intl.message(
        'Waiting time',
        name: 'time',
        desc: '',
        locale: _localeName,
      );

  String res() => Intl.message(
        'Reservation data file',
        name: 'res',
        desc: '',
        locale: _localeName,
      );

  String save() => Intl.message(
        'Save',
        name: 'save',
        desc: '',
        locale: _localeName,
      );

  String assur() => Intl.message(
        'Enter health insurance',
        name: 'assur',
        desc: '',
        locale: _localeName,
      );

  String patient() => Intl.message(
        'Patient name',
        name: 'patient',
        desc: '',
        locale: _localeName,
      );

  String mobile() => Intl.message(
        'Mobile number',
        name: 'mobile',
        desc: '',
        locale: _localeName,
      );

  String assur_a() => Intl.message(
        'Health insurence',
        name: 'assur_a',
        desc: '',
        locale: _localeName,
      );

  String cov() => Intl.message(
        '',
        name: 'cov',
        desc: '',
        locale: _localeName,
      );

  String typeb() => Intl.message(
        ' ',
        name: 'typeb',
        desc: '',
        locale: _localeName,
      );

  String se_con() => Intl.message(
        '',
        name: 'se_con',
        desc: '',
        locale: _localeName,
      );

  String aucun() => Intl.message(
        '',
        name: 'aucun',
        desc: '',
        locale: _localeName,
      );

  String inactive() => Intl.message(
        '',
        name: 'inactive',
        desc: '',
        locale: _localeName,
      );

  String passer() => Intl.message(
        '',
        name: 'skip',
        desc: '',
        locale: _localeName,
      );

  String not_int() => Intl.message(
        '',
        name: 'not_int',
        desc: '',
        locale: _localeName,
      );

  String km() => Intl.message(
        '',
        name: 'km',
        desc: '',
        locale: _localeName,
      );

  String num_tel() => Intl.message(
        '',
        name: 'num_tel',
        desc: '',
        locale: _localeName,
      );

  String annuler() => Intl.message(
        '',
        name: 'annuler',
        desc: '',
        locale: _localeName,
      );

  String je_int() => Intl.message(
        '',
        name: 'je_int',
        desc: '',
        locale: _localeName,
      );

  String particip() => Intl.message(
        ' ',
        name: 'particip',
        desc: '',
        locale: _localeName,
      );

  String int() => Intl.message(
        ' ',
        name: 'int',
        desc: '',
        locale: _localeName,
      );

  String event() => Intl.message(
        ' ',
        name: 'event',
        desc: '',
        locale: _localeName,
      );

  String offe() => Intl.message(
        ' ',
        name: 'offe',
        desc: '',
        locale: _localeName,
      );

  String objs() => Intl.message(
        ' ',
        name: 'objs',
        desc: '',
        locale: _localeName,
      );

  String compe() => Intl.message(
        ' ',
        name: 'compe',
        desc: '',
        locale: _localeName,
      );

  String sond() => Intl.message(
        ' ',
        name: 'sond',
        desc: '',
        locale: _localeName,
      );

  String pers() => Intl.message(
        ' ',
        name: 'pers',
        desc: '',
        locale: _localeName,
      );

  String fils() => Intl.message(
        ' ',
        name: 'fils',
        desc: '',
        locale: _localeName,
      );

  String tous() => Intl.message(
        ' ',
        name: 'tous',
        desc: '',
        locale: _localeName,
      );

  String partn() => Intl.message(
        ' ',
        name: 'partn',
        desc: '',
        locale: _localeName,
      );

  String messg() => Intl.message(
        ' ',
        name: 'messg',
        desc: '',
        locale: _localeName,
      );

  String netw() => Intl.message(
        ' ',
        name: 'netw',
        desc: '',
        locale: _localeName,
      );

  String search() => Intl.message(
        'Rechercher',
        name: 'search',
        desc: '',
        locale: _localeName,
      );

  String safe() => Intl.message(
        'Be healthy',
        name: 'safe',
        desc: '',
        locale: _localeName,
      );

  String search_s() => Intl.message(
        'Speciality',
        name: 'search_s',
        desc: '',
        locale: _localeName,
      );

  String ph_number() => Intl.message(
        'Phone numbers',
        name: 'ph_number',
        desc: '',
        locale: _localeName,
      );

  String hospital() => Intl.message(
        'Hospital',
        name: 'hospital',
        desc: '',
        locale: _localeName,
      );

  String clinic() => Intl.message(
        'Clinic',
        name: 'clinic',
        desc: '',
        locale: _localeName,
      );

  String choose_q() => Intl.message(
        'neighbourhood',
        name: 'choose_q',
        desc: '',
        locale: _localeName,
      );

  String choose_c() => Intl.message(
        'Choose a city',
        name: 'choose_c',
        desc: '',
        locale: _localeName,
      );

  String a() => Intl.message(
        'Dermatology',
        name: 'a',
        desc: '',
        locale: _localeName,
      );

  String b() => Intl.message(
        'The teath',
        name: 'b',
        desc: '',
        locale: _localeName,
      );

  String c() => Intl.message(
        'Psychiatry',
        name: 'c',
        desc: '',
        locale: _localeName,
      );

  String d() => Intl.message(
        'Pediatrics',
        name: 'd',
        desc: '',
        locale: _localeName,
      );

  String e() => Intl.message(
        'Neurosurgery',
        name: 'e',
        desc: '',
        locale: _localeName,
      );

  String no() => Intl.message(
        '',
        name: 'no',
        desc: '',
        locale: _localeName,
      );

  String animal() => Intl.message(
        '',
        name: 'animal',
        desc: '',
        locale: _localeName,
      );

  String ask() => Intl.message(
        '',
        name: 'ask',
        desc: '',
        locale: _localeName,
      );

  String f() => Intl.message(
        'Orthopedics',
        name: 'f',
        desc: '',
        locale: _localeName,
      );

  String g() => Intl.message(
        'Gynecology',
        name: 'g',
        desc: '',
        locale: _localeName,
      );

  String h() => Intl.message(
        'Otorhinolaryngology',
        name: 'h',
        desc: '',
        locale: _localeName,
      );

  String i() => Intl.message(
        'Cardiovascular diseases',
        name: 'i',
        desc: '',
        locale: _localeName,
      );

  String j() => Intl.message(
        'Sensitivity and immunity',
        name: 'j',
        desc: '',
        locale: _localeName,
      );

  String app() => Intl.message(
        'Appointments',
        name: 'app',
        desc: '',
        locale: _localeName,
      );

  String fav() => Intl.message(
        'Favorite',
        name: 'fav',
        desc: '',
        locale: _localeName,
      );

  String reserve() => Intl.message(
        'Reserve',
        name: 'reserve',
        desc: '',
        locale: _localeName,
      );

  String cancel() => Intl.message(
        'Cancel',
        name: 'cancel',
        desc: '',
        locale: _localeName,
      );

  String cancel_a() => Intl.message(
        'Cancel',
        name: 'cancel_a',
        desc: '',
        locale: _localeName,
      );

  String offer() => Intl.message(
        'Offers',
        name: 'offer',
        desc: '',
        locale: _localeName,
      );

  String pass_nn() => Intl.message(
        'Please enter a password',
        name: 'pass_nn',
        desc: '',
        locale: _localeName,
      );

  String email_isn() => Intl.message(
        'Email is not valid',
        name: 'email_isn',
        desc: '',
        locale: _localeName,
      );

  String email_n() => Intl.message(
        'Please enter your Email address',
        name: 'email_n',
        desc: '',
        locale: _localeName,
      );

  String pass_dn() => Intl.message(
        'The passwords don\'t match',
        name: 'pass_dn',
        desc: '',
        locale: _localeName,
      );

  String fix() => Intl.message(
        'Please fix the errors in red before submitting',
        name: 'fix',
        desc: '',
        locale: _localeName,
      );

  String noin() => Intl.message(
        'No internet connexion',
        name: 'noin',
        desc: '',
        locale: _localeName,
      );
}

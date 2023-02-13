import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

final _keepAnalysisHappy = Intl.defaultLocale;

class MessageLookup extends MessageLookupByLibrary {
  get localeName => 'ar';

  final messages = _notInlinedMessages(_notInlinedMessages);

  static _notInlinedMessages(_) => {
        "login": MessageLookupByLibrary.simpleMessage("الدخول"),
        "login_google": MessageLookupByLibrary.simpleMessage(
            "تسجيل الدخول باستخدام GOOGLE"),
        "bén": MessageLookupByLibrary.simpleMessage("استفادة"),
        "group": MessageLookupByLibrary.simpleMessage("مجموعة"),
        "priv": MessageLookupByLibrary.simpleMessage("خاص"),

        "option": MessageLookupByLibrary.simpleMessage("هذه الخاصية  محجوزة للأعضاء الذين تم التحقق منهم! اتصل بالمسؤول للتحقق من حسابك"),
        "ve_e": MessageLookupByLibrary.simpleMessage("يرجى اختيار الشركة"),

        "sve": MessageLookupByLibrary.simpleMessage("حفظ"),

        "login_facebook": MessageLookupByLibrary.simpleMessage(
            "تسجيل الدخول باستخدام الفايسبوك"),
        "filtrer": MessageLookupByLibrary.simpleMessage('تصفية حسب'),
        "searchc": MessageLookupByLibrary.simpleMessage('ابحث عن محادثة'),
        "len": MessageLookupByLibrary.simpleMessage(" الشركات"),

        "commission": MessageLookupByLibrary.simpleMessage('لجنة '),
        "lresp": MessageLookupByLibrary.simpleMessage('قائمة المسؤوليات'),
        "search_r": MessageLookupByLibrary.simpleMessage("ابحث عن مسؤولية"),

        "dem": MessageLookupByLibrary.simpleMessage("طلب اتصال"),

        "no_not": MessageLookupByLibrary.simpleMessage('لم يتم العثور على إشعار'),

        "no_mess": MessageLookupByLibrary.simpleMessage('لا توجد رسائل '),
        "block": MessageLookupByLibrary.simpleMessage('حظر هذا المستخدم'),
        "activate": MessageLookupByLibrary.simpleMessage('تفعيل الحساب'),
        "disa": MessageLookupByLibrary.simpleMessage("تم تعطيل حسابك ، هل تريد إعادة تفعيل حسابك؟"),
        "contact": MessageLookupByLibrary.simpleMessage("اتصال"),















        "resps": MessageLookupByLibrary.simpleMessage('يرجى اختيار المسؤولية'),

        "g_n": MessageLookupByLibrary.simpleMessage('المجموعات الوطنية'),
        "g_r": MessageLookupByLibrary.simpleMessage('المجموعات الإقليمية'),

        "fed": MessageLookupByLibrary.simpleMessage('فيدرالية '),

        "sector": MessageLookupByLibrary.simpleMessage('قطاع '),


        "rej_c": MessageLookupByLibrary.simpleMessage("مجموعات المحادثة"),
        "rej_f": MessageLookupByLibrary.simpleMessage("مجموعات المحادثة"),
        "here": MessageLookupByLibrary.simpleMessage('انقر هنا لرؤية المزيد من التفاصيل'),

        "actu": MessageLookupByLibrary.simpleMessage('أخبار '),
        "oppo": MessageLookupByLibrary.simpleMessage('الفرص التجارية'),

        "CGEM": MessageLookupByLibrary.simpleMessage('الاتحاد العام لمقاولات المغرب '),
        "ava": MessageLookupByLibrary.simpleMessage('فوائد '),
        "prodss": MessageLookupByLibrary.simpleMessage('منتجات وخدمات الأعضاء '),
        "tarifs": MessageLookupByLibrary.simpleMessage('أسعار تفضيلية '),
        "vids": MessageLookupByLibrary.simpleMessage('مكتبة الفيديو'),
        "pres": MessageLookupByLibrary.simpleMessage(' عرض'),
        "services": MessageLookupByLibrary.simpleMessage(' الخدمات'),
        "continue": MessageLookupByLibrary.simpleMessage("استمر"),




        "comms": MessageLookupByLibrary.simpleMessage('اللجان '),
        "ccom": MessageLookupByLibrary.simpleMessage('اختر لجنة'),
        "cfed": MessageLookupByLibrary.simpleMessage('اختر  فيدرالية'),
        "search_opp": MessageLookupByLibrary.simpleMessage('ابحث عن فرصة'),
        "type_opp": MessageLookupByLibrary.simpleMessage('نوع فرصة العمل'),
        "cent": MessageLookupByLibrary.simpleMessage('اختر شركة '),
        "aucun_g": MessageLookupByLibrary.simpleMessage("لم يتم العثور على مجموعات"),

        "mone": MessageLookupByLibrary.simpleMessage('شركتي '),
        "suivi": MessageLookupByLibrary.simpleMessage(' متابع'),

        "fids": MessageLookupByLibrary.simpleMessage('الفيدراليات القطاعية'),

        "entrep": MessageLookupByLibrary.simpleMessage('الشركات'),
        "sui": MessageLookupByLibrary.simpleMessage('تابع'),
        "sui_ent": MessageLookupByLibrary.simpleMessage('تابع هذه الشركة'),










        "notm": MessageLookupByLibrary.simpleMessage("أنت لست عضوا؟"),
        "ent_mail": MessageLookupByLibrary.simpleMessage(
            "أدخل بريدك الالكتروني من فضلك"),
        "mot_n": MessageLookupByLibrary.simpleMessage(
            "كلمة المرور يجب أن تصل إلى 6 أحرف"),
        "email_not":
            MessageLookupByLibrary.simpleMessage("البريد الإلكتروني غير صالح"),
        "macc": MessageLookupByLibrary.simpleMessage("إنشاء حساب"),
        "proff": MessageLookupByLibrary.simpleMessage("مهنة"),
        "pre": MessageLookupByLibrary.simpleMessage("الأسم الأول"),
        "organisme": MessageLookupByLibrary.simpleMessage("هيئة"),
        "biblio": MessageLookupByLibrary.simpleMessage("المكتبة الالكترونية"),
        "publi": MessageLookupByLibrary.simpleMessage("المنشورات"),
        "agenda": MessageLookupByLibrary.simpleMessage("جدول أعمال"),
        "forms": MessageLookupByLibrary.simpleMessage("دورات تكوينية"),
        "btk": MessageLookupByLibrary.simpleMessage("متجر الكتروني"),
        "casc": MessageLookupByLibrary.simpleMessage("الحالات السريرية"),
        "conv": MessageLookupByLibrary.simpleMessage("الاتفاقيات"),
        "ann": MessageLookupByLibrary.simpleMessage("إعلانات"),
        "cartem": MessageLookupByLibrary.simpleMessage("الخريطة"),
        "details": MessageLookupByLibrary.simpleMessage("تفاصيل"),

        "invite": MessageLookupByLibrary.simpleMessage(
            "قم بدعوة جهات الاتصال الخاصة بك "),
        /* للانضمام إلى SANTÉ CONNECT*/
        "po": MessageLookupByLibrary.simpleMessage("مدعم من"),
        "fils": MessageLookupByLibrary.simpleMessage("المستجدات "),

        "netw": MessageLookupByLibrary.simpleMessage("الشبكات"),
        "messg": MessageLookupByLibrary.simpleMessage("الرسائل"),
        "partn": MessageLookupByLibrary.simpleMessage("شركاء"),
        "tous": MessageLookupByLibrary.simpleMessage("الكل"),
        "pers": MessageLookupByLibrary.simpleMessage("المستخدمين"),
        "typeb": MessageLookupByLibrary.simpleMessage("نوع المنشور"),
        "sond": MessageLookupByLibrary.simpleMessage("استطلاعات الرأي"),
        "se_con": MessageLookupByLibrary.simpleMessage("اتصال "),
        "inactive": MessageLookupByLibrary.simpleMessage("غير مفعلة "),
        "aucun": MessageLookupByLibrary.simpleMessage("لم يتم العثور على نتائج"),
        "no_co": MessageLookupByLibrary.simpleMessage(" لم يتم تحديد أي من المهارات  "),
        "no_obj": MessageLookupByLibrary.simpleMessage(" لم يتم تحديد  أي هدف  "),
        "params": MessageLookupByLibrary.simpleMessage("إعدادات "),
        "je_vis": MessageLookupByLibrary.simpleMessage("اريد ان اكون مرئيا "),
        "je_des": MessageLookupByLibrary.simpleMessage("أريد إلغاء حسابي"),
        "poli": MessageLookupByLibrary.simpleMessage("سياسة الخصوصية "),
        "je_notif": MessageLookupByLibrary.simpleMessage("أريد تلقي الإشعارات"),
        "add_desc": MessageLookupByLibrary.simpleMessage("إضف الوصف .."),
        "linkedin": MessageLookupByLibrary.simpleMessage("حساب linkedin "),
        "insta1": MessageLookupByLibrary.simpleMessage("حساب Instagram "),
        "twitter1": MessageLookupByLibrary.simpleMessage("حساب TWITTER "),
        "add_num": MessageLookupByLibrary.simpleMessage("أضف رقم هاتفك"),
        "message": MessageLookupByLibrary.simpleMessage("ارسل رسالة "),
        "accepter": MessageLookupByLibrary.simpleMessage("قبول الدعوة "),
        "enligne": MessageLookupByLibrary.simpleMessage("على الخط "),

        "accepta": MessageLookupByLibrary.simpleMessage("  قبل طلب الاتصال الخاص بك "),
        "sendi": MessageLookupByLibrary.simpleMessage(" أرسل لك طلب اتصال "),

        "no_msg": MessageLookupByLibrary.simpleMessage("لا توجد رسائل"),

        "retourner": MessageLookupByLibrary.simpleMessage("رجوع "),

        "offe": MessageLookupByLibrary.simpleMessage("عرض العمل / التدريب"),
        "compe": MessageLookupByLibrary.simpleMessage("مهارات"),
        "objs": MessageLookupByLibrary.simpleMessage("الأهداف الحالية "),
        "infos": MessageLookupByLibrary.simpleMessage("معلومات"),
        "event": MessageLookupByLibrary.simpleMessage("حدث "),
        "cov": MessageLookupByLibrary.simpleMessage("الانتقال الجماعي"),
        "int": MessageLookupByLibrary.simpleMessage("مهتم"),
        "particip": MessageLookupByLibrary.simpleMessage("المشاركين"),
        "not_int": MessageLookupByLibrary.simpleMessage("غير مهتم بعد الآن"),
        "je_int": MessageLookupByLibrary.simpleMessage("أنا مهتم"),
        "annuler": MessageLookupByLibrary.simpleMessage("إلغاء "),
        "num_tel": MessageLookupByLibrary.simpleMessage("رقم الهاتف"),
        "km": MessageLookupByLibrary.simpleMessage("كم"),
        "skip": MessageLookupByLibrary.simpleMessage("تخطي "),
        "typ": MessageLookupByLibrary.simpleMessage("نوع "),
        "valid": MessageLookupByLibrary.simpleMessage("صالحة حتى"),
        "budget": MessageLookupByLibrary.simpleMessage("ميزانية"),

        "caut": MessageLookupByLibrary.simpleMessage("عربون"),


        "typed": MessageLookupByLibrary.simpleMessage("نوع الاشتراك"),
        "bienvenue": MessageLookupByLibrary.simpleMessage("مرحبا بكم"),

        "and": MessageLookupByLibrary.simpleMessage("و"),
        "editp": MessageLookupByLibrary.simpleMessage("تعديل الملف الشخصي"),
        "editprof": MessageLookupByLibrary.simpleMessage("تعديل"),
        "mypets": MessageLookupByLibrary.simpleMessage("حيواناتي الأليفة"),
        "tut": MessageLookupByLibrary.simpleMessage('البرنامج التعليمي'),

        "submedit": MessageLookupByLibrary.simpleMessage('عدل ملفك الشخصي'),
        "change": MessageLookupByLibrary.simpleMessage("اغلاق"),
        "mac": MessageLookupByLibrary.simpleMessage("بطاقتي"),

        "phone": MessageLookupByLibrary.simpleMessage("الهاتف"),
        "password": MessageLookupByLibrary.simpleMessage("كلمة المرور"),
        "register_new":
            MessageLookupByLibrary.simpleMessage("تسجيل مستخدم جديد"),
        "forget_pass":
            MessageLookupByLibrary.simpleMessage("نسيت كلمة المرور ؟"),
        "register": MessageLookupByLibrary.simpleMessage("تسجيل"),
        "fullname": MessageLookupByLibrary.simpleMessage("الاسم "),
        "confirm_password":
            MessageLookupByLibrary.simpleMessage("تأكيد كلمة المرور"),
        "email": MessageLookupByLibrary.simpleMessage("البريد الالكتروني"),
        "address": MessageLookupByLibrary.simpleMessage("العنوان"),
        "registerr": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
        "send_pass": MessageLookupByLibrary.simpleMessage("ارسال كلمة المرور"),
        "language": MessageLookupByLibrary.simpleMessage("اللغة"),
        "online": MessageLookupByLibrary.simpleMessage("تشغيل الحالة النشطة"),

        "confirm_logout": MessageLookupByLibrary.simpleMessage(
            "هل أنت متأكد أنك تريد تسجيل الخروج"),
        "wrong": MessageLookupByLibrary.simpleMessage("كلمة المرور غير صحيحه"),
        "loc_v": MessageLookupByLibrary.simpleMessage("إظهار الموقع"),

        "contact_us": MessageLookupByLibrary.simpleMessage("التواصل معنا"),
        "agree":
            MessageLookupByLibrary.simpleMessage("أوافق على الشروط والأحكام"),
        "about": MessageLookupByLibrary.simpleMessage("عن التطبيق"),
        "condit": MessageLookupByLibrary.simpleMessage("شروط الاستخدام"),
        "logout": MessageLookupByLibrary.simpleMessage("تسجيل الخروج"),
        "confirm": MessageLookupByLibrary.simpleMessage("تأكيد"),
        "skip": MessageLookupByLibrary.simpleMessage(" تخطي"),
        "welcome": MessageLookupByLibrary.simpleMessage(
            "مرحبًا بك في تطبيق Oncf انخراط"),
        "t1": MessageLookupByLibrary.simpleMessage(
            "البراق أم TNR؟ اشترك أينما كنت"),

        "home": MessageLookupByLibrary.simpleMessage("الرئيسية"), //الصفحة
        "inbox": MessageLookupByLibrary.simpleMessage("البريد الوارد"),
        "menu": MessageLookupByLibrary.simpleMessage(" الإعدادات"),
        "profile": MessageLookupByLibrary.simpleMessage(" الملف الشخصي"),
        "add_pic": MessageLookupByLibrary.simpleMessage("اضافة صورة "),
        "save": MessageLookupByLibrary.simpleMessage("حفظ"),
        "mobile": MessageLookupByLibrary.simpleMessage("رقم الجوال"),
        "search": MessageLookupByLibrary.simpleMessage('البحث'),
        "view": MessageLookupByLibrary.simpleMessage(' عرض الكل'),
        "last": MessageLookupByLibrary.simpleMessage(' اخر اضافات'),
        "cat": MessageLookupByLibrary.simpleMessage(' الاقسام'),
        "animal": MessageLookupByLibrary.simpleMessage("حيوانات"),
        "suc": MessageLookupByLibrary.simpleMessage('تم بنجاح'),
        "success":
            MessageLookupByLibrary.simpleMessage('تم إرسال رسالتك بنجاح '),
        "desc": MessageLookupByLibrary.simpleMessage("ادخل الوصف من فضلك"),
        "balance": MessageLookupByLibrary.simpleMessage("رصيد غير كافي "),
        "solde": MessageLookupByLibrary.simpleMessage(
            "يجب تعبئة الرصيد لاتمام النشر"),

        "offer": MessageLookupByLibrary.simpleMessage('العروض'),
        "lnge": MessageLookupByLibrary.simpleMessage('العربية'),
        "more": MessageLookupByLibrary.simpleMessage('المزيد'),
        "myp": MessageLookupByLibrary.simpleMessage('ملفي الشخصي'),
        "myf": MessageLookupByLibrary.simpleMessage('مفضلتي'),
        "send": MessageLookupByLibrary.simpleMessage('إرسال'),
        "cancel": MessageLookupByLibrary.simpleMessage('إلغاء'),
        "edit": MessageLookupByLibrary.simpleMessage('تعديل'),
        "chatg": MessageLookupByLibrary.simpleMessage('دردشة جماعية'),
        "members": MessageLookupByLibrary.simpleMessage('أفراد'),

        "selectp": MessageLookupByLibrary.simpleMessage('ادخل صورة على الاقل'),
        "delp": MessageLookupByLibrary.simpleMessage(' حدف الاعلان'),
        "delm": MessageLookupByLibrary.simpleMessage('حذف الرسائل'),

        "delc": MessageLookupByLibrary.simpleMessage(
            'هل تريد حقًا حذف هذه المحادثة؟'),
        "delpost": MessageLookupByLibrary.simpleMessage(
            'هل تريد حقًا حذف هذًا الاعلان؟'),

        "alllist": MessageLookupByLibrary.simpleMessage('جميع الاعلانات'),
        "chatb": MessageLookupByLibrary.simpleMessage('صندوق الوارد'),

        "mylist": MessageLookupByLibrary.simpleMessage('اعلاناتي'),
        "not": MessageLookupByLibrary.simpleMessage('إشعارات'),
        "insta": MessageLookupByLibrary.simpleMessage('تابعونا على الانستغرام'),
        "face": MessageLookupByLibrary.simpleMessage('تابعونا على الفيس بوك'),
        "twitter": MessageLookupByLibrary.simpleMessage('تابعونا على التويتر'),

        "pay": MessageLookupByLibrary.simpleMessage('تاريخ الدفع'),

        "no": MessageLookupByLibrary.simpleMessage('لا توجد نتيجة'),
        "ask": MessageLookupByLibrary.simpleMessage('اسألني سؤال'),

        "add_n": MessageLookupByLibrary.simpleMessage('أدخل العنوان من فضلك'),
        "name_n": MessageLookupByLibrary.simpleMessage('أدخل الاسم من فضلك'),
        "phone_n":
            MessageLookupByLibrary.simpleMessage('أدخل رقم الهاتف من فضلك'),
        "alpha_n": MessageLookupByLibrary.simpleMessage(
            ' الرجاء إدخال الأحرف الأبجدية فقط'),
        "pass_n": MessageLookupByLibrary.simpleMessage(
            'يجب أن تكون كلمة المرور 6 أحرف على الأقلّ'),
        "fix": MessageLookupByLibrary.simpleMessage(
            ' يرجى تصحيح الأخطاء باللون الأحمر قبل الإرسال'),
        "pass_nn": MessageLookupByLibrary.simpleMessage(
            'أدخل ادخل كلمة المرور من فضلك'),
        "pass_dn":
            MessageLookupByLibrary.simpleMessage('كلمات المرور لا تتطابق'),
        "email_isn":
            MessageLookupByLibrary.simpleMessage('البريد الإلكتروني غير صالح'),
        "email_n": MessageLookupByLibrary.simpleMessage(
            'أدخل البريد الإلكتروني من فضلك'),
        "noin": MessageLookupByLibrary.simpleMessage('لا يوجد اتصال بالانترنت'),
        "error": MessageLookupByLibrary.simpleMessage('خطأ من الخادم'),
        "not_r": MessageLookupByLibrary.simpleMessage('هذا الحساب غير مسجل'),
        "exist": MessageLookupByLibrary.simpleMessage('هذا الحساب موجود'),
        "invalid": MessageLookupByLibrary.simpleMessage(
            'الهاتف أو كلمة المرور غير صالحة'),
        "load": MessageLookupByLibrary.simpleMessage('جاري التحميل'),
        "co": MessageLookupByLibrary.simpleMessage('حسابي'),
        "del": MessageLookupByLibrary.simpleMessage('حذف من المفضلة'),
        "only": MessageLookupByLibrary.simpleMessage(
            'فقط المستخدمين المسجلين من يمكنهم  الولوج  إلى قائمة المواعيد'),
        "onlyf": MessageLookupByLibrary.simpleMessage(
            'فقط المستخدمين المسجلين من يمكنهم  الولوج  إلى قائمة  المفضلة'),
        "dte": MessageLookupByLibrary.simpleMessage('اختر تاريخ الحجز'),
        "insu": MessageLookupByLibrary.simpleMessage('ادخل التأمين الطبي'),
        "take": MessageLookupByLibrary.simpleMessage('التقط صوره'),
        "upload":
            MessageLookupByLibrary.simpleMessage('تحميل صورة من معرض الصور'),
        "en_com_no": MessageLookupByLibrary.simpleMessage(
            ' الرجاء إدخال الرقم السجل التجاري'),
        "start": MessageLookupByLibrary.simpleMessage('ابدأ'),
        "fill": MessageLookupByLibrary.simpleMessage('من فضلك املأ الفراغ'),
        "exit": MessageLookupByLibrary.simpleMessage('اغلاق التطبيق'),
        "search": MessageLookupByLibrary.simpleMessage("بحث"),
        "center_rec": MessageLookupByLibrary.simpleMessage("مركز الشكايات "),

        "ab": MessageLookupByLibrary.simpleMessage("اشتراك"),
        "carte": MessageLookupByLibrary.simpleMessage("البطاقة"),
        "montr": MessageLookupByLibrary.simpleMessage("رحلتي"),
        "classe": MessageLookupByLibrary.simpleMessage("القسم"),
        "client": MessageLookupByLibrary.simpleMessage("الزبون"),
        "rec": MessageLookupByLibrary.simpleMessage("ملخص"),
        "compte": MessageLookupByLibrary.simpleMessage("الحساب"),
        "pa": MessageLookupByLibrary.simpleMessage("الدفع"),
        "votre": MessageLookupByLibrary.simpleMessage("بطاقتك"),
        "nv": MessageLookupByLibrary.simpleMessage("مشترك جديد"),
        "vis": MessageLookupByLibrary.simpleMessage("زائر"),

        "dte_v": MessageLookupByLibrary.simpleMessage("تاريخ الصلاحية"),
        "dur": MessageLookupByLibrary.simpleMessage("مدة الاشتراك"),
        "ma_d": MessageLookupByLibrary.simpleMessage("محطة المغادرة"),
        "ma_a": MessageLookupByLibrary.simpleMessage("محطة الوصول"),
        "nom": MessageLookupByLibrary.simpleMessage("الاسم العائلي"),
        "pr": MessageLookupByLibrary.simpleMessage(" الأسم الأول"),
        "nat": MessageLookupByLibrary.simpleMessage("الجنسية"),
        "prof": MessageLookupByLibrary.simpleMessage("المهنة"),
        "fixe": MessageLookupByLibrary.simpleMessage("الهاتف الثابت"),
        "port": MessageLookupByLibrary.simpleMessage("الهاتف محمول"),
        "infos": MessageLookupByLibrary.simpleMessage("معلوماتي"),

        "adrv": MessageLookupByLibrary.simpleMessage("العنوان الكامل والمدينة"),

        "daten": MessageLookupByLibrary.simpleMessage("تاريخ الميلاد"),

        "exit_a":
            MessageLookupByLibrary.simpleMessage('هل تريد الخروج من البرنامج'),
        "t2": MessageLookupByLibrary.simpleMessage("أنشئ حسابك ببضع نقرات"),
        "t3": MessageLookupByLibrary.simpleMessage(
            "قم بمسح رقم CIN للحصول على أقصى درجات الراحة  الدفع عبر الإنترنت أو في المحطة التي تختارها   استمتع على الفور ببطاقة اشتراكك المادية"),
        "mesc": MessageLookupByLibrary.simpleMessage('بطاقاتي'),
        "subm": MessageLookupByLibrary.simpleMessage('تقديم'),
        "sub": MessageLookupByLibrary.simpleMessage('بالتسجيل فإنك توافق على'),
        "privacy": MessageLookupByLibrary.simpleMessage('سياسة الخصوصية'),
        "terms": MessageLookupByLibrary.simpleMessage(' شروط الاستعمال'),
        "iss": MessageLookupByLibrary.simpleMessage('هل لديك حساب؟ '),
        "t4": MessageLookupByLibrary.simpleMessage("المستقبل على خطوطنا"),
        "th": MessageLookupByLibrary.simpleMessage(
            'مشاركة التطبيق مع جهات الاتصال الخاصة بك'),
        "choose": MessageLookupByLibrary.simpleMessage(' اختر تصنيف'),
        "t5": MessageLookupByLibrary.simpleMessage(
            " شكرًا لك على ولائك ، تتمنى Oncf لكم تنقلًا ممتازًا"),
        "addpet": MessageLookupByLibrary.simpleMessage('تمت الاضافة بنجاح'),
        "title": MessageLookupByLibrary.simpleMessage('ONCF انخراط'),
        "pl": MessageLookupByLibrary.simpleMessage(
            'من فضلك قم بالتسجيل لتتمكن من استخدام هذه الخاصية'),
        "Address": MessageLookupByLibrary.simpleMessage("العنوان"),
        "description": MessageLookupByLibrary.simpleMessage("الوصف"),
        "ev": MessageLookupByLibrary.simpleMessage("تقييم التطبيق"),
        "ver": MessageLookupByLibrary.simpleMessage("تحقق من تحديث التطبيق"),
      };
}

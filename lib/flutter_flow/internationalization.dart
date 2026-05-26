import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['es', 'en'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? esText = '',
    String? enText = '',
  }) =>
      [esText, enText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // Home
  {
    'xyo19ic5': {
      'es': '',
      'en': '',
    },
    '54ke7j8j': {
      'es': 'Gold Up ',
      'en': 'Gold Up',
    },
    'c82j86hl': {
      'es': 'Disponible para gastar',
      'en': 'Available to spend',
    },
    'dnaqtwz2': {
      'es': '****',
      'en': '****',
    },
    'tyk6wo24': {
      'es': 'Ingresos − (Gastos + Ahorros) · ',
      'en': 'Income − (Expenses + Savings) ·',
    },
    'rnw4n4qy': {
      'es':
          'Este es el capital sin categorizar restante  este mes.     Fórmula: Ingresos - (Gastos + Ahorros)',
      'en':
          'This is the remaining uncategorized capital this month. Formula: Income - (Expenses + Savings)',
    },
    'h0g2nfj1': {
      'es': 'Cuentas Corriente',
      'en': 'Checking Accounts',
    },
    'rf72zmhc': {
      'es': 'Ingresos Totales',
      'en': 'Total Income',
    },
    'sbe34dod': {
      'es': 'Cuentas de Ahorro',
      'en': 'Savings Accounts',
    },
    'djw19hzq': {
      'es': 'Ahorros Totales',
      'en': 'Total Savings',
    },
    '5rsb3dyq': {
      'es': 'Tarjetas de Crédito',
      'en': 'Credit Cards',
    },
    'znwcc57a': {
      'es': 'Gastos Totales',
      'en': 'Total Expenses',
    },
    '8nct2kf2': {
      'es': '-',
      'en': '-',
    },
    '069ew9s9': {
      'es': 'Metas Financieras',
      'en': 'Financial Goals',
    },
    'qqp7ecc2': {
      'es': '50%',
      'en': '50%',
    },
    'dypk4av1': {
      'es': '',
      'en': '',
    },
    'u4ze750e': {
      'es': 'Próximo Gasto Importante Programado',
      'en': 'Next Scheduled Major Expense',
    },
    '122mqjz8': {
      'es': 'Facturas y Gastos del Mes ',
      'en': 'Bills and Expenses for the Month',
    },
    'tekzrh36': {
      'es': 'Pendientes',
      'en': 'Pending',
    },
    'en4oos86': {
      'es': 'Total a pagar:',
      'en': 'Total to pay:',
    },
    'um1c0wur': {
      'es': 'Vencidas',
      'en': 'Overdue',
    },
    '01wlanm9': {
      'es': 'Total Saldado:',
      'en': 'Total Paid:',
    },
    'ytcrcd16': {
      'es': 'Contenido patrocinado',
      'en': 'Sponsored content',
    },
    'u7njiwu8': {
      'es': 'Credit Score',
      'en': 'Credit Score',
    },
    'ii0m6920': {
      'es': '0',
      'en': '0',
    },
    'c0llrypx': {
      'es': 'Novedades',
      'en': 'New features',
    },
    'fd5mhk1b': {
      'es': 'BIENVENIDO',
      'en': 'WELCOME',
    },
    'ka162cxw': {
      'es': 'AÚN NO HAY DATOS QUE MOSTRAR',
      'en': 'THERE IS NO DATA TO DISPLAY YET',
    },
    'awhath0m': {
      'es': 'Para comenzar...',
      'en': 'To begin...',
    },
    'ej7xfkfw': {
      'es': 'Crea un evento en el calendario',
      'en': 'Create an event on the calendar',
    },
    'nyv2wh1q': {
      'es': '© 2026 Gold Up Group LLC. \nAll rights reserved.',
      'en': '',
    },
    'q5ptftnx': {
      'es': '',
      'en': '',
    },
    'ea1vwpg2': {
      'es': 'Ahorros',
      'en': 'Savings',
    },
    '8szmn3ym': {
      'es': 'Ingresos',
      'en': 'Income',
    },
    '9b2s27o9': {
      'es': 'Gastos',
      'en': 'Expenses',
    },
    'rjvocdm1': {
      'es': 'Eventos Financieros',
      'en': 'Financial Events',
    },
    'euaw6srv': {
      'es': 'Pendientes',
      'en': 'Pending',
    },
    'njfnwiyl': {
      'es': 'a pagar ',
      'en': 'to pay',
    },
    'lyakqr5h': {
      'es': 'Vencidas',
      'en': 'Overdue',
    },
    'n8n8c2g2': {
      'es': 'saldado',
      'en': 'paid',
    },
    'r0m4qusb': {
      'es': '',
      'en': '',
    },
    'fu26ssxg': {
      'es': 'Finanzas',
      'en': 'Finance',
    },
    'b829oa14': {
      'es': 'Mes Actual:',
      'en': 'Current Month:',
    },
    'ufdykbvu': {
      'es': 'Ingreso Total Mensual (estimado)',
      'en': 'Total Monthly Income (estimated)',
    },
    'vso6qbm7': {
      'es': 'Gasto Total Mensual (estimado)',
      'en': 'Total Monthly Expenses (estimated)',
    },
    'pu03qkui': {
      'es': 'Flujo de Efectivo Mensual (estimado)',
      'en': 'Monthly Cash Flow (estimated)',
    },
    'pd64did4': {
      'es': 'Ahorros Totales (estimado)',
      'en': 'Total Savings (estimated)',
    },
    'qgu1xblp': {
      'es': 'Disponible Para Gastar (estimado)',
      'en': 'Available to Spend (estimated)',
    },
    'axn33hnv': {
      'es': 'Ingreso Total Anual (estimado)',
      'en': 'Total Annual Income (estimated)',
    },
    'dxk4bljk': {
      'es': 'Gasto Total Anual (estimado)',
      'en': 'Total Annual Expenses (estimated)',
    },
    'wq0lfkq3': {
      'es': 'Flujo de Efectivo Total Anual (estimado)',
      'en': 'Total Annual Cash Flow (estimated)',
    },
    '6o0abik0': {
      'es': 'Ahorro Total Anual (estimado)',
      'en': 'Total Annual Savings (estimated)',
    },
    'epbluwwz': {
      'es': 'YA CUALQUIERA\n ES MILLONARIO',
      'en': 'YA CUALQUIERA\n ES MILLONARIO\n\n',
    },
    'zjwfxnul': {
      'es':
          'Una guía clara y directa para aprender a gestionar y construir riqueza.\nDescubre cómo tomar el control de tus finanzas y diseñar el camino hacia tu libertad financiera.\n',
      'en':
          'Una guía clara y directa para aprender a gestionar y construir riqueza.\nDescubre cómo tomar el control de tus finanzas y diseñar el camino hacia tu libertad financiera.',
    },
    'rlmum50i': {
      'es': '',
      'en': '',
    },
    'xx1hb2zh': {
      'es': 'Cuentas ',
      'en': 'Accounts',
    },
    'zzu7d454': {
      'es':
          'La integración de cuentas bancarias externas no está disponible para su uso en esta versión. Actualice su versión a Premium para disfrutar de todas las herramientas de esta aplicación y obtener un control total de sus finanzas.',
      'en':
          'External bank account integration is not available in this version. Upgrade to Premium to access all the tools in this app and gain complete control of your finances.',
    },
    'ipii2uoo': {
      'es': '🟢 Base (Gratis con anuncios)',
      'en': '🟢 Base (Free with ads)',
    },
    'c77uhlci': {
      'es':
          'Empieza a tomar control de tu dinero\n\n📅 Añadir eventos financieros manualmente (ingresos, gastos, ahorros)\n\n🗓️ Gestión completa desde el calendario\n\n✏️ Edición y eliminación limitada (afecta todas las recurrencias)\n\n📊 Hoja de balance del mes actual\n\n📈 Pronóstico básico de flujo de ingresos\n\n🧾 Visualización de facturas pendientes y pagadas\n\n🔔 Notificaciones predeterminadas (72h y mismo día)\n\n📢 Incluye anuncios',
      'en':
          'Start taking control of your money\n\n📅 Add financial events manually (income, expenses, savings)\n\n🗓️ Complete management from the calendar\n\n✏️ Limited editing and deletion (affects all recurring events)\n\n📊 Current month balance sheet\n\n📈 Basic income flow forecast\n\n🧾 View outstanding and paid invoices\n\n🔔 Default notifications (72 hours and same day)\n\n📢 Includes ads',
    },
    'zvzbms8y': {
      'es': 'Actualizar a Base con Anuncios',
      'en': 'Upgrade to Base with Ads',
    },
    '7sobga8t': {
      'es': 'Plan Actual',
      'en': 'Current Plan',
    },
    'tboo4q1u': {
      'es': '🔵 Base (Sin anuncios) x \$1.99 al mes ',
      'en': '🔵 Base (No ads) x \$1.99 per month',
    },
    'vlo6fyf1': {
      'es':
          'Misma potencia, sin distracciones\n\n✅ Todo lo incluido en la versión Base\n\n🚫 Sin anuncios\n\n⚡ Experiencia más limpia y rápida',
      'en':
          'Same power, no distractions\n\n✅ Everything included in the Base version\n\n🚫 No ads\n\n⚡ Cleaner, faster experience',
    },
    'e1ubl1vf': {
      'es': 'Actualizar a Base sin Anuncios',
      'en': 'Upgrade to Ad-Free Base',
    },
    '5kk2lozp': {
      'es': 'Plan Actual',
      'en': 'Current Plan',
    },
    '8f9b3uga': {
      'es': '🟣 Premium (Todas las funciones) x \$9.99 al mes',
      'en': '🟣 Premium (All features) x \$9.99 per month',
    },
    '34h5td7z': {
      'es':
          'Sistema completo para construir riqueza\n\n✅ Todo lo incluido en la versión Base mas:\n\n🔗 Vinculación con cuentas bancarias externas\n\n💳 Visualización de balance total (bancos + tarjetas)\n\n📅 Edición y eliminación de eventos independientes\n\n🔔 Notificaciones personalizadas (24h, 48h, 72h, 96h)\n\n📈 Flujo de efectivo anual\n\n💰 Pronóstico anual de ingresos, gastos y ahorros\n\n🎯 Creación y monitoreo de metas financieras\n\n🧠 Control financiero avanzado y automatizado',
      'en':
          'Complete Wealth Building System\n\n✅ Everything included in the Base version plus:\n\n🔗 Linking with external bank accounts\n\n💳 Total balance view (banks + cards)\n\n📅 Editing and deleting individual transactions\n\n🔔 Custom notifications (24h, 48h, 72h, 96h)\n\n📈 Annual cash flow\n\n💰 Annual forecast of income, expenses, and savings\n\n🎯 Creation and monitoring of financial goals\n\n🧠 Advanced and automated financial control',
    },
    'lnmha9od': {
      'es': 'Actualizar a Premium',
      'en': 'Upgrade to Premium',
    },
    'i2g712db': {
      'es': 'Plan Actual',
      'en': 'Current Plan',
    },
    'dxt9kb3c': {
      'es': 'Cheques',
      'en': 'Checks',
    },
    'cxfwph7h': {
      'es': 'Ahorros',
      'en': 'Savings',
    },
    'cdchq82q': {
      'es': 'Créditos',
      'en': 'Credits',
    },
    'guxo3dh0': {
      'es': 'Total Ahorrado:',
      'en': 'Total Saved:',
    },
    'cc7ff5vb': {
      'es': 'Total Utilizado:',
      'en': 'Total Used:',
    },
    'lj8kxbik': {
      'es': 'Total Disponible:',
      'en': 'Total Available:',
    },
    'n0hd9vvq': {
      'es': 'Añadir Cuentas ',
      'en': 'Add Accounts',
    },
    'bq7eyc8f': {
      'es': 'Funciones en desarrollo\n\n',
      'en': 'Functions in development',
    },
    'k0vslz1b': {
      'es':
          'Estás utilizando la versión piloto básica de Gold Up.\nLa sección de ',
      'en': 'You are using the beta version of Gold Up.',
    },
    't4slncj6': {
      'es': 'Cuentas Bancarias ',
      'en': 'Bank Accounts',
    },
    'arq1y8hp': {
      'es':
          'aún no está disponible  en esta fase.\n\nEstas funcionalidades se encuentran actualmente en desarrollo y serán habilitadas en próximas actualizaciones.\n\nGracias por formar parte de esta etapa temprana de prueba y ayudarnos a mejorar la aplicación.\n\n',
      'en':
          'This feature is not yet available at this stage.\n\nThese features are currently under development and will be enabled in future updates.\n\nThank you for participating in this early testing phase and helping us improve the app.',
    },
    '5l42ihgf': {
      'es': '¿Qué funciones trae esta herramienta?\n\n',
      'en': 'What features does this tool offer?',
    },
    'tnvafbcw': {
      'es':
          '1️⃣ 🔗 Todas tus cuentas en un solo lugar\nDejas de saltar entre apps y ves tu dinero completo en un solo lugar\n\n2️⃣ 🧾 Todas tus transacciones unificadas\nMovimientos de todos los bancos en una sola vista\n\n3️⃣ 📊 Cálculo real de ingresos y gastos\nNúmeros exactos, no estimaciones\n\n4️⃣ 💸 Control total del flujo de dinero\n Entiendes claramente en qué se va tu dinero\n\n5️⃣ 📅 Planificación mensual precisa \n Puedes organizar tu mes con base en datos reales\n\n6️⃣ 📉 Reducción de gastos innecesarios\nDetectas fugas de dinero automáticamente\n\n7️⃣ 🎯 Mayor capacidad de ahorro\n Tomas decisiones más inteligentes con tu dinero\n\n8️⃣ 🤖 Base para inteligencia financiera\n Permite automatizar, predecir y optimizar tus finanzas\n\n',
      'en':
          '1️⃣ 🔗 All your accounts in one place\nStop jumping between apps and see all your money in one place\n\n2️⃣ 🧾 All your transactions unified\nTransactions from all banks in a single view\n\n3️⃣ 📊 Accurate income and expense tracking\nExact numbers, not estimates\n\n4️⃣ 💸 Total control of your cash flow\nClearly understand where your money is going\n\n5️⃣ 📅 Precise monthly planning\nOrganize your month based on real data\n\n6️⃣ 📉 Reduced unnecessary expenses\nAutomatically detect money leaks\n\n7️⃣ 🎯 Increased savings capacity\nMake smarter decisions with your money\n\n8️⃣ 🤖 Foundation for financial intelligence\nAutomate, predict, and optimize your finances',
    },
    'guhd99at': {
      'es': '* Funciones Premiums',
      'en': '* Premium Features',
    },
    '845nyomz': {
      'es': '',
      'en': '',
    },
    'zwz9eivi': {
      'es': 'Metas Financieras',
      'en': 'Financial Goals',
    },
    'w40fj3to': {
      'es':
          'La creación y el monitoreo de metas financieras no está disponible para su uso en esta versión. Actualice su versión a Premium para disfrutar de todas las herramientas de esta aplicación y obtener un control total de sus finanzas.',
      'en':
          'Creating and monitoring financial goals is not available in this version. Upgrade to Premium to access all the tools in this app and gain complete control of your finances.',
    },
    '6e82svw1': {
      'es': '🟢 Base (Gratis con anuncios)',
      'en': '🟢 Base (Free with ads)',
    },
    '7o2luogx': {
      'es':
          'Empieza a tomar control de tu dinero\n\n📅 Añadir eventos financieros manualmente (ingresos, gastos, ahorros)\n\n🗓️ Gestión completa desde el calendario\n\n✏️ Edición y eliminación limitada (afecta todas las recurrencias)\n\n📊 Hoja de balance del mes actual\n\n📈 Pronóstico básico de flujo de ingresos\n\n🧾 Visualización de facturas pendientes y pagadas\n\n🔔 Notificaciones predeterminadas (72h y mismo día)\n\n📢 Incluye anuncios',
      'en':
          'Start taking control of your money\n\n📅 Add financial events manually (income, expenses, savings)\n\n🗓️ Complete management from the calendar\n\n✏️ Limited editing and deletion (affects all recurring events)\n\n📊 Current month balance sheet\n\n📈 Basic income flow forecast\n\n🧾 View outstanding and paid invoices\n\n🔔 Default notifications (72 hours and same day)\n\n📢 Includes ads',
    },
    'zcvbkuxs': {
      'es': 'Actualizar a Base con Anuncios',
      'en': 'Upgrade to Base with Ads',
    },
    '66v0je5c': {
      'es': 'Plan Actual',
      'en': 'Current Plan',
    },
    'mwi23mxs': {
      'es': '🔵 Base (Sin anuncios) x \$1.99 al mes ',
      'en': '🔵 Base (No ads) x \$1.99 per month',
    },
    '8i8mqf61': {
      'es':
          'Misma potencia, sin distracciones\n\n✅ Todo lo incluido en la versión Base\n\n🚫 Sin anuncios\n\n⚡ Experiencia más limpia y rápida',
      'en':
          'Same power, no distractions\n\n✅ Everything included in the Base version\n\n🚫 No ads\n\n⚡ Cleaner, faster experience',
    },
    'tiu5cq25': {
      'es': 'Actualizar a Base sin Anuncios',
      'en': 'Upgrade to Ad-Free Base',
    },
    'einhbqz6': {
      'es': 'Plan Actual',
      'en': 'Current Plan',
    },
    'qyrwtvgv': {
      'es': '🟣 Premium (Todas las funciones) x \$9.99 al mes',
      'en': '🟣 Premium (All features) x \$9.99 per month',
    },
    '882w7a9g': {
      'es':
          'Sistema completo para construir riqueza\n\n✅ Todo lo incluido en la versión Base mas:\n\n🔗 Vinculación con cuentas bancarias externas\n\n💳 Visualización de balance total (bancos + tarjetas)\n\n📅 Edición y eliminación de eventos independientes\n\n🔔 Notificaciones personalizadas (24h, 48h, 72h, 96h)\n\n📈 Flujo de efectivo anual\n\n💰 Pronóstico anual de ingresos, gastos y ahorros\n\n🎯 Creación y monitoreo de metas financieras\n\n🧠 Control financiero avanzado y automatizado',
      'en':
          'Complete Wealth Building System\n\n✅ Everything included in the Base version plus:\n\n🔗 Linking with external bank accounts\n\n💳 Total balance view (banks + cards)\n\n📅 Editing and deleting individual transactions\n\n🔔 Custom notifications (24h, 48h, 72h, 96h)\n\n📈 Annual cash flow\n\n💰 Annual forecast of income, expenses, and savings\n\n🎯 Creation and monitoring of financial goals\n\n🧠 Advanced and automated financial control',
    },
    'ez4qjo7z': {
      'es': 'Actualizar a Premium',
      'en': 'Upgrade to Premium',
    },
    'gc89j3u6': {
      'es': 'Plan Actual',
      'en': 'Current Plan',
    },
    't0dm9swd': {
      'es': 'Añadir Nueva Meta Financiera',
      'en': 'Add New Financial Goal',
    },
    'wffpi2ou': {
      'es': 'Función en desarrollo\n\n',
      'en': 'Function in development',
    },
    '1l7i063l': {
      'es':
          'Estás utilizando la versión piloto básica de Gold Up.\nLa sección de ',
      'en': 'You are using the basic pilot version of Gold Up.',
    },
    'g15ea4ig': {
      'es': 'Metas Financieras ',
      'en': 'Financial Goals',
    },
    'vtu887va': {
      'es':
          'aún no está disponible  en esta fase.\n\nEsta funcionalidades se encuentran actualmente en desarrollo y serán habilitadas en próximas actualizaciones.\n\nGracias por formar parte de esta etapa temprana de prueba y ayudarnos a mejorar la aplicación.\n\n',
      'en':
          'This feature is not yet available at this stage.\n\nThese features are currently under development and will be enabled in future updates.\n\nThank you for participating in this early testing phase and helping us improve the app.',
    },
    'ra2f2yu2': {
      'es': '¿Qué aporta esta funcionalidad?\n\n',
      'en': 'What does this feature offer?',
    },
    'b4ts9m8c': {
      'es':
          '1️⃣ 🎯 Dirección clara del dinero\nCada dólar tiene un objetivo definido\n\n2️⃣ 📊 Control del progreso\nVes cuánto llevas y cuánto te falta\n\n3️⃣ 📅 Planificación financiera real\n Divide metas en aportes mensuales alcanzables\n\n4️⃣ 💸 Ahorro estructurado\nEvita gastar dinero que ya tiene un propósito\n\n5️⃣ 📉 Reducción de gastos innecesarios\nTe obliga a priorizar lo importante\n\n6️⃣ 🧠 Disciplina financiera automática\n Convierte el ahorro en hábito, no en esfuerzo\n\n',
      'en':
          '1️⃣ 🎯 Clear direction of your money\nEvery dollar has a defined purpose\n\n2️⃣ 📊 Progress tracking\nSee how much you\'ve saved and how much you still need to save\n\n3️⃣ 📅 Realistic financial planning\nBreak down your goals into achievable monthly contributions\n\n4️⃣ 💸 Structured savings\nAvoid spending money that already has a purpose\n\n5️⃣ 📉 Reduction of unnecessary expenses\nForces you to prioritize what\'s important\n\n6️⃣ 🧠 Automatic financial discipline\nTurn saving into a habit, not a chore',
    },
    '4lc9672a': {
      'es': '¿Cómo funciona?\n\n',
      'en': 'How does it work?',
    },
    '21hk7x9d': {
      'es':
          '1️⃣ Creas una meta\nEj: carro, casa, fondo de emergencia\n\n2️⃣ Defines monto y tiempo\nEj: \$5,000 en 10 meses\n\n3️⃣ El sistema calcula el aporte\n Cuánto debes ahorrar por periodo\n\n4️⃣ Registras o automatizas aportes\nManual o desde tus ingresos\n\n5️⃣ Ves el progreso en tiempo real\nBarra, porcentaje, restante\n\n6️⃣ Ajustas si es necesario\nMás rápido o más flexible\n\n',
      'en':
          '1️⃣ Create a goal\nE.g., car, house, emergency fund\n\n2️⃣ Define the amount and timeframe\nE.g., \$5,000 in 10 months\n\n3️⃣ The system calculates the contribution\nHow much you should save per period\n\n4️⃣ Register or automate contributions\nManually or from your income\n\n5️⃣ View your progress in real time\nBar, percentage, remaining balance\n\n6️⃣ Adjust if needed\nFaster or more flexible',
    },
    'eivdta2n': {
      'es': '* Funciones Premiums',
      'en': '* Premium Features',
    },
    'ai592cl4': {
      'es': 'Gold Up ',
      'en': 'Gold Up',
    },
    't6frxoek': {
      'es': 'Tienes el potencial necesario para alcanzar el éxito.',
      'en': 'You have the potential to achieve success.',
    },
    '31y0aix1': {
      'es': '•',
      'en': '•',
    },
    'mtkcdjcv': {
      'es': 'Por tu seguridad, verifica tu identidad para continuar.',
      'en': 'For your security, please verify your identity to continue.',
    },
  },
  // Auth2
  {
    '51mq6e1x': {
      'es': 'Gold Up ',
      'en': 'Gold Up',
    },
    'qag2uhrp': {
      'es': 'Crear Cuenta',
      'en': 'Create Account',
    },
    'y49wpb09': {
      'es': 'Crear Cuenta',
      'en': 'Create Account',
    },
    'lbxsigxt': {
      'es': 'Comencemos rellenando los datos siguientes.',
      'en': 'Let\'s begin by filling in the following information.',
    },
    'ftjomfw7': {
      'es': 'Correo Electrónico',
      'en': 'Email',
    },
    'pvkz1xtz': {
      'es': 'Contraseña',
      'en': 'Password',
    },
    '5tlzsdwh': {
      'es': 'He leído y acepto los ',
      'en': 'I have read and agree to the',
    },
    'b9o0tuaa': {
      'es': 'Términos del Servicio ',
      'en': 'Terms of Service',
    },
    'tkjz5xiv': {
      'es': 'y la ',
      'en': 'and the',
    },
    'wmyxe84y': {
      'es': 'Política de Privacidad',
      'en': 'Privacy Policy',
    },
    'lnfd3dhh': {
      'es': 'Hello World',
      'en': 'Hello World',
    },
    '7pl2siua': {
      'es': 'Registrar Cuenta',
      'en': 'Register Account',
    },
    'h4o0lr8h': {
      'es': 'Acceder',
      'en': 'Access',
    },
    'o6fgy1ob': {
      'es': 'Bienvenido de Vuelta',
      'en': 'Welcome Back',
    },
    'qma3by2w': {
      'es': 'Rellene la siguiente informacion para acceder a su cuenta',
      'en': 'Fill in the following information to access your account',
    },
    '45ro92jo': {
      'es': 'Correo electrónico',
      'en': 'Email',
    },
    'z701o62p': {
      'es': 'Contraseña',
      'en': 'Password',
    },
    '7x735jg6': {
      'es': 'Acceder',
      'en': 'Access',
    },
    '5vx87ull': {
      'es': 'Olvidé la Contraseña?',
      'en': 'Forgot your password?',
    },
    '9pm44qya': {
      'es': 'Home',
      'en': 'Home',
    },
  },
  // sett
  {
    'h6l9fr95': {
      'es': 'Ajustes',
      'en': 'Settings',
    },
    'ezasaexc': {
      'es': 'Tu Cuenta',
      'en': 'Your Account',
    },
    'q7uwl4de': {
      'es': 'Eliminar Cuenta',
      'en': 'Delete Account',
    },
    'bop39omt': {
      'es': 'Cambiar Contraseña',
      'en': 'Change Password',
    },
    'v0lzv9c4': {
      'es': 'Actualizar Plan',
      'en': 'Update Plan',
    },
    'ol0rua18': {
      'es': 'Ajustes de la Aplicación',
      'en': 'Application Settings',
    },
    '7phuxfjk': {
      'es': 'Ajustes de Notificaciones',
      'en': 'Notification settings',
    },
    'gcm6zvif': {
      'es': 'Cuentas de Bancos',
      'en': 'Bank Accounts',
    },
    'x1cvzure': {
      'es': 'Ayuda y Soporte',
      'en': 'Help and Support',
    },
    'ycpib1ss': {
      'es': 'Soporte',
      'en': 'Support',
    },
    'x9pyxrnb': {
      'es': 'Terminos del Servicio',
      'en': 'Terms of Service',
    },
    '2dn5htey': {
      'es': 'Política de Privacidad',
      'en': 'Privacy Policy',
    },
    'pxnwzj3h': {
      'es': 'Cerrar Sesión',
      'en': 'Log Out',
    },
    'sdjnq3y4': {
      'es': 'Home',
      'en': 'Home',
    },
  },
  // Planes
  {
    'g8wcoax1': {
      'es': 'Planes',
      'en': 'Plans',
    },
    '1n12gzth': {
      'es': '🟢 Base (Gratis con anuncios)',
      'en': '🟢 Base (Free with ads)',
    },
    'zr3armsj': {
      'es':
          'Empieza a tomar control de tu dinero\n\n📅 Añadir eventos financieros manualmente (ingresos, gastos, ahorros)\n\n🗓️ Gestión completa desde el calendario\n\n✏️ Edición y eliminación limitada (afecta todas las recurrencias)\n\n📊 Hoja de balance del mes actual\n\n📈 Pronóstico básico de flujo de ingresos\n\n🧾 Visualización de facturas pendientes y pagadas\n\n🔔 Notificaciones predeterminadas (72h y mismo día)\n\n📢 Incluye anuncios',
      'en':
          'Start taking control of your money\n\n📅 Add financial events manually (income, expenses, savings)\n\n🗓️ Complete management from the calendar\n\n✏️ Limited editing and deletion (affects all recurring events)\n\n📊 Current month balance sheet\n\n📈 Basic income flow forecast\n\n🧾 View outstanding and paid invoices\n\n🔔 Default notifications (72 hours and same day)\n\n📢 Includes ads',
    },
    '8yr46qoo': {
      'es': 'Actualizar a Base con Anuncios',
      'en': 'Upgrade to Base with Ads',
    },
    'cofn2o5a': {
      'es': 'Plan Actual',
      'en': 'Current Plan',
    },
    'lhre3ndz': {
      'es': '🔵 Base (Sin anuncios) x \$1.99 al mes ',
      'en': '🔵 Base (No ads) x \$1.99 per month',
    },
    'sd39jhmn': {
      'es':
          'Misma potencia, sin distracciones\n\n✅ Todo lo incluido en la versión Base\n\n🚫 Sin anuncios\n\n⚡ Experiencia más limpia y rápida',
      'en':
          'Same power, no distractions\n\n✅ Everything included in the Base version\n\n🚫 No ads\n\n⚡ Cleaner, faster experience',
    },
    'ux0fy8w3': {
      'es': 'Actualizar a Base sin Anuncios',
      'en': 'Upgrade to Ad-Free Base',
    },
    'cbbcmbe6': {
      'es': 'Plan Actual',
      'en': 'Current Plan',
    },
    'n8b3fnxc': {
      'es': '🟣 Premium (Todas las funciones) x \$9.99 al mes',
      'en': '🟣 Premium (All features) x \$9.99 per month',
    },
    'm67sp4zs': {
      'es':
          'Sistema completo para construir riqueza\n\n✅ Todo lo incluido en la versión Base mas:\n\n🔗 Vinculación con cuentas bancarias externas\n\n💳 Visualización de balance total (bancos + tarjetas)\n\n📅 Edición y eliminación de eventos independientes\n\n🔔 Notificaciones personalizadas (24h, 48h, 72h, 96h)\n\n📈 Flujo de efectivo anual\n\n💰 Pronóstico anual de ingresos, gastos y ahorros\n\n🎯 Creación y monitoreo de metas financieras\n\n🧠 Control financiero avanzado y automatizado',
      'en':
          'Complete Wealth Building System\n\n✅ Everything included in the Base version plus:\n\n🔗 Linking with external bank accounts\n\n💳 Total balance view (banks + cards)\n\n📅 Editing and deleting individual transactions\n\n🔔 Custom notifications (24h, 48h, 72h, 96h)\n\n📈 Annual cash flow\n\n💰 Annual forecast of income, expenses, and savings\n\n🎯 Creation and monitoring of financial goals\n\n🧠 Advanced and automated financial control',
    },
    'srs3xf4m': {
      'es': 'Actualizar a Premium',
      'en': 'Upgrade to Premium',
    },
    'd76ouv8s': {
      'es': 'Plan Actual',
      'en': 'Current Plan',
    },
    'dmfm3rh3': {
      'es': 'Home',
      'en': 'Home',
    },
  },
  // operations
  {
    'g4fvdlv8': {
      'es': 'Transacciones',
      'en': 'Transactions',
    },
    '285a16rq': {
      'es': '....',
      'en': '....',
    },
    '7o7nng08': {
      'es': 'Periodo ',
      'en': 'Period',
    },
    'cytqamsy': {
      'es': 'Saldo Disponible',
      'en': 'Available Balance',
    },
    'ohs96x74': {
      'es': 'Pendientes',
      'en': 'Pending',
    },
    'afh1uauu': {
      'es': 'Registradas',
      'en': 'Recorded',
    },
    'hcggy87v': {
      'es': 'Home',
      'en': 'Home',
    },
  },
  // welcome
  {
    'tmi8jj9t': {
      'es': 'Home',
      'en': 'Home',
    },
  },
  // AccionCrear
  {
    'hzna105s': {
      'es': 'Añadir',
      'en': 'Add',
    },
    '1n5jgwc4': {
      'es': 'Ingresos',
      'en': 'Income',
    },
    'aiotqwhc': {
      'es': 'Salario, préstamos, propinas...',
      'en': 'Salary, loans, tips...',
    },
    'sco7c33u': {
      'es': 'Gastos',
      'en': 'Expenses',
    },
    'ym8s63so': {
      'es': 'Suscripciones, facturas, deudas...',
      'en': 'Subscriptions, invoices, debts...',
    },
    'sh89gyf2': {
      'es': 'Eventos Financieros',
      'en': 'Financial Transactions',
    },
    'iiw60dk6': {
      'es': 'Pagos de tarjetas, cierres de ciclos...',
      'en': 'Card payments, closing cycles...',
    },
    'he7l9oga': {
      'es': 'Ahorros',
      'en': 'Savings',
    },
    'ezekb3fd': {
      'es': 'Movimientos de efectivo a cuentas de ahorro...',
      'en': 'Transfers to savings accounts...',
    },
  },
  // ingreso
  {
    'nak72f8v': {
      'es': 'Ingreso',
      'en': 'Income',
    },
    'r1xf2ued': {
      'es': 'Tipo',
      'en': 'Type',
    },
    'nbkstgz0': {
      'es': 'Seleccionar...',
      'en': 'Select...',
    },
    '6sifcgxr': {
      'es': 'Search...',
      'en': 'Search...',
    },
    'hxjfhexu': {
      'es': 'Salario',
      'en': 'Salary',
    },
    'jws6ym4z': {
      'es': 'Propinas',
      'en': 'Tips',
    },
    'xluem7ez': {
      'es': 'Comisiones',
      'en': 'Commissions',
    },
    'iu2eex6q': {
      'es': 'Venta',
      'en': 'Sale',
    },
    'zvvg5616': {
      'es': 'Regalias',
      'en': 'Royalties',
    },
    '0y09ie3m': {
      'es': 'Préstamo',
      'en': 'Loan',
    },
    'hd7c4du0': {
      'es': 'Otro',
      'en': 'Other',
    },
    '1jsp3k3f': {
      'es': 'Descripción ',
      'en': 'Description',
    },
    'shv786po': {
      'es': 'Puedes dejar una breve descripción...',
      'en': 'You can leave a brief description...',
    },
    '87jnqffd': {
      'es': 'Monto ',
      'en': 'Amount',
    },
    '3eyn3nhx': {
      'es': '0.0',
      'en': '0.0',
    },
    '8do17dfy': {
      'es': 'Ingreso recurrente',
      'en': 'Recurring income',
    },
    'pktf0xea': {
      'es': 'Frecuencia',
      'en': 'Frequency',
    },
    '62wcjb56': {
      'es': 'Seleccionar...',
      'en': 'Select...',
    },
    'e3qowgnu': {
      'es': 'Search...',
      'en': 'Search...',
    },
    't7vddq58': {
      'es': 'Diario',
      'en': 'Daily',
    },
    'tlq2y488': {
      'es': 'Semanal',
      'en': 'Weekly',
    },
    '72nvpdza': {
      'es': 'Quincenal',
      'en': 'Biweekly',
    },
    'ezxtnhn8': {
      'es': 'Mensual',
      'en': 'Monthly',
    },
    'xv0oc039': {
      'es': 'Trimestral',
      'en': 'Quarterly',
    },
    '6gtu0op4': {
      'es': 'Anual',
      'en': 'Annual',
    },
    'sqy09t8s': {
      'es': 'Ajustes de Notificación',
      'en': 'Notification Settings',
    },
    '85b3ytpz': {
      'es': '( Horas de antelación para recibir la notificación )',
      'en': '(Hours in advance to receive the notification)',
    },
    'yf8m56h4': {
      'es': '72',
      'en': '72',
    },
    'yva3oern': {
      'es': '',
      'en': '',
    },
    '1zvpttq9': {
      'es': 'Buscar...',
      'en': 'Search...',
    },
    'qexd8ak6': {
      'es': '24',
      'en': '24',
    },
    'ucqacvm7': {
      'es': '48',
      'en': '48',
    },
    'tpj0gnuf': {
      'es': '72',
      'en': '72',
    },
    'zuw6a6fr': {
      'es': '96',
      'en': '96',
    },
    'ubns1aom': {
      'es': 'Añadir',
      'en': 'Add',
    },
  },
  // cardBillCopy
  {
    'ixic4owu': {
      'es': 'Ahorros',
      'en': 'Saving',
    },
  },
  // Gasto
  {
    '97fe1qqr': {
      'es': 'Gasto',
      'en': 'Expense',
    },
    'td8dq3cm': {
      'es': 'Tipo',
      'en': 'Type',
    },
    'cnzoi2i6': {
      'es': 'Seleccionar...',
      'en': 'Select...',
    },
    'p5zw222n': {
      'es': 'Search...',
      'en': 'Search...',
    },
    '5dcn854v': {
      'es': 'Factura',
      'en': 'Bill',
    },
    'l2aqbazy': {
      'es': 'Suscripción',
      'en': 'Subscription',
    },
    'u3mncga9': {
      'es': 'Deuda',
      'en': 'Debt',
    },
    'hjbmq29f': {
      'es': 'Otro',
      'en': 'Other',
    },
    'noqmetuh': {
      'es': 'Descripción',
      'en': 'Description',
    },
    'coajwhl4': {
      'es': 'Puedes dejar una breve descripción...',
      'en': 'You can leave a brief description...',
    },
    'b3clwz0e': {
      'es': 'Monto ',
      'en': 'Amount',
    },
    '3d1jc68e': {
      'es': '',
      'en': '',
    },
    'y8ol0s6w': {
      'es': '0.0',
      'en': '0.0',
    },
    'znx8mqs5': {
      'es': 'Gasto recurrente',
      'en': 'Recurring expense',
    },
    'qk9j07dm': {
      'es': 'Frecuencia',
      'en': 'Frequency',
    },
    's4ld0l5y': {
      'es': 'Seleccionar...',
      'en': 'Select...',
    },
    'psx3wg5b': {
      'es': 'Buscar...',
      'en': 'Search...',
    },
    'l723uc52': {
      'es': 'Diario',
      'en': 'Daily',
    },
    'u3lxupbl': {
      'es': 'Semanal',
      'en': 'Weekly',
    },
    'anu9aome': {
      'es': 'Quincenal',
      'en': 'Biweekly',
    },
    'tlyrhue1': {
      'es': 'Mensual',
      'en': 'Monthly',
    },
    'wyq11rgz': {
      'es': 'Trimestral',
      'en': 'Quarterly',
    },
    '91oewpz4': {
      'es': 'Anual',
      'en': 'Annual',
    },
    'g098xmia': {
      'es': 'Ajustes de Notificación',
      'en': 'Notification Settings',
    },
    'swdbx2rc': {
      'es': '( Horas de antelación para recibir la notificación )',
      'en': '(Hours in advance to receive the notification)',
    },
    'f2pcuhbv': {
      'es': '72',
      'en': '72',
    },
    '8eos0e2h': {
      'es': '',
      'en': '',
    },
    'qi84zs4j': {
      'es': 'Buscar...',
      'en': 'Search...',
    },
    'xk9tj7n4': {
      'es': '24',
      'en': '24',
    },
    'd72rl6nz': {
      'es': '48',
      'en': '48',
    },
    'vtn4lve6': {
      'es': '72',
      'en': '72',
    },
    '10z723aa': {
      'es': '96',
      'en': '96',
    },
    '2wp0tze0': {
      'es': 'Añadir',
      'en': 'Add',
    },
  },
  // EventoFinanciero
  {
    'y6tc0i65': {
      'es': 'Evento Financiero',
      'en': 'Financial Event',
    },
    'ekrspbsx': {
      'es': 'Tipo',
      'en': 'Type',
    },
    '5s26bm7s': {
      'es': 'Seleccionar...',
      'en': 'Select...',
    },
    'e5ouairp': {
      'es': 'Search...',
      'en': 'Search...',
    },
    'fjn4emrs': {
      'es': 'Cierre de ciclo (estado de cuenta) de  tarjeta de crédito',
      'en': 'Credit card cycle closing (statement)',
    },
    'w8ds775y': {
      'es': 'Fecha limite de pago de tarjeta de crédito',
      'en': 'Credit Card Statement Closing Date',
    },
    '1wvjypr7': {
      'es': 'Otro',
      'en': 'Other',
    },
    'ie1gjvn1': {
      'es': 'Descripción ',
      'en': 'Description',
    },
    'c8rfxqzp': {
      'es': 'Nombre del banco y cuatro últimos dígitos de la targeta..',
      'en': 'Name of the bank and last four digits of the card.',
    },
    'alqrlo4d': {
      'es': 'Evento recurrente',
      'en': 'Recurring event',
    },
    'alg1ltuz': {
      'es': 'Frecuencia',
      'en': 'Frequency',
    },
    'zr4by6bw': {
      'es': 'Seleccionar...',
      'en': 'Select...',
    },
    'bjn6w02x': {
      'es': 'Search...',
      'en': 'Search...',
    },
    'utewsfzs': {
      'es': 'Diario',
      'en': 'Daily',
    },
    'y17xqvb6': {
      'es': 'Semanal',
      'en': 'Weekly',
    },
    'qliqd8zo': {
      'es': 'Quincenal',
      'en': 'Biweekly',
    },
    'zn36t7uw': {
      'es': 'Mensual',
      'en': 'Monthly',
    },
    '16o9kigl': {
      'es': 'Trimestral',
      'en': 'Quarterly',
    },
    'h43t1ni5': {
      'es': 'Anual',
      'en': 'Annual',
    },
    'v49qdiqx': {
      'es': 'Ajustes de Notificación',
      'en': 'Notification Settings',
    },
    'daxv087m': {
      'es': '( Horas de antelación para recibir la notificación )',
      'en': '(Hours in advance to receive the notification)',
    },
    'eh9begc8': {
      'es': '72',
      'en': '72',
    },
    'cyr55hqe': {
      'es': '',
      'en': '',
    },
    'i5k6ghve': {
      'es': 'Buscar...',
      'en': 'Search...',
    },
    'g85j171q': {
      'es': '24',
      'en': '24',
    },
    '7uxmqv24': {
      'es': '48',
      'en': '48',
    },
    'q63ajx2e': {
      'es': '72',
      'en': '72',
    },
    'nwoqfxi4': {
      'es': '96',
      'en': '96',
    },
    'k61bc7u6': {
      'es': 'Añadir',
      'en': 'Add',
    },
  },
  // ajustes
  {
    'rzj8w5zb': {
      'es': 'Este evento se repite ',
      'en': 'This is a recurring event',
    },
    '5htws18q': {
      'es': 'Categoría',
      'en': 'Category',
    },
    'q11x5wpe': {
      'es': 'Información del Comercio',
      'en': 'Merchant Information',
    },
    'hgqd25cj': {
      'es': 'Nombre: ',
      'en': 'Name:',
    },
    'urv07qc8': {
      'es': 'ID: ',
      'en': 'ID:',
    },
    'y3m7hivo': {
      'es': 'Sitio Web: ',
      'en': 'Website:',
    },
    'gb1i2ycp': {
      'es': 'Este evento esta vinculado a una Meta Financiera',
      'en': 'This event is linked to a Financial Goal',
    },
    'a6cfjds7': {
      'es':
          'Si desea Editar o Eliminar este evento debe de hacerlo en el apartado Metas Financieras en la meta correspondiente.',
      'en':
          'If you wish to edit or delete this event, you must do so in the Financial Goals section under the corresponding goal.',
    },
    'mbp5inri': {
      'es': 'Editar Evento',
      'en': 'Edit Event',
    },
    'xt65smba': {
      'es': 'Eliminar Evento',
      'en': 'Delete Event',
    },
  },
  // eliminar
  {
    '311n6bnj': {
      'es': '¿Deseas eliminar este evento?',
      'en': 'Do you want to delete this event?',
    },
    'j1jirkqa': {
      'es': 'Eliminar también eventos recurrentes.',
      'en': 'Also delete recurring events',
    },
    'cw6gcryb': {
      'es': 'Cancelar Acción',
      'en': 'Cancel Action',
    },
    'jsf6kq6a': {
      'es': 'Eliminar Evento',
      'en': 'Delete Event',
    },
  },
  // eliminarCuenta
  {
    'ozu0i2js': {
      'es': '¿Deseas eliminar esta cuenta?',
      'en': 'Do you want to delete this account?',
    },
    '8l0pv8x6': {
      'es':
          'Si elimina esta cuenta, se eliminará también la lista de  eventos asociados a la misma.',
      'en':
          'If you delete this account, the list of events associated with it will also be deleted.',
    },
    'a30agwif': {
      'es': 'Cancelar Acción',
      'en': 'Cancel Action',
    },
    'leyyj51n': {
      'es': 'Eliminar Cuenta',
      'en': 'Delete Account',
    },
  },
  // AjustesdeNoti
  {
    'y2s20spp': {
      'es': 'Ajustes de Notificaciones',
      'en': 'Notification Settings',
    },
    'jdquut14': {
      'es':
          'Todas las notificaciones han sido configuradas para ejecutarse 72 horas previas a cada evento en el calendario y su modificación no está disponibles para este plan.',
      'en':
          'All notifications are set to trigger 72 hours before each calendar event, and cannot be modified under this plan.',
    },
    'p3md6mhg': {
      'es': 'Ajustes globales',
      'en': 'Global Settings',
    },
    'hu3iiofh': {
      'es': '',
      'en': '',
    },
    'yyrqp7ub': {
      'es': 'Buscar...',
      'en': 'Search...',
    },
    '6blvw7yu': {
      'es': 'Predeterminado ( Un mismo tiempo para todas las notificaciones )',
      'en': 'Default (Same time for all notifications)',
    },
    'ij5wenm2': {
      'es': 'Independiente ( Cada evento define su tiempo de notificación )',
      'en': 'Independent (Each event defines its own notification time)',
    },
    'ezdvlokr': {
      'es': 'Horas de antelación',
      'en': 'Hours in advance',
    },
    'dl12wnw8': {
      'es': '',
      'en': '',
    },
    'p7on21fc': {
      'es': 'Buscar...',
      'en': 'Search...',
    },
    '4o8tqkh9': {
      'es': '24',
      'en': '24',
    },
    'bco6eskt': {
      'es': '48',
      'en': '48',
    },
    'j2741zrr': {
      'es': '72',
      'en': '72',
    },
    'oji9nq5r': {
      'es': '96',
      'en': '96',
    },
    '939lghj0': {
      'es': 'Aceptar',
      'en': 'Accept',
    },
  },
  // terminos
  {
    'oq59rmz6': {
      'es': 'Términos del Servicio ',
      'en': 'Terms of Service',
    },
    '5ivxvsyj': {
      'es':
          'Última actualización: Mayo 2026\n\nBienvenido a Gold Up.\n\nAl acceder o utilizar esta aplicación, usted acepta cumplir y quedar legalmente vinculado por estos Términos de Servicio. Si no está de acuerdo con alguna parte de estos términos, por favor no utilice la aplicación.\n\n1. Descripción del Servicio\n\nGold Up es una aplicación de organización y planificación financiera diseñada para ayudar a los usuarios a gestionar eventos financieros, ingresos, gastos, facturas, metas de ahorro y planificación financiera mensual mediante herramientas interactivas y funciones basadas en calendario.\n\nGold Up no es un banco, institución financiera, prestamista ni proveedor de asesoramiento financiero, legal o fiscal profesional. La información proporcionada por la aplicación tiene fines exclusivamente organizativos e informativos.\n\n2. Uso Responsable\n\nAl utilizar Gold Up, usted acepta:\n\nProporcionar información precisa y veraz.\nUtilizar la aplicación únicamente con fines legales y personales.\nNo intentar interferir, manipular, alterar, interrumpir, realizar ingeniería inversa o comprometer el funcionamiento, la seguridad o los sistemas de la aplicación.\n3. Exactitud de la Información\n\nGold Up organiza y procesa información financiera en función de los datos proporcionados por el usuario.\n\nSin embargo:\n\nGold Up no garantiza la exactitud de cálculos, proyecciones o recomendaciones si se ingresan datos incorrectos o incompletos.\nLas estimaciones y proyecciones financieras son únicamente informativas y no constituyen asesoramiento financiero.\nEl usuario es el único responsable de la exactitud de la información proporcionada y de cualquier decisión financiera tomada con base en la información presentada por la aplicación.\n4. Privacidad y Uso de Datos\n\nGold Up valora la privacidad de sus usuarios.\n\nLa información del usuario se maneja de acuerdo con nuestra Política de Privacidad y se utiliza únicamente para la operación, mantenimiento, seguridad y mejora de la aplicación.\n\nGold Up no vende información personal de sus usuarios. Sin embargo, ciertos proveedores de servicios externos (como proveedores de alojamiento, análisis, autenticación, pagos o infraestructura) pueden procesar datos cuando sea necesario para el funcionamiento de la aplicación.\n\n5. Disponibilidad del Servicio\n\nNos esforzamos por mantener Gold Up disponible y funcionando de manera confiable en todo momento.\n\nSin embargo, no garantizamos disponibilidad ininterrumpida. Pueden producirse interrupciones debido a:\n\nMantenimiento\nActualizaciones\nFallos técnicos\nInterrupciones de servicios de terceros\nCircunstancias fuera de nuestro control\n6. Limitación de Responsabilidad\n\nEn la máxima medida permitida por la ley, Gold Up no será responsable por:\n\nPérdidas financieras derivadas del uso o imposibilidad de uso de la aplicación\nErrores causados por información incorrecta proporcionada por el usuario\nInterrupciones del servicio, retrasos o indisponibilidad temporal\nFallos técnicos, errores de software o pérdida de datos\nDecisiones financieras tomadas por los usuarios con base en la información presentada en la aplicación\n\nEl uso de la aplicación es bajo su propio riesgo.\n\n7. Suscripciones y Funciones de Pago\n\nAlgunas funciones de Gold Up pueden requerir una suscripción de pago.\n\nAl adquirir una suscripción, usted acepta que:\n\nLos precios pueden cambiar cuando la ley aplicable lo permita o requiera notificación.\nLa facturación de suscripciones es gestionada por la plataforma correspondiente (como Apple App Store o Google Play).\nLas renovaciones y cancelaciones de suscripciones se rigen por las políticas de la plataforma donde se realizó la compra.\nLos reembolsos están sujetos a las políticas de reembolso de la plataforma correspondiente.\n8. Actualizaciones y Cambios\n\nNos reservamos el derecho de modificar, actualizar o reemplazar estos Términos de Servicio en cualquier momento.\n\nEl uso continuado de Gold Up después de que los cambios entren en vigor constituye aceptación de los términos actualizados.\n\n9. Suspensión o Terminación\n\nNos reservamos el derecho de suspender, restringir o cancelar el acceso de cualquier usuario a nuestra discreción si:\n\nSe violan estos términos\nSe detecta actividad fraudulenta o abusiva\nSe identifican riesgos de seguridad\nEl uso de la aplicación puede causar daño a la plataforma o a otros usuarios\n10. Propiedad Intelectual\n\nTodo el contenido de la aplicación, marca, diseño, interfaz, lógica del software, funcionalidades, estructura, textos y materiales relacionados son propiedad exclusiva de Gold Up o sus licenciantes y están protegidos por las leyes aplicables de propiedad intelectual.\n\nLos usuarios no podrán copiar, reproducir, distribuir, modificar ni explotar ninguna parte de la aplicación sin autorización previa por escrito.\n\n11. Servicios de Terceros\n\nGold Up puede integrar o depender de servicios de terceros, incluyendo, entre otros:\n\nProcesadores de pago\nProveedores de autenticación\nProveedores de infraestructura en la nube\nHerramientas de análisis\nProveedores de conexión bancaria\n\nGold Up no es responsable por la disponibilidad, políticas o acciones de servicios de terceros.\n\n12. Legislación Aplicable\n\nEstos Términos de Servicio se regirán e interpretarán de conformidad con las leyes de los Estados Unidos y del Estado de Wyoming, sin considerar principios de conflicto de leyes.\n\n13. Contacto\n\nSi tiene preguntas, inquietudes o solicitudes de soporte, puede contactarnos a través de la sección de soporte dentro de la aplicación o mediante nuestros canales oficiales de contacto.\n\nAl utilizar Gold Up, usted confirma que ha leído, comprendido y aceptado estos Términos de Servicio.',
      'en':
          'Last updated: May 2026\n\nWelcome to Gup Calendar.\n\nBy using this application, you agree to comply with and be legally bound by the following Terms of Service. If you do not agree to any of these terms, please do not use the application.\n\n1. Service Description\n\nGup Calendar is an application designed to help users organize their financial events, income, expenses, bills, and monthly planning using an interactive calendar and personal Welcome to Gold Up.\n\nBy accessing or using this application, you agree to comply with and be legally bound by these Terms of Service. If you do not agree with any part of these terms, please do not use the application.\n\n1. Service Description\n\nGold Up is a financial organization and planning application designed to help users manage financial events, income, expenses, bills, savings goals, and monthly financial planning through interactive tools and calendar-based features.\n\nGold Up is not a bank, financial institution, lender, or provider of professional financial, legal, or tax advice. The information provided by the application is for organizational and informational purposes only.\n\n2. Responsible Use\n\nBy using Gold Up, you agree to:\n\nProvide accurate and truthful information.\nUse the application only for lawful and personal purposes.\nNot attempt to interfere with, manipulate, disrupt, reverse engineer, or compromise the application, its systems, or its security.\n3. Accuracy of Information\n\nGold Up organizes and processes financial information based on the data entered by the user.\n\nHowever:\n\nGold Up does not guarantee the accuracy of calculations, forecasts, or recommendations if incorrect or incomplete data is entered.\nFinancial estimates and projections are informational only and should not be considered financial advice.\nUsers are solely responsible for the accuracy of the information they provide and for any financial decisions made based on the application.\n4. Privacy and Data Use\n\nGold Up values user privacy.\n\nUser information is handled in accordance with our Privacy Policy and is used only for the operation, maintenance, security, and improvement of the application.\n\nGold Up does not sell users’ personal information. However, certain third-party service providers (such as hosting, analytics, authentication, payment, or infrastructure providers) may process data as necessary to support the application.\n\n5. Service Availability\n\nWe strive to keep Gold Up available and functioning reliably at all times.\n\nHowever, we do not guarantee uninterrupted availability. Service interruptions may occur due to:\n\nMaintenance\nUpdates\nTechnical failures\nThird-party outages\nCircumstances beyond our control\n6. Limitation of Liability\n\nTo the maximum extent permitted by law, Gold Up shall not be liable for:\n\nFinancial losses resulting from the use or inability to use the application\nErrors caused by inaccurate user-provided information\nService interruptions, delays, or temporary unavailability\nTechnical malfunctions, software bugs, or data loss\nFinancial decisions made by users based on information presented in the application\n\nUse of the application is at your own risk.\n\n7. Subscription and Paid Features\n\nCertain features of Gold Up may require a paid subscription.\n\nBy purchasing a subscription, you agree that:\n\nPricing may change with notice where required by law.\nSubscription billing is managed through the applicable platform provider (such as Apple App Store or Google Play).\nSubscription renewals and cancellations are governed by the policies of the platform through which the subscription was purchased.\nRefunds are subject to the applicable platform’s refund policies.\n8. Updates and Changes\n\nWe reserve the right to modify, update, or replace these Terms of Service at any time.\n\nContinued use of Gold Up after changes become effective constitutes acceptance of the updated terms.\n\n9. Suspension or Termination\n\nWe reserve the right to suspend, restrict, or terminate user access at our discretion if:\n\nThese terms are violated\nFraudulent or abusive activity is detected\nSecurity risks are identified\nUse of the application may cause harm to the platform or other users\n10. Intellectual Property\n\nAll application content, branding, design, interface, software logic, functionality, structure, text, and related materials are the exclusive property of Gold Up or its licensors and are protected by applicable intellectual property laws.\n\nUsers may not copy, reproduce, distribute, modify, or exploit any part of the application without written authorization.\n\n11. Third-Party Services\n\nGold Up may integrate or rely on third-party services, including but not limited to:\n\nPayment processors\nAuthentication providers\nCloud infrastructure providers\nAnalytics tools\nBanking connectivity providers\n\nGold Up is not responsible for the availability, policies, or actions of third-party services.\n\n12. Governing Law\n\nThese Terms of Service shall be governed and interpreted in accordance with the laws of the United States and the State of Wyoming, without regard to conflict of law principles.\n\n13. Contact\n\nIf you have questions, concerns, or support requests, please contact us through the support section within the application or through our official contact channels.\n\nBy using Gold Up, you confirm that you have read, understood, and accepted these Terms of Service.',
    },
    'lngfke8o': {
      'es': 'Aceptar',
      'en': 'Accept',
    },
  },
  // Politica
  {
    'pej0j2zm': {
      'es': 'Política de Privacidad',
      'en': 'Privacy Policy',
    },
    'udw5vd2s': {
      'es':
          'Última actualización: 23 de mayo de 2026\n\nGold Up Group LLC (\"Gold Up\", \"nosotros\", \"nuestro\" o \"la empresa\") opera la aplicación móvil Gold Up (la \"Aplicación\").\n\nEsta Política de Privacidad describe cómo recopilamos, usamos, protegemos y compartimos su información cuando utiliza nuestra Aplicación.\n\nAl utilizar Gold Up, usted acepta las prácticas descritas en esta Política de Privacidad.\n\n1. Información que Recopilamos\n\nPodemos recopilar los siguientes tipos de información:\n\nInformación Personal\nNombre completo\nDirección de correo electrónico\nNúmero de teléfono\nCredenciales de acceso autenticadas\nInformación de perfil del usuario\nInformación Financiera\nInformación de cuentas bancarias (a través de proveedores externos autorizados como Plaid)\nHistorial de transacciones\nSaldos de cuentas\nInformación de tarjetas de crédito o débito conectadas\nMetas financieras, presupuestos y datos de ahorro\nInformación financiera ingresada manualmente por el usuario\nInformación del Dispositivo y Uso\nTipo de dispositivo\nSistema operativo\nDirección IP\nIdentificadores del dispositivo\nDatos de uso dentro de la aplicación\nRegistros de actividad y eventos\nInformación técnica para diagnóstico y seguridad\n2. Cómo Utilizamos su Información\n\nUtilizamos la información recopilada para:\n\nProporcionar, operar y mantener la Aplicación\nConectar y mostrar sus cuentas financieras\nProcesar y organizar información financiera\nAnalizar ingresos, gastos, presupuestos y hábitos financieros\nAyudar en la gestión de metas financieras y planificación económica\nGenerar recordatorios, alertas y notificaciones\nMejorar nuestros servicios, funciones y experiencia del usuario\nDetectar, prevenir e investigar actividades fraudulentas o riesgos de seguridad\nCumplir con obligaciones legales o regulatorias\n3. Servicios de Terceros\n\nGold Up puede utilizar servicios de terceros para operar determinadas funciones.\n\nEstos pueden incluir:\n\nPlaid — para conexión segura con instituciones financieras\nGoogle Firebase — autenticación, almacenamiento de datos, infraestructura y análisis\nApple App Store — distribución y gestión de suscripciones en iOS\nGoogle Play Store — distribución y gestión de suscripciones en Android\nServicios de notificaciones push — envío de recordatorios y alertas\nProveedores de procesamiento de pagos cuando corresponda\n\nEstos terceros operan bajo sus propias políticas de privacidad.\n\n4. Seguridad de la Información\n\nImplementamos medidas técnicas, administrativas y organizativas razonables para proteger la información del usuario contra acceso no autorizado, pérdida, alteración, divulgación o uso indebido.\n\nSin embargo, ningún sistema de transmisión o almacenamiento electrónico puede garantizar seguridad absoluta.\n\n5. Compartición de Datos\n\nGold Up no vende información personal de los usuarios.\n\nPodemos compartir información únicamente en los siguientes casos:\n\nCon proveedores de servicios confiables necesarios para operar la Aplicación\nPara cumplir obligaciones legales, regulatorias o requerimientos gubernamentales\nPara investigar fraudes, actividades sospechosas o incidentes de seguridad\nPara proteger nuestros derechos legales, usuarios o infraestructura\nEn caso de reorganización empresarial, fusión, adquisición o venta de activos\n6. Control y Derechos del Usuario\n\nDependiendo de la jurisdicción aplicable, usted puede tener derecho a:\n\nAcceder a su información personal\nSolicitar correcciones de datos incorrectos\nSolicitar la eliminación de su cuenta y datos asociados\nDesconectar cuentas bancarias vinculadas\nGestionar preferencias de notificaciones\nSolicitar restricciones sobre ciertos usos de sus datos cuando aplique\n\nEstas acciones pueden realizarse desde la Aplicación o contactándonos.\n\n7. Retención de Datos\n\nConservamos la información personal únicamente durante el tiempo necesario para:\n\nProporcionar nuestros servicios\nCumplir obligaciones legales\nResolver disputas\nHacer cumplir nuestros acuerdos\nMantener seguridad operativa y auditoría interna\n8. Privacidad de Menores\n\nGold Up no está dirigida a menores de 13 años.\n\nNo recopilamos intencionalmente información personal de menores. Si detectamos que se ha recopilado información de un menor sin autorización adecuada, tomaremos medidas razonables para eliminarla.\n\n9. Transferencias Internacionales de Datos\n\nDependiendo de la ubicación del usuario, la información puede ser procesada o almacenada en servidores ubicados en Estados Unidos u otras jurisdicciones donde operen nuestros proveedores de servicios.\n\nAl utilizar Gold Up, usted acepta dicha transferencia y procesamiento.\n\n10. Cambios en esta Política\n\nPodemos modificar esta Política de Privacidad en cualquier momento.\n\nCuando se realicen cambios importantes, actualizaremos la fecha de \"Última actualización\" y publicaremos la nueva versión dentro de la Aplicación.\n\nEl uso continuo de Gold Up después de dichos cambios constituye aceptación de la política actualizada.\n\n11. Contacto\n\nSi tiene preguntas, solicitudes o inquietudes relacionadas con privacidad o protección de datos, puede contactarnos:\n\nGold Up Group LLC\n30 N Gould St Ste N\nSheridan, WY 82801\nUnited States\n\nCorreo electrónico:',
      'en':
          'Last Updated: May 23, 2026\n\nGold Up Group LLC (\"Gold Up,\" \"we,\" \"our,\" or \"the Company\") operates the Gold Up mobile application (the \"Application\").\n\nThis Privacy Policy explains how we collect, use, protect, and share your information when you use our Application.\n\nBy using Gold Up, you agree to the practices described in this Privacy Policy.\n\n1. Information We Collect\n\nWe may collect the following types of information:\n\nPersonal Information\nFull name\nEmail address\nPhone number\nAuthenticated login credentials\nUser profile information\nFinancial Information\nBank account information (through authorized third-party providers such as Plaid)\nTransaction history\nAccount balances\nConnected credit or debit card information\nFinancial goals, budgets, and savings data\nFinancial information manually entered by the user\nDevice and Usage Information\nDevice type\nOperating system\nIP address\nDevice identifiers\nApplication usage data\nActivity logs and event records\nTechnical diagnostic and security information\n2. How We Use Your Information\n\nWe use the collected information to:\n\nProvide, operate, and maintain the Application\nConnect and display your financial accounts\nProcess and organize financial information\nAnalyze income, expenses, budgets, and spending habits\nHelp manage financial goals and planning\nGenerate reminders, alerts, and notifications\nImprove our services, features, and user experience\nDetect, prevent, and investigate fraud or security threats\nComply with legal or regulatory obligations\n3. Third-Party Services\n\nGold Up may use third-party services to provide certain features and infrastructure.\n\nThese may include:\n\nPlaid — secure connection to financial institutions\nGoogle Firebase — authentication, database infrastructure, storage, analytics, and backend services\nApple App Store — iOS distribution and subscription management\nGoogle Play Store — Android distribution and subscription management\nPush notification providers — reminders and alerts\nPayment processing providers, where applicable\n\nThese third parties operate under their own privacy policies.\n\n4. Information Security\n\nWe implement reasonable technical, administrative, and organizational safeguards to protect user information against unauthorized access, loss, misuse, alteration, disclosure, or destruction.\n\nHowever, no method of electronic transmission or storage can be guaranteed to be completely secure.\n\n5. Data Sharing\n\nGold Up does not sell users’ personal information.\n\nWe may share information only in the following circumstances:\n\nWith trusted service providers necessary to operate the Application\nTo comply with legal obligations, court orders, or regulatory requirements\nTo detect, investigate, or prevent fraud, abuse, or security incidents\nTo protect our legal rights, users, systems, or infrastructure\nIn connection with a merger, acquisition, restructuring, or sale of business assets\n6. User Rights and Controls\n\nDepending on applicable law, you may have the right to:\n\nAccess your personal information\nRequest correction of inaccurate data\nRequest deletion of your account and associated information\nDisconnect linked financial accounts\nManage notification preferences\nRequest restrictions on certain processing activities where applicable\n\nThese actions may be available through the Application or by contacting us.\n\n7. Data Retention\n\nWe retain personal information only for as long as reasonably necessary to:\n\nProvide our services\nFulfill legal obligations\nResolve disputes\nEnforce agreements\nMaintain operational security and internal auditing requirements\n8. Children\'s Privacy\n\nGold Up is not intended for children under the age of 13.\n\nWe do not knowingly collect personal information from children. If we become aware that such information has been collected without appropriate authorization, we will take reasonable steps to delete it.\n\n9. International Data Transfers\n\nDepending on your location, your information may be processed or stored on servers located in the United States or other jurisdictions where our service providers operate.\n\nBy using Gold Up, you consent to such transfer, storage, and processing.\n\n10. Changes to This Privacy Policy\n\nWe may update this Privacy Policy at any time.\n\nIf material changes are made, we will update the \"Last Updated\" date and publish the revised version within the Application.\n\nContinued use of Gold Up after such updates constitutes acceptance of the revised Privacy Policy.\n\n11. Contact Information\n\nIf you have questions, privacy concerns, or data-related requests, please contact us:\n\nGold Up Group LLC\n30 N Gould St Ste N\nSheridan, WY 82801\nUnited States\n\nEmail:',
    },
    'v8f93lno': {
      'es': ' support@goldupgroup.com',
      'en': 'support@goldupgroup.com',
    },
    'ie6pk4yp': {
      'es':
          'Última actualización: 26 de marzo de 2026\n\nGold Up Group LLC (\"nosotros\", \"nuestro\" o \"la empresa\") opera la aplicación móvil Gold Up (la Última actualización: 23 de mayo de 2026\n\nGold Up Group LLC (\"Gold Up\", \"nosotros\", \"nuestro\" o \"la empresa\") opera la aplicación móvil Gold Up (la \"Aplicación\").\n\nEsta Política de Privacidad describe cómo recopilamos, usamos, protegemos y compartimos su información cuando utiliza nuestra Aplicación.\n\nAl utilizar Gold Up, usted acepta las prácticas descritas en esta Política de Privacidad.\n\n1. Información que Recopilamos\n\nPodemos recopilar los siguientes tipos de información:\n\nInformación Personal\nNombre completo\nDirección de correo electrónico\nNúmero de teléfono\nCredenciales de acceso autenticadas\nInformación de perfil del usuario\nInformación Financiera\nInformación de cuentas bancarias (a través de proveedores externos autorizados como Plaid)\nHistorial de transacciones\nSaldos de cuentas\nInformación de tarjetas de crédito o débito conectadas\nMetas financieras, presupuestos y datos de ahorro\nInformación financiera ingresada manualmente por el usuario\nInformación del Dispositivo y Uso\nTipo de dispositivo\nSistema operativo\nDirección IP\nIdentificadores del dispositivo\nDatos de uso dentro de la aplicación\nRegistros de actividad y eventos\nInformación técnica para diagnóstico y seguridad\n2. Cómo Utilizamos su Información\n\nUtilizamos la información recopilada para:\n\nProporcionar, operar y mantener la Aplicación\nConectar y mostrar sus cuentas financieras\nProcesar y organizar información financiera\nAnalizar ingresos, gastos, presupuestos y hábitos financieros\nAyudar en la gestión de metas financieras y planificación económica\nGenerar recordatorios, alertas y notificaciones\nMejorar nuestros servicios, funciones y experiencia del usuario\nDetectar, prevenir e investigar actividades fraudulentas o riesgos de seguridad\nCumplir con obligaciones legales o regulatorias\n3. Servicios de Terceros\n\nGold Up puede utilizar servicios de terceros para operar determinadas funciones.\n\nEstos pueden incluir:\n\nPlaid — para conexión segura con instituciones financieras\nGoogle Firebase — autenticación, almacenamiento de datos, infraestructura y análisis\nApple App Store — distribución y gestión de suscripciones en iOS\nGoogle Play Store — distribución y gestión de suscripciones en Android\nServicios de notificaciones push — envío de recordatorios y alertas\nProveedores de procesamiento de pagos cuando corresponda\n\nEstos terceros operan bajo sus propias políticas de privacidad.\n\n4. Seguridad de la Información\n\nImplementamos medidas técnicas, administrativas y organizativas razonables para proteger la información del usuario contra acceso no autorizado, pérdida, alteración, divulgación o uso indebido.\n\nSin embargo, ningún sistema de transmisión o almacenamiento electrónico puede garantizar seguridad absoluta.\n\n5. Compartición de Datos\n\nGold Up no vende información personal de los usuarios.\n\nPodemos compartir información únicamente en los siguientes casos:\n\nCon proveedores de servicios confiables necesarios para operar la Aplicación\nPara cumplir obligaciones legales, regulatorias o requerimientos gubernamentales\nPara investigar fraudes, actividades sospechosas o incidentes de seguridad\nPara proteger nuestros derechos legales, usuarios o infraestructura\nEn caso de reorganización empresarial, fusión, adquisición o venta de activos\n6. Control y Derechos del Usuario\n\nDependiendo de la jurisdicción aplicable, usted puede tener derecho a:\n\nAcceder a su información personal\nSolicitar correcciones de datos incorrectos\nSolicitar la eliminación de su cuenta y datos asociados\nDesconectar cuentas bancarias vinculadas\nGestionar preferencias de notificaciones\nSolicitar restricciones sobre ciertos usos de sus datos cuando aplique\n\nEstas acciones pueden realizarse desde la Aplicación o contactándonos.\n\n7. Retención de Datos\n\nConservamos la información personal únicamente durante el tiempo necesario para:\n\nProporcionar nuestros servicios\nCumplir obligaciones legales\nResolver disputas\nHacer cumplir nuestros acuerdos\nMantener seguridad operativa y auditoría interna\n8. Privacidad de Menores\n\nGold Up no está dirigida a menores de 13 años.\n\nNo recopilamos intencionalmente información personal de menores. Si detectamos que se ha recopilado información de un menor sin autorización adecuada, tomaremos medidas razonables para eliminarla.\n\n9. Transferencias Internacionales de Datos\n\nDependiendo de la ubicación del usuario, la información puede ser procesada o almacenada en servidores ubicados en Estados Unidos u otras jurisdicciones donde operen nuestros proveedores de servicios.\n\nAl utilizar Gold Up, usted acepta dicha transferencia y procesamiento.\n\n10. Cambios en esta Política\n\nPodemos modificar esta Política de Privacidad en cualquier momento.\n\nCuando se realicen cambios importantes, actualizaremos la fecha de \"Última actualización\" y publicaremos la nueva versión dentro de la Aplicación.\n\nEl uso continuo de Gold Up después de dichos cambios constituye aceptación de la política actualizada.\n\n11. Contacto\n\nSi tiene preguntas, solicitudes o inquietudes relacionadas con privacidad o protección de datos, puede contactarnos:\n\nGold Up Group LLC\n30 N Gould St Ste N\nSheridan, WY 82801\nUnited States\n\nCorreo electrónico:',
      'en':
          'Last updated: March 26, 2026\n\nGold Up Group LLC (“we,” “our,” or “the company”) operates the Gold Up mobile application (the “App”). This Privacy Policy describes how we Last Updated: May 23, 2026\n\nGold Up Group LLC (\"Gold Up,\" \"we,\" \"our,\" or \"the Company\") operates the Gold Up mobile application (the \"Application\").\n\nThis Privacy Policy explains how we collect, use, protect, and share your information when you use our Application.\n\nBy using Gold Up, you agree to the practices described in this Privacy Policy.\n\n1. Information We Collect\n\nWe may collect the following types of information:\n\nPersonal Information\nFull name\nEmail address\nPhone number\nAuthenticated login credentials\nUser profile information\nFinancial Information\nBank account information (through authorized third-party providers such as Plaid)\nTransaction history\nAccount balances\nConnected credit or debit card information\nFinancial goals, budgets, and savings data\nFinancial information manually entered by the user\nDevice and Usage Information\nDevice type\nOperating system\nIP address\nDevice identifiers\nApplication usage data\nActivity logs and event records\nTechnical diagnostic and security information\n2. How We Use Your Information\n\nWe use the collected information to:\n\nProvide, operate, and maintain the Application\nConnect and display your financial accounts\nProcess and organize financial information\nAnalyze income, expenses, budgets, and spending habits\nHelp manage financial goals and planning\nGenerate reminders, alerts, and notifications\nImprove our services, features, and user experience\nDetect, prevent, and investigate fraud or security threats\nComply with legal or regulatory obligations\n3. Third-Party Services\n\nGold Up may use third-party services to provide certain features and infrastructure.\n\nThese may include:\n\nPlaid — secure connection to financial institutions\nGoogle Firebase — authentication, database infrastructure, storage, analytics, and backend services\nApple App Store — iOS distribution and subscription management\nGoogle Play Store — Android distribution and subscription management\nPush notification providers — reminders and alerts\nPayment processing providers, where applicable\n\nThese third parties operate under their own privacy policies.\n\n4. Information Security\n\nWe implement reasonable technical, administrative, and organizational safeguards to protect user information against unauthorized access, loss, misuse, alteration, disclosure, or destruction.\n\nHowever, no method of electronic transmission or storage can be guaranteed to be completely secure.\n\n5. Data Sharing\n\nGold Up does not sell users’ personal information.\n\nWe may share information only in the following circumstances:\n\nWith trusted service providers necessary to operate the Application\nTo comply with legal obligations, court orders, or regulatory requirements\nTo detect, investigate, or prevent fraud, abuse, or security incidents\nTo protect our legal rights, users, systems, or infrastructure\nIn connection with a merger, acquisition, restructuring, or sale of business assets\n6. User Rights and Controls\n\nDepending on applicable law, you may have the right to:\n\nAccess your personal information\nRequest correction of inaccurate data\nRequest deletion of your account and associated information\nDisconnect linked financial accounts\nManage notification preferences\nRequest restrictions on certain processing activities where applicable\n\nThese actions may be available through the Application or by contacting us.\n\n7. Data Retention\n\nWe retain personal information only for as long as reasonably necessary to:\n\nProvide our services\nFulfill legal obligations\nResolve disputes\nEnforce agreements\nMaintain operational security and internal auditing requirements\n8. Children\'s Privacy\n\nGold Up is not intended for children under the age of 13.\n\nWe do not knowingly collect personal information from children. If we become aware that such information has been collected without appropriate authorization, we will take reasonable steps to delete it.\n\n9. International Data Transfers\n\nDepending on your location, your information may be processed or stored on servers located in the United States or other jurisdictions where our service providers operate.\n\nBy using Gold Up, you consent to such transfer, storage, and processing.\n\n10. Changes to This Privacy Policy\n\nWe may update this Privacy Policy at any time.\n\nIf material changes are made, we will update the \"Last Updated\" date and publish the revised version within the Application.\n\nContinued use of Gold Up after such updates constitutes acceptance of the revised Privacy Policy.\n\n11. Contact Information\n\nIf you have questions, privacy concerns, or data-related requests, please contact us:\n\nGold Up Group LLC\n30 N Gould St Ste N\nSheridan, WY 82801\nUnited States\n\nEmail:',
    },
    'm7ymz0dp': {
      'es': 'Aceptar',
      'en': 'Accept',
    },
  },
  // CerrarSesi
  {
    'goa5fqqw': {
      'es': '¿Deseas cerrar la sesión?',
      'en': 'Do you want to log out?',
    },
    'i0py4fim': {
      'es': 'Cancelar ',
      'en': 'Cancel',
    },
    'xk2dpoag': {
      'es': 'Aceptar',
      'en': 'Accept',
    },
  },
  // EditarEvento
  {
    'dxsdhlib': {
      'es': 'Editar Evento',
      'en': 'Edit Event',
    },
    'ittwj46r': {
      'es': 'Tipo',
      'en': 'Type',
    },
    'paumplas': {
      'es': 'Descripción (opcional)',
      'en': 'Description (optional)',
    },
    '2pb67126': {
      'es': 'Puedes dejar una breve descripción...',
      'en': 'You can leave a brief description...',
    },
    '6agbstzt': {
      'es': 'Monto ',
      'en': 'Amount',
    },
    'n0s4p3f0': {
      'es': 'Cantidad del efectivo...',
      'en': 'Amount of cash...',
    },
    'uc28cxro': {
      'es': 'Editar también todas las recurrencias',
      'en': 'Also edit all recurring events',
    },
    'mm40ygy0': {
      'es': 'Frecuencia',
      'en': 'Frequency',
    },
    'hildixv2': {
      'es': 'Seleccionar...',
      'en': 'Select...',
    },
    'pag61r7y': {
      'es': 'Buscar...',
      'en': 'Search...',
    },
    'zmnw3pdx': {
      'es': 'Diario',
      'en': 'Daily',
    },
    'fbupax7r': {
      'es': 'Semanal',
      'en': 'Weekly',
    },
    'pa0leuxr': {
      'es': 'Quincenal',
      'en': 'Biweekly',
    },
    'jopkbkj0': {
      'es': 'Mensual',
      'en': 'Monthly',
    },
    'qnirlmj3': {
      'es': 'Trimestral',
      'en': 'Quarterly',
    },
    'xxj5kcqe': {
      'es': 'Anual',
      'en': 'Annual',
    },
    'qiijo0z7': {
      'es': 'Ajustes de Notificación',
      'en': 'Notification Settings',
    },
    '5zpt7j0h': {
      'es': '( Horas de antelación para recibir la notificación )',
      'en': '( Hours in advance to receive the notification)',
    },
    'k97rdoxo': {
      'es': '',
      'en': '',
    },
    'zvh5jcff': {
      'es': 'Buscar...',
      'en': 'Search...',
    },
    'qb7iolo4': {
      'es': '24',
      'en': '24',
    },
    'y140w7ib': {
      'es': '48',
      'en': '48',
    },
    'kcyv5x67': {
      'es': '72',
      'en': '72',
    },
    'g89o8tzx': {
      'es': '96',
      'en': '96',
    },
    'u7rmh6bb': {
      'es': 'Editar',
      'en': 'Edit',
    },
  },
  // Save
  {
    '4w1pry29': {
      'es': 'Ahorros',
      'en': 'Savings',
    },
    '4b7ln67a': {
      'es': 'Tipo',
      'en': 'Type',
    },
    '3yox849c': {
      'es': 'Seleccionar...',
      'en': 'Select...',
    },
    'c70zmaqk': {
      'es': 'Search...',
      'en': 'Search...',
    },
    'vzt0drix': {
      'es': 'Transferencia entre cuentas',
      'en': 'Transfer between accounts',
    },
    'tv1uw3nq': {
      'es': 'Depósito',
      'en': 'Deposit',
    },
    'p2bsim9c': {
      'es': 'Otro',
      'en': 'Other',
    },
    'xagkfr7g': {
      'es': 'Descripción ',
      'en': 'Description',
    },
    '4g0ncbe2': {
      'es': 'Puedes dejar una breve descripción...',
      'en': 'You can leave a brief description...',
    },
    '1yowpdo8': {
      'es': 'Monto ',
      'en': 'Amount',
    },
    'ey9l77qp': {
      'es': '0.0',
      'en': '0.0',
    },
    'i5ftp4cb': {
      'es': 'Ahorro recurrente',
      'en': 'Recurring savings',
    },
    'j1d4j96k': {
      'es': 'Frecuencia',
      'en': 'Frequency',
    },
    '0n4v40dx': {
      'es': 'Seleccionar...',
      'en': 'Select...',
    },
    '2v42penb': {
      'es': 'Search...',
      'en': 'Search...',
    },
    'kjlvowt3': {
      'es': 'Diario',
      'en': 'Daily',
    },
    '3z5i99cg': {
      'es': 'Semanal',
      'en': 'Weekly',
    },
    'w3o0pqb6': {
      'es': 'Quincenal',
      'en': 'Biweekly',
    },
    'w9pvml8n': {
      'es': 'Mensual',
      'en': 'Monthly',
    },
    'jwmt0pcx': {
      'es': 'Trimestral',
      'en': 'Quarterly',
    },
    '87rhnrf3': {
      'es': 'Anual',
      'en': 'Annual',
    },
    'em3eo90m': {
      'es': 'Ajustes de Notificación',
      'en': 'Notification Settings',
    },
    'ac5tmciv': {
      'es': '( Horas de antelación para recibir la notificación )',
      'en': '(Hours in advance to receive the notification)',
    },
    'p7isvi91': {
      'es': '72',
      'en': '72',
    },
    '3ac9b5k5': {
      'es': '',
      'en': '',
    },
    'e6dbfi8n': {
      'es': 'Buscar...',
      'en': 'Search...',
    },
    'es7jl4z3': {
      'es': '24',
      'en': '24',
    },
    '1n43r7ti': {
      'es': '48',
      'en': '48',
    },
    '1lyyq24u': {
      'es': '72',
      'en': '72',
    },
    '98u5yjjk': {
      'es': '96',
      'en': '96',
    },
    'j7m1yd6e': {
      'es': 'Añadir',
      'en': 'Add',
    },
  },
  // eliminarOtroGasto
  {
    '3gup9h38': {
      'es': '¿Deseas eliminar este evento?',
      'en': 'Do you want to delete this event?',
    },
    'cwyrzs5h': {
      'es': 'Cancelar Acción',
      'en': 'Cancel Action',
    },
    'wfghk420': {
      'es': 'Eliminar Evento',
      'en': 'Delete Event',
    },
  },
  // EditarotrGas
  {
    '3bb53nlq': {
      'es': 'Editar Evento',
      'en': 'Edit Event',
    },
    'da36zp0n': {
      'es': 'Descripción (opcional)',
      'en': 'Description (optional)',
    },
    'ur6forym': {
      'es': 'Puedes dejar una breve descripción...',
      'en': 'You can leave a brief description...',
    },
    'wsbpdj00': {
      'es': 'Monto ',
      'en': 'Amount',
    },
    'hq35y13w': {
      'es': 'Cantidad del efectivo...',
      'en': 'Cash Amount...',
    },
    'gc6t5p44': {
      'es': 'Editar',
      'en': 'Edit',
    },
  },
  // infoOtrosGastos
  {
    '3uwhlbki': {
      'es': 'Otros Gastos Mensuales Estimados',
      'en': 'Other Estimated Monthly Expenses',
    },
    '0g11g8b0': {
      'es':
          'Los otros gastos son todos aquellos desembolsos que no forman parte de tus gastos fijos o principales, pero que igualmente afectan tu flujo de efectivo mensual.\n\nEstos pueden incluir compras ocasionales, entretenimiento, suscripciones, imprevistos o cualquier gasto variable que no ocurre de manera constante, pero que suma a lo largo del mes.\n\nAunque suelen parecer pequeños o menos importantes, los otros gastos pueden tener un impacto significativo en tu balance financiero si no se controlan adecuadamente.\n\nDentro del cálculo del flujo de efectivo, los otros gastos se suman a los gastos principales:\n\nFlujo de efectivo mensual estimado = Ingresos − (Gastos + Otros gastos)\n\nIdentificar y monitorear estos gastos te permite tener una visión más completa de tu dinero, evitar fugas invisibles y tomar decisiones más conscientes para mantener un flujo de efectivo positivo.\n',
      'en':
          'Other expenses are all those outlays that aren\'t part of your fixed or main expenses, but still affect your monthly cash flow.\n\nThese can include occasional purchases, entertainment, subscriptions, unexpected expenses, or any variable spending that doesn\'t occur constantly but adds up over the course of the month.\n\nAlthough they often seem small or less important, other expenses can have a significant impact on your financial balance if not properly managed.\n\nWhen calculating cash flow, other expenses are added to main expenses:\n\nEstimated monthly cash flow = Income − (Expenses + Other expenses)\n\nIdentifying and monitoring these expenses allows you to have a more complete view of your money, avoid hidden leaks, and make more informed decisions to maintain a positive cash flow.',
    },
    '2e9u5k6u': {
      'es': 'Aceptar',
      'en': 'Accept',
    },
  },
  // infoFlujodeefectivo
  {
    '5mnpo9mm': {
      'es': 'Flujo de Efectivo Mensual Estimado',
      'en': 'Estimated Monthly Cash Flow',
    },
    'bkh7hqxr': {
      'es':
          'El flujo de efectivo mensual estimado es una proyección que muestra cuánto dinero te quedará disponible al final del mes, una vez que se han considerado todos tus ingresos y tus gastos.\n\nEste indicador te permite anticiparte a tu situación financiera antes de que el mes termine, ayudándote a tomar decisiones más inteligentes sobre tu dinero, evitar déficits y planificar con mayor seguridad.\n\nEl cálculo es sencillo:\n\nFlujo de efectivo mensual estimado = Ingresos − Gastos \n\nLos ingresos incluyen todo el dinero que recibes durante el mes, como salario, ingresos adicionales o cualquier otra fuente de entrada.\nLos gastos representan tus obligaciones regulares, como renta, servicios, alimentación o transporte.\nLos otros gastos incluyen desembolsos adicionales, variables o no recurrentes que también impactan tu balance financiero.\n\nSi el resultado es positivo, significa que estás generando excedente y puedes ahorrar o invertir.\nSi es negativo, indica que estás gastando más de lo que ingresas y necesitas ajustar tus hábitos financieros.\n\nEl objetivo es mantener un flujo de efectivo positivo y creciente en el tiempo, como base para construir estabilidad y riqueza.\n',
      'en':
          'Estimated monthly cash flow is a projection that shows how much money you\'ll have available at the end of the month, after all your income and expenses have been considered.\n\nThis indicator allows you to anticipate your financial situation before the month ends, helping you make smarter money decisions, avoid deficits, and plan more effectively.\n\nThe calculation is simple:\n\nEstimated monthly cash flow = Income − Expenses\n\nIncome includes all the money you receive during the month, such as salary, additional income, or any other source of revenue.\n\nExpenses represent your regular obligations, such as rent, utilities, food, or transportation.\nOther expenses include additional, variable, or non-recurring outlays that also impact your financial balance.\n\nIf the result is positive, it means you\'re generating a surplus and can save or invest.\n\nIf it\'s negative, it indicates you\'re spending more than you\'re earning and need to adjust your financial habits.\n\nThe goal is to maintain a positive and growing cash flow over time, as a basis for building stability and wealth.',
    },
    '6a7vv4kw': {
      'es': 'Aceptar',
      'en': 'Accept',
    },
  },
  // infoEfectivorestante
  {
    'i8fyxdw7': {
      'es': 'Efectivo Restante sin Categorizar',
      'en': 'Remaining Uncategorized Cash',
    },
    '7t1uv5t5': {
      'es':
          'El efectivo restante sin categorizar representa el dinero disponible después de haber considerado tu flujo de efectivo mensual y haber separado una parte para tus ahorros.\n\nEste valor muestra cuánto dinero aún no ha sido asignado a un propósito específico, dándote una visión clara de lo que puedes utilizar con mayor libertad o redistribuir de forma estratégica.\n\nEl cálculo es el siguiente:\n\nEfectivo restante sin categorizar = Flujo de efectivo mensual − Ahorros\n\nEste indicador es fundamental para evitar gastar sin control, ya que te permite identificar cuánto dinero realmente tienes disponible antes de tomar nuevas decisiones financieras.\n\nUn valor positivo indica que aún cuentas con margen para gastar, invertir o reasignar.\nUn valor bajo o negativo sugiere que debes ajustar tus gastos o revisar tu planificación para mantener el equilibrio financiero.\n\nGestionar correctamente este efectivo te ayuda a mantener el control total de tu dinero y a tomar decisiones más conscientes en tu camino hacia la construcción de riqueza.\n\n',
      'en':
          'Uncategorized cash represents the money available after you\'ve considered your monthly cash flow and set aside a portion for savings.\n\nThis figure shows how much money hasn\'t yet been allocated to a specific purpose, giving you a clear view of what you can use more freely or strategically reallocate.\n\nThe calculation is as follows:\n\nUncategorized Cash = Monthly Cash Flow − Savings\n\nThis indicator is crucial for avoiding uncontrolled spending, as it allows you to identify how much money you truly have available before making new financial decisions.\n\nA positive value indicates that you still have room to spend, invest, or reallocate.\n\nA low or negative value suggests that you should adjust your spending or review your planning to maintain financial balance.\n\nManaging this cash effectively helps you maintain complete control over your money and make more informed decisions on your path to wealth building.',
    },
    'yoryvo2a': {
      'es': 'Aceptar',
      'en': 'Accept',
    },
  },
  // BankAcount
  {
    'ogdz1poa': {
      'es': '....',
      'en': '....',
    },
  },
  // metascard
  {
    're0dctqm': {
      'es': '',
      'en': '',
    },
  },
  // transactiondetails
  {
    'tp9mn64l': {
      'es': 'Detalles de la transacción',
      'en': 'Transaction details',
    },
    'fvotkw8v': {
      'es': 'Fecha de la Transacción',
      'en': 'Transaction Date',
    },
    'z1ld7e5i': {
      'es': 'Categoría',
      'en': 'Category',
    },
    'dlbiwgkw': {
      'es': 'Información del Comercio',
      'en': 'Merchant Information',
    },
    '5jd6fd0c': {
      'es': 'Nombre: ',
      'en': 'Name:',
    },
    'maxj3tld': {
      'es': 'ID: ',
      'en': 'ID:',
    },
    'e0setk01': {
      'es': 'Sitio Web: ',
      'en': 'Website:',
    },
  },
  // GoaldInfo
  {
    'h3zvofq7': {
      'es': 'Información de Meta Financiera',
      'en': 'Financial Goal Information',
    },
    '11kg6irk': {
      'es': '',
      'en': '',
    },
    'clm33fy8': {
      'es': 'Cuenta',
      'en': 'Account',
    },
    'tukmobsl': {
      'es': 'Us bank ',
      'en': 'US Bank',
    },
    '1000ncyg': {
      'es': 'Save',
      'en': 'Save',
    },
    'sxf76hee': {
      'es': '....5778',
      'en': '....5778',
    },
    's26727ot': {
      'es': 'Monto de la Meta',
      'en': 'Target Amount',
    },
    '0pldfj7g': {
      'es': 'Monto Acumulado',
      'en': 'Accumulated Amount',
    },
    '7sv7p17v': {
      'es': 'Monto Restante',
      'en': 'Remaining Amount',
    },
    'spgqh79n': {
      'es': 'Monto de las Cuotas',
      'en': 'Installment Amount',
    },
    'yepr49ep': {
      'es': 'Estado',
      'en': 'Status',
    },
    'o7uowarn': {
      'es': 'Fecha de Inicio',
      'en': 'Start Date',
    },
    'z6te05a9': {
      'es': 'Fecha de Culminación',
      'en': 'Completion Date',
    },
    '6yehhhqp': {
      'es': 'Frecuencia',
      'en': 'Frequency',
    },
    '6ddq3rbi': {
      'es': 'Número de Cuotas ',
      'en': 'Number of Installments',
    },
    '1j0c7zlo': {
      'es': 'Cuotas Restantes',
      'en': 'Remaining Installments',
    },
    '7mywd3el': {
      'es': 'Descripción',
      'en': 'Description',
    },
    'd315ld7r': {
      'es': 'Editar Meta Financiera',
      'en': 'Edit Financial Goal',
    },
    'aqs8ay02': {
      'es': 'Eliminar Meta Financiera',
      'en': 'Remove Financial Goal',
    },
  },
  // GoaldCreating
  {
    'svm8b7d1': {
      'es': 'Nueva Meta',
      'en': 'New Goal',
    },
    'ppeg59y8': {
      'es': 'Nombre',
      'en': 'Name',
    },
    'zsw9h5gr': {
      'es': 'Nombre de tu meta...',
      'en': 'Name your goal...',
    },
    'mrwpgb5q': {
      'es': 'Descripción (opcional)',
      'en': 'Description (optional)',
    },
    'rkym5y2k': {
      'es': 'Puedes dejar una breve descripción...',
      'en': 'You can leave a brief description...',
    },
    'dpsfmiex': {
      'es': 'Fecha de Inicio',
      'en': 'Start Date',
    },
    '19oqb6ac': {
      'es': 'Fecha de Culminación',
      'en': 'Completion Date',
    },
    'wnlnn3ju': {
      'es': 'Frecuencia de Pago de las Cuotas',
      'en': 'Payment Frequency',
    },
    'ex259yaf': {
      'es': 'Seleccionar...',
      'en': 'Select...',
    },
    '282nxm3e': {
      'es': 'Buscar...',
      'en': 'Search...',
    },
    'kmzgn92i': {
      'es': 'Diario',
      'en': 'Daily',
    },
    '6s1znwyi': {
      'es': 'Semanal',
      'en': 'Weekly',
    },
    'dz5880wp': {
      'es': 'Quincenal',
      'en': 'Daily',
    },
    '9nfu1a7d': {
      'es': 'Mensual',
      'en': 'Monthly',
    },
    '01rs3ttk': {
      'es': 'Trimestral',
      'en': 'Quarterly',
    },
    'am9su8xh': {
      'es': 'Anual',
      'en': 'Annual',
    },
    'o7capmna': {
      'es': 'Monto Total de la Meta',
      'en': 'Total Target Amount',
    },
    'czekv8yc': {
      'es': 'Cantidad Total de la meta...',
      'en': 'Total Goal Amount...',
    },
    'tamj5w17': {
      'es': 'Número de cuotas ',
      'en': 'Number of installments',
    },
    '10fe6qcz': {
      'es': 'Tamaño de la Cuota',
      'en': 'Installment Amount',
    },
    'qp5ofwzu': {
      'es': 'Cuenta Emisora (de donde se envian los fondos)',
      'en': 'Sending Account (source account)',
    },
    '1c71oi4g': {
      'es': 'Seleccionar...',
      'en': 'Select...',
    },
    'f4iejn0j': {
      'es': 'Buscar...',
      'en': 'Search...',
    },
    'gop3n9re': {
      'es': 'Option 1',
      'en': 'Option 1',
    },
    'vq519gp4': {
      'es': 'Option 2',
      'en': 'Option 2',
    },
    'ddfkfm8x': {
      'es': 'Option 3',
      'en': 'Option 3',
    },
    '23xvfk9z': {
      'es': 'Cuenta Receptora ( La que recibe los fondos)',
      'en': 'Receiving Account (destination account)',
    },
    '28ekisda': {
      'es': 'Seleccionar...',
      'en': 'Select...',
    },
    'hwusspbn': {
      'es': 'Buscar...',
      'en': 'Search...',
    },
    'ubhwycag': {
      'es': 'Option 1',
      'en': 'Option 1',
    },
    'pmz6rsxh': {
      'es': 'Option 2',
      'en': 'Option 2',
    },
    '6tcsgmo2': {
      'es': 'Option 3',
      'en': 'Option 3',
    },
    '8zjn73f9': {
      'es': 'Ajustes de Notificación',
      'en': 'Notification Settings',
    },
    'qkvw6ba3': {
      'es': '( Horas de antelación para recibir la notificación )',
      'en': '(Hours in advance to receive the notification)',
    },
    'zpvtsl1i': {
      'es': '72',
      'en': '72',
    },
    '1exd988d': {
      'es': '',
      'en': '',
    },
    '1b3861ky': {
      'es': 'Buscar...',
      'en': 'Search...',
    },
    'gipjzxme': {
      'es': '24',
      'en': '24',
    },
    '1p98d3bu': {
      'es': '48',
      'en': '48',
    },
    'qybg6zqz': {
      'es': '72',
      'en': '72',
    },
    'z8mkg24y': {
      'es': '96',
      'en': '96',
    },
    'a9a0q436': {
      'es': 'Crear ',
      'en': 'Create',
    },
  },
  // ditarGoald
  {
    'ze49y43x': {
      'es': 'Editar  Meta',
      'en': 'Edit Goal',
    },
    'yk59jgil': {
      'es': 'Nombre',
      'en': 'Name',
    },
    'qi2ihfw7': {
      'es': 'Nombre de tu meta...',
      'en': 'Name your goal...',
    },
    'fsbkajws': {
      'es': 'Descripción (opcional)',
      'en': 'Description (optional)',
    },
    'vr7oim4f': {
      'es': 'Puedes dejar una breve descripción...',
      'en': 'You can leave a brief description...',
    },
    'eawdl1yo': {
      'es': 'Fecha de Inicio',
      'en': 'Start Date',
    },
    'l33lmzmt': {
      'es': 'Fecha de Culminación',
      'en': 'Completion Date',
    },
    '3wk5nnsl': {
      'es': 'Seleccionar fecha...',
      'en': 'Select date...',
    },
    'yus5xd1m': {
      'es': 'Monto Total de la Meta',
      'en': 'Total Target Amount',
    },
    '0vkgy6sy': {
      'es': 'Cantidad Total de la meta...',
      'en': 'Total Goal Amount',
    },
    'urbyunnx': {
      'es': 'Frecuencia de la Cuota',
      'en': 'Installment Frequency',
    },
    'g3tgrqov': {
      'es': 'Seleccionar...',
      'en': 'Select...',
    },
    'gzn8t75x': {
      'es': 'Search...',
      'en': 'Search...',
    },
    'g2fvwi3j': {
      'es': 'Diario',
      'en': 'Daily',
    },
    'jtfvpfu2': {
      'es': 'Semanal',
      'en': 'Weekly',
    },
    '1ew0awtw': {
      'es': 'Quincenal',
      'en': 'Biweekly',
    },
    'uk2d05u9': {
      'es': 'Mensual',
      'en': 'Monthly',
    },
    'mp829wgt': {
      'es': 'Trimestral',
      'en': 'Quarterly',
    },
    'oe3yqfi2': {
      'es': 'Anual',
      'en': 'Annual',
    },
    '3g6k3lv1': {
      'es': 'Número de cuotas ',
      'en': 'Number of Installments',
    },
    'frfrncfz': {
      'es': 'Tamaño de la Cuota',
      'en': 'Installment Amount',
    },
    'd8vj6zoh': {
      'es': 'Cuenta Emisora (de donde se envian los fondos)',
      'en': 'Sending Account (source account)',
    },
    'ydm8e992': {
      'es': 'Select...',
      'en': 'Select...',
    },
    'mbpmjycx': {
      'es': 'Search...',
      'en': 'Search...',
    },
    'qr0jox13': {
      'es': 'Option 1',
      'en': 'Option 1',
    },
    '8qs1xli9': {
      'es': 'Option 2',
      'en': 'Option 2',
    },
    'gon5m95b': {
      'es': 'Option 3',
      'en': 'Option 3',
    },
    '0pj7nsq2': {
      'es': 'Cuenta Receptora ( La que recibe los fondos)',
      'en': 'Receiving Account (destination account)',
    },
    'qkaizs97': {
      'es': 'Select...',
      'en': 'Select...',
    },
    'w9qsmscc': {
      'es': 'Search...',
      'en': 'Search...',
    },
    'g70zmztr': {
      'es': 'Option 1',
      'en': 'Option 1',
    },
    'yrttzo5g': {
      'es': 'Option 2',
      'en': 'Option 2',
    },
    '874v594n': {
      'es': 'Option 3',
      'en': 'Option 3',
    },
    'h4byxrn9': {
      'es': 'Ajustes de Notificación',
      'en': 'Notification Settings',
    },
    's5a09dy6': {
      'es': '( Horas de antelación para recibir la notificación )',
      'en': '(Hours in advance to receive the notification)',
    },
    'ti3i6c6r': {
      'es': '',
      'en': '',
    },
    '2ubunfsj': {
      'es': 'Search...',
      'en': 'Search...',
    },
    'l5hrpn0n': {
      'es': '24',
      'en': '24',
    },
    'nirhb9u9': {
      'es': '48',
      'en': '48',
    },
    'ldhpyl9w': {
      'es': '72',
      'en': '72',
    },
    'gxreoyjk': {
      'es': '96',
      'en': '96',
    },
    'lxex0fh8': {
      'es': 'Editar Meta',
      'en': 'Edit Goal',
    },
  },
  // eliminarMeta
  {
    '7ww0rgna': {
      'es': '¿Deseas eliminar esta meta?',
      'en': 'Do you want to remove this goal?',
    },
    'g905qoyd': {
      'es': 'Conservas todos tus fondos en tu cuenta de ahorros.',
      'en': 'You keep all your funds in your savings account.',
    },
    '775o6jyi': {
      'es': 'Cancelar Acción',
      'en': 'Cancel Action',
    },
    'kiz03qaf': {
      'es': 'Eliminar Meta ',
      'en': 'Delete Goal',
    },
  },
  // ajustesDuplicados
  {
    'l3ycy71x': {
      'es':
          'Hemos encontrado dos movimientos que parecen representar la misma transacción.',
      'en':
          'We found two transactions that appear to represent the same transaction.',
    },
    'xz04ghwl': {
      'es':
          'Opciones:\n\nConservar movimiento del banco (recomendado)\nMantiene la sincronización automática y actualizaciones futuras.\n\nConservar movimiento manual\nÚtil si hiciste ajustes personalizados.',
      'en':
          'Options:\n\nKeep bank transactions (recommended)\nMaintains automatic synchronization and future updates.\n\nKeep manual transactions\nUseful if you made custom settings.',
    },
    '2igk3ei3': {
      'es':
          'Seleccionar la opción correcta evitará que tu balance y tus proyecciones anuales se dupliquen.',
      'en':
          'Selecting the correct option will prevent your balance and annual projections from being duplicated.',
    },
    'ee6r03oe': {
      'es': 'Mantener el Seleccionado',
      'en': 'Keep Selected',
    },
    '0omjyja7': {
      'es': 'Ignorar y Mantener Ambos',
      'en': 'Ignore and Keep Both',
    },
  },
  // newsViews
  {
    'isl7qn49': {
      'es': 'Leer mas...',
      'en': 'Read more...',
    },
  },
  // Verificatucorreo
  {
    'snqulxdm': {
      'es': 'Verifica tu correo',
      'en': 'Check your email',
    },
    'nijh9tt5': {
      'es':
          'Hemos enviado un enlace de verificación a tu correo electrónico.\nRevisa tu bandeja de entrada y haz clic en el enlace para activar tu cuenta.\n\nSi no lo ves, revisa la carpeta de spam.',
      'en':
          'We\'ve sent a verification link to your email address.\n\nCheck your inbox and click the link to activate your account.\n\nIf you don\'t see it, check your spam folder.',
    },
    'cc85de08': {
      'es': '¿No recibiste el correo?  ',
      'en': 'Didn\'t receive the email?',
    },
    'gf6f5mif': {
      'es': 'Reenviar',
      'en': 'Resend',
    },
    '3ev1pcim': {
      'es': 'Ya verifiqué mi correo',
      'en': 'I already verified my email',
    },
  },
  // Biometria
  {
    'eyj49yki': {
      'es': '¿Deseas activar la verificación por Biometría?',
      'en': 'Do you want to activate biometric verification?',
    },
    'm0j2qs5f': {
      'es': '¿Deseas desactivar la verificación por Biometría?',
      'en': 'Do you want to disable biometric verification?',
    },
    '1xl92ebk': {
      'es': 'Cancelar ',
      'en': 'Cancel',
    },
    'xwpaigw7': {
      'es': 'Activar',
      'en': 'Activate',
    },
    'xk0zaf17': {
      'es': 'Autentícate para acceder a tu cuenta',
      'en': 'Verify your identity to access your account',
    },
    'sjcpba0p': {
      'es': 'Desactivar',
      'en': 'Deactivate',
    },
  },
  // bokimg
  {
    'd7pvzbe9': {
      'es':
          'Hay algo que sabes… pero no dices en voz alta:\n\nNo quieres una vida promedio.\nQuieres más dinero. Más libertad. Más control sobre tu tiempo.\n\nY lo quieres ahora… no dentro de 10 años.\n\nEste libro existe por eso.\n\nEl autor ya hizo el trabajo por ti:\nleyó, filtró y condensó lo mejor del mundo de la riqueza en un sistema claro, directo y accionable.\n\nAquí vas a entender por qué otros avanzan mientras tú sigues igual…\ny, lo más importante, cómo cambiarlo desde hoy.\n\nPorque la verdad es incómoda:\nno te falta capacidad… te falta dirección.\n\nY mientras lo piensas, otros ya están tomando lo que tú deseas.\n\nLa pregunta no es si puedes lograrlo…\nes si estás listo para dejar de esperar\ny empezar a construir.\n',
      'en':
          'There\'s something you know… but you don\'t say out loud:\n\nYou don\'t want an average life.\n\nYou want more money. More freedom. More control over your time.\n\nAnd you want it now… not in 10 years.\n\nThat\'s why this book exists.\n\nThe author has already done the work for you:\n\nread, filtered, and condensed the best of the wealth world into a clear, direct, and actionable system.\n\nHere you\'ll understand why others are moving forward while you\'re stuck…\nand, most importantly, how to change that starting today.\n\nBecause the truth is uncomfortable:\n\nyou don\'t lack ability… you lack direction.\n\nAnd while you\'re thinking about it, others are already taking what you want.\n\nThe question isn\'t whether you can achieve it…\nit\'s whether you\'re ready to stop waiting\nand start building.',
    },
    '1twjul8e': {
      'es': 'Descubrir en Amazon',
      'en': 'Discover on Amazon',
    },
    'y68vfliu': {
      'es': 'Cancelar Acción',
      'en': 'Cancel Action',
    },
  },
  // BankAccounts
  {
    '7ymly05i': {
      'es': 'Cuentas Bancarias',
      'en': 'Bank Accounts',
    },
  },
  // eliminarCuentaDeBanco
  {
    'q9zz2dg3': {
      'es': '¿Deseas desvincular esta cuenta?',
      'en': 'Do you want to unlink this account?',
    },
    'v09ah60v': {
      'es':
          'Si desvinculas esta cuenta, se eliminarán todos los datos de la misma dentro de Gold Up y los  eventos asociados.',
      'en':
          'If you unlink this account, all associated data and related events within Gold Up will be deleted.',
    },
    'kkpd3g6r': {
      'es': 'Cancelar Acción',
      'en': 'Cancel Action',
    },
    'zrd9qi95': {
      'es': 'Desvincular Cuenta',
      'en': 'Unlink Account',
    },
  },
  // correoEnviado
  {
    '2dhh6xvc': {
      'es': 'Hemos enviado un email',
      'en': 'Email Sent',
    },
    'jnpje9w9': {
      'es':
          'Hemos enviado un email a tu cuenta de correo electrónico para restablecer tu contraseña. ',
      'en':
          'We have sent an email to your email account to reset your password.',
    },
    'cm2ou1v8': {
      'es': 'Aceptar',
      'en': 'Accept',
    },
  },
  // ErrorBiometria
  {
    'fp1xpacb': {
      'es': 'Error de Biometría',
      'en': 'Biometric Error',
    },
    'oyn5kdho': {
      'es':
          'No tienes activada la biometría en tu dispositivo. Por favor, actívala en los ajustes del sistema para continuar',
      'en': 'Please enable biometrics in your device settings to continue.',
    },
    '9l39i04f': {
      'es': 'Aceptar',
      'en': 'Accept',
    },
  },
  // CreditCard
  {
    'fr2wnasf': {
      'es': '....',
      'en': '....',
    },
  },
  // Miscellaneous
  {
    'pa76gc43': {
      'es': 'Schedule',
      'en': 'Schedule',
    },
    's0ch64wu': {
      'es': 'Cancel',
      'en': 'Cancel',
    },
    '8em9bud8': {
      'es': 'Email Address',
      'en': 'Email Address',
    },
    'vxz8in4x': {
      'es': 'Enter your email...',
      'en': 'Enter your email...',
    },
    'jl66636i': {
      'es': 'Any further details needed?',
      'en': 'Any further details needed?',
    },
    'f100wut1': {
      'es': '',
      'en': '',
    },
    'xmywmuq8': {
      'es':
          'Esta aplicación necesita que aceptes recibir notificaciones. Usamos las notificaciones para avisarte con anticipación sobre ingresos, gastos y eventos financieros importantes de recordatorios programados, para que no se te pase nada.',
      'en':
          'This app requires you to allow notifications. We use notifications to alert you in advance about income, expenses, and important financial events, as well as scheduled reminders, so you don\'t miss anything.',
    },
    '5emwf976': {
      'es': '',
      'en': '',
    },
    'bagu30f4': {
      'es': '',
      'en': '',
    },
    'unxcphhd': {
      'es': '',
      'en': '',
    },
    'chsunram': {
      'es': '',
      'en': '',
    },
    '9nk4nhqd': {
      'es': '',
      'en': '',
    },
    'i4tg560p': {
      'es': '',
      'en': '',
    },
    'rxhz5wox': {
      'es': '',
      'en': '',
    },
    'lvqhymxv': {
      'es': '',
      'en': '',
    },
    'qn47mas2': {
      'es': '',
      'en': '',
    },
    'cj2f7ney': {
      'es': '',
      'en': '',
    },
    'e7yk49dn': {
      'es': '',
      'en': '',
    },
    'p6i24rb6': {
      'es': '',
      'en': '',
    },
    '5h56o7q3': {
      'es': '',
      'en': '',
    },
    'ed0lolj5': {
      'es': '',
      'en': '',
    },
    'mlkucojr': {
      'es': '',
      'en': '',
    },
    '7i780nok': {
      'es': '',
      'en': '',
    },
    '68q04x26': {
      'es': '',
      'en': '',
    },
    '7h3b6tpb': {
      'es': '',
      'en': '',
    },
    'wlfi4a9w': {
      'es': '',
      'en': '',
    },
    '8dfjbwlb': {
      'es': '',
      'en': '',
    },
    '402wyn9i': {
      'es': '',
      'en': '',
    },
    'kztbb9e9': {
      'es': '',
      'en': '',
    },
    'kxsvo12b': {
      'es': '',
      'en': '',
    },
    '8nd0aa5q': {
      'es': '',
      'en': '',
    },
    'vfib3sqx': {
      'es': '',
      'en': '',
    },
  },
].reduce((a, b) => a..addAll(b));

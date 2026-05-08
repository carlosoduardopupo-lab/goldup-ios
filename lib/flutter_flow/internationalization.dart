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
    '54ke7j8j': {
      'es': 'Gold Up ',
      'en': '',
    },
    'xyo19ic5': {
      'es': '',
      'en': '',
    },
    'smrwet2u': {
      'es': 'Inicio',
      'en': '',
    },
    'dnaqtwz2': {
      'es': '****',
      'en': '',
    },
    'c82j86hl': {
      'es': 'Disponible para gastar (estimado)',
      'en': '',
    },
    'rnw4n4qy': {
      'es':
          'Este es el capital sin categorizar restante  este mes.     Fórmula: Ingresos - (Gastos + Ahorros)',
      'en': '',
    },
    'di7ofl08': {
      'es': 'Balance Total en Cuentas ',
      'en': '',
    },
    're4fmu9z': {
      'es': 'Corrientes',
      'en': '',
    },
    'xrddfev8': {
      'es': 'Ahorros',
      'en': '',
    },
    '32wtmtqt': {
      'es': 'Créditos',
      'en': '',
    },
    '8nct2kf2': {
      'es': '-',
      'en': '',
    },
    '069ew9s9': {
      'es': 'Metas Financieras',
      'en': '',
    },
    'qqp7ecc2': {
      'es': '50%',
      'en': '',
    },
    'dypk4av1': {
      'es': '',
      'en': '',
    },
    'u4ze750e': {
      'es': 'Próximo Gasto Importante Programado',
      'en': '',
    },
    '122mqjz8': {
      'es': 'Facturas y Gastos del Mes ',
      'en': '',
    },
    'tekzrh36': {
      'es': 'Pendientes',
      'en': '',
    },
    'en4oos86': {
      'es': 'Total a pagar:',
      'en': '',
    },
    'um1c0wur': {
      'es': 'Vencidas',
      'en': '',
    },
    '01wlanm9': {
      'es': 'Total Saldado:',
      'en': '',
    },
    'ytcrcd16': {
      'es': 'Contenido patrocinado',
      'en': '',
    },
    'u7njiwu8': {
      'es': 'Credit Score',
      'en': '',
    },
    'ii0m6920': {
      'es': '0',
      'en': '',
    },
    'c0llrypx': {
      'es': 'Novedades',
      'en': '',
    },
    'fd5mhk1b': {
      'es': 'BIENVENIDO',
      'en': '',
    },
    'ka162cxw': {
      'es': 'AÚN NO HAY DATOS QUE MOSTRAR',
      'en': '',
    },
    'awhath0m': {
      'es': 'Para comenzar...',
      'en': '',
    },
    'ej7xfkfw': {
      'es': 'Crea un evento en el calendario',
      'en': '',
    },
    'q5ptftnx': {
      'es': '',
      'en': '',
    },
    'ea1vwpg2': {
      'es': 'Ahorros',
      'en': '',
    },
    '8szmn3ym': {
      'es': 'Ingresos',
      'en': '',
    },
    '9b2s27o9': {
      'es': 'Gastos',
      'en': '',
    },
    'rjvocdm1': {
      'es': 'Eventos Financieros',
      'en': '',
    },
    'euaw6srv': {
      'es': 'Pendientes',
      'en': '',
    },
    'njfnwiyl': {
      'es': 'a pagar ',
      'en': '',
    },
    'lyakqr5h': {
      'es': 'Vencidas',
      'en': '',
    },
    'n8n8c2g2': {
      'es': 'saldado',
      'en': '',
    },
    'r0m4qusb': {
      'es': '',
      'en': '',
    },
    'fu26ssxg': {
      'es': 'Finanzas',
      'en': '',
    },
    'b829oa14': {
      'es': 'Mes Actual:',
      'en': '',
    },
    'ufdykbvu': {
      'es': 'Ingreso Total Mensual (estimado)',
      'en': '',
    },
    'vso6qbm7': {
      'es': 'Gasto Total Mensual (estimado)',
      'en': '',
    },
    'pu03qkui': {
      'es': 'Flujo de Efectivo Mensual (estimado)',
      'en': '',
    },
    'pd64did4': {
      'es': 'Ahorros Totales (estimado)',
      'en': '',
    },
    'qgu1xblp': {
      'es': 'Disponible Para Gastar (estimado)',
      'en': '',
    },
    'axn33hnv': {
      'es': 'Ingreso Total Anual (estimado)',
      'en': '',
    },
    'dxk4bljk': {
      'es': 'Gasto Total Anual (estimado)',
      'en': '',
    },
    'wq0lfkq3': {
      'es': 'Flujo de Efectivo Total Anual (estimado)',
      'en': '',
    },
    '6o0abik0': {
      'es': 'Ahorro Total Anual (estimado)',
      'en': '',
    },
    'epbluwwz': {
      'es': 'YA CUALQUIERA\n ES MILLONARIO',
      'en': '',
    },
    'zjwfxnul': {
      'es':
          'Una guía clara y directa para aprender a gestionar y construir riqueza.\nDescubre cómo tomar el control de tus finanzas y diseñar el camino hacia tu libertad financiera.\n',
      'en': '',
    },
    'rlmum50i': {
      'es': '',
      'en': '',
    },
    'xx1hb2zh': {
      'es': 'Cuentas ',
      'en': '',
    },
    'zzu7d454': {
      'es':
          'La integración de cuentas bancarias externas no está disponible para su uso en esta versión. Actualice su versión a Premium para disfrutar de todas las herramientas de esta aplicación y obtener un control total de sus finanzas.',
      'en': '',
    },
    'ipii2uoo': {
      'es': '🟢 Base (Gratis con anuncios)',
      'en': '',
    },
    'c77uhlci': {
      'es':
          'Empieza a tomar control de tu dinero\n\n📅 Añadir eventos financieros manualmente (ingresos, gastos, ahorros)\n\n🗓️ Gestión completa desde el calendario\n\n✏️ Edición y eliminación limitada (afecta todas las recurrencias)\n\n📊 Hoja de balance del mes actual\n\n📈 Pronóstico básico de flujo de ingresos\n\n🧾 Visualización de facturas pendientes y pagadas\n\n🔔 Notificaciones predeterminadas (72h y mismo día)\n\n📢 Incluye anuncios',
      'en': '',
    },
    'zvzbms8y': {
      'es': 'Actualizar a Base con Anuncios',
      'en': '',
    },
    '7sobga8t': {
      'es': 'Plan Actual',
      'en': '',
    },
    'tboo4q1u': {
      'es': '🔵 Base (Sin anuncios) x \$1.99 al mes ',
      'en': '',
    },
    'vlo6fyf1': {
      'es':
          'Misma potencia, sin distracciones\n\n✅ Todo lo incluido en la versión Base\n\n🚫 Sin anuncios\n\n⚡ Experiencia más limpia y rápida',
      'en': '',
    },
    'e1ubl1vf': {
      'es': 'Actualizar a Base sin Anuncios',
      'en': '',
    },
    '5kk2lozp': {
      'es': 'Plan Actual',
      'en': '',
    },
    '8f9b3uga': {
      'es': '🟣 Premium (Todas las funciones) x \$9.99 al mes',
      'en': '',
    },
    '34h5td7z': {
      'es':
          'Sistema completo para construir riqueza\n\n✅ Todo lo incluido en la versión Base mas:\n\n🔗 Vinculación con cuentas bancarias externas\n\n💳 Visualización de balance total (bancos + tarjetas)\n\n📅 Edición y eliminación de eventos independientes\n\n🔔 Notificaciones personalizadas (24h, 48h, 72h, 96h)\n\n📈 Flujo de efectivo anual\n\n💰 Pronóstico anual de ingresos, gastos y ahorros\n\n🎯 Creación y monitoreo de metas financieras\n\n🧠 Control financiero avanzado y automatizado',
      'en': '',
    },
    'lnmha9od': {
      'es': 'Actualizar a Premium',
      'en': '',
    },
    'i2g712db': {
      'es': 'Plan Actual',
      'en': '',
    },
    'dxt9kb3c': {
      'es': 'Cheques',
      'en': '',
    },
    'cxfwph7h': {
      'es': 'Ahorros',
      'en': '',
    },
    'cdchq82q': {
      'es': 'Créditos',
      'en': '',
    },
    'guxo3dh0': {
      'es': 'Total Ahorrado:',
      'en': '',
    },
    'cc7ff5vb': {
      'es': 'Total Utilizado:',
      'en': '',
    },
    'lj8kxbik': {
      'es': 'Total Acumulado:',
      'en': '',
    },
    'n0hd9vvq': {
      'es': 'Añadir Cuentas ',
      'en': '',
    },
    'bq7eyc8f': {
      'es': 'Funciones en desarrollo\n\n',
      'en': '',
    },
    'k0vslz1b': {
      'es':
          'Estás utilizando la versión piloto básica de Gold Up.\nLa sección de ',
      'en': '',
    },
    't4slncj6': {
      'es': 'Cuentas Bancarias ',
      'en': '',
    },
    'arq1y8hp': {
      'es':
          'aún no está disponible  en esta fase.\n\nEstas funcionalidades se encuentran actualmente en desarrollo y serán habilitadas en próximas actualizaciones.\n\nGracias por formar parte de esta etapa temprana de prueba y ayudarnos a mejorar la aplicación.\n\n',
      'en': '',
    },
    '5l42ihgf': {
      'es': '¿Qué funciones trae esta herramienta?\n\n',
      'en': '',
    },
    'tnvafbcw': {
      'es':
          '1️⃣ 🔗 Todas tus cuentas en un solo lugar\nDejas de saltar entre apps y ves tu dinero completo en un solo lugar\n\n2️⃣ 🧾 Todas tus transacciones unificadas\nMovimientos de todos los bancos en una sola vista\n\n3️⃣ 📊 Cálculo real de ingresos y gastos\nNúmeros exactos, no estimaciones\n\n4️⃣ 💸 Control total del flujo de dinero\n Entiendes claramente en qué se va tu dinero\n\n5️⃣ 📅 Planificación mensual precisa \n Puedes organizar tu mes con base en datos reales\n\n6️⃣ 📉 Reducción de gastos innecesarios\nDetectas fugas de dinero automáticamente\n\n7️⃣ 🎯 Mayor capacidad de ahorro\n Tomas decisiones más inteligentes con tu dinero\n\n8️⃣ 🤖 Base para inteligencia financiera\n Permite automatizar, predecir y optimizar tus finanzas\n\n',
      'en': '',
    },
    'guhd99at': {
      'es': '* Funciones Premiums',
      'en': '',
    },
    '845nyomz': {
      'es': '',
      'en': '',
    },
    'zwz9eivi': {
      'es': 'Metas Financieras',
      'en': '',
    },
    'w40fj3to': {
      'es':
          'La creación y el monitoreo de metas financieras no está disponible para su uso en esta versión. Actualice su versión a Premium para disfrutar de todas las herramientas de esta aplicación y obtener un control total de sus finanzas.',
      'en': '',
    },
    '6e82svw1': {
      'es': '🟢 Base (Gratis con anuncios)',
      'en': '',
    },
    '7o2luogx': {
      'es':
          'Empieza a tomar control de tu dinero\n\n📅 Añadir eventos financieros manualmente (ingresos, gastos, ahorros)\n\n🗓️ Gestión completa desde el calendario\n\n✏️ Edición y eliminación limitada (afecta todas las recurrencias)\n\n📊 Hoja de balance del mes actual\n\n📈 Pronóstico básico de flujo de ingresos\n\n🧾 Visualización de facturas pendientes y pagadas\n\n🔔 Notificaciones predeterminadas (72h y mismo día)\n\n📢 Incluye anuncios',
      'en': '',
    },
    'zcvbkuxs': {
      'es': 'Actualizar a Base con Anuncios',
      'en': '',
    },
    '66v0je5c': {
      'es': 'Plan Actual',
      'en': '',
    },
    'mwi23mxs': {
      'es': '🔵 Base (Sin anuncios) x \$1.99 al mes ',
      'en': '',
    },
    '8i8mqf61': {
      'es':
          'Misma potencia, sin distracciones\n\n✅ Todo lo incluido en la versión Base\n\n🚫 Sin anuncios\n\n⚡ Experiencia más limpia y rápida',
      'en': '',
    },
    'tiu5cq25': {
      'es': 'Actualizar a Base sin Anuncios',
      'en': '',
    },
    'einhbqz6': {
      'es': 'Plan Actual',
      'en': '',
    },
    'qyrwtvgv': {
      'es': '🟣 Premium (Todas las funciones) x \$9.99 al mes',
      'en': '',
    },
    '882w7a9g': {
      'es':
          'Sistema completo para construir riqueza\n\n✅ Todo lo incluido en la versión Base mas:\n\n🔗 Vinculación con cuentas bancarias externas\n\n💳 Visualización de balance total (bancos + tarjetas)\n\n📅 Edición y eliminación de eventos independientes\n\n🔔 Notificaciones personalizadas (24h, 48h, 72h, 96h)\n\n📈 Flujo de efectivo anual\n\n💰 Pronóstico anual de ingresos, gastos y ahorros\n\n🎯 Creación y monitoreo de metas financieras\n\n🧠 Control financiero avanzado y automatizado',
      'en': '',
    },
    'ez4qjo7z': {
      'es': 'Actualizar a Premium',
      'en': '',
    },
    'gc89j3u6': {
      'es': 'Plan Actual',
      'en': '',
    },
    't0dm9swd': {
      'es': 'Añadir Nueva Meta Financiera',
      'en': '',
    },
    'wffpi2ou': {
      'es': 'Función en desarrollo\n\n',
      'en': '',
    },
    '1l7i063l': {
      'es':
          'Estás utilizando la versión piloto básica de Gold Up.\nLa sección de ',
      'en': '',
    },
    'g15ea4ig': {
      'es': 'Metas Financieras ',
      'en': '',
    },
    'vtu887va': {
      'es':
          'aún no está disponible  en esta fase.\n\nEsta funcionalidades se encuentran actualmente en desarrollo y serán habilitadas en próximas actualizaciones.\n\nGracias por formar parte de esta etapa temprana de prueba y ayudarnos a mejorar la aplicación.\n\n',
      'en': '',
    },
    'ra2f2yu2': {
      'es': '¿Qué aporta esta funcionalidad?\n\n',
      'en': '',
    },
    'b4ts9m8c': {
      'es':
          '1️⃣ 🎯 Dirección clara del dinero\nCada dólar tiene un objetivo definido\n\n2️⃣ 📊 Control del progreso\nVes cuánto llevas y cuánto te falta\n\n3️⃣ 📅 Planificación financiera real\n Divide metas en aportes mensuales alcanzables\n\n4️⃣ 💸 Ahorro estructurado\nEvita gastar dinero que ya tiene un propósito\n\n5️⃣ 📉 Reducción de gastos innecesarios\nTe obliga a priorizar lo importante\n\n6️⃣ 🧠 Disciplina financiera automática\n Convierte el ahorro en hábito, no en esfuerzo\n\n',
      'en': '',
    },
    '4lc9672a': {
      'es': '¿Cómo funciona?\n\n',
      'en': '',
    },
    '21hk7x9d': {
      'es':
          '1️⃣ Creas una meta\nEj: carro, casa, fondo de emergencia\n\n2️⃣ Defines monto y tiempo\nEj: \$5,000 en 10 meses\n\n3️⃣ El sistema calcula el aporte\n Cuánto debes ahorrar por periodo\n\n4️⃣ Registras o automatizas aportes\nManual o desde tus ingresos\n\n5️⃣ Ves el progreso en tiempo real\nBarra, porcentaje, restante\n\n6️⃣ Ajustas si es necesario\nMás rápido o más flexible\n\n',
      'en': '',
    },
    'eivdta2n': {
      'es': '* Funciones Premiums',
      'en': '',
    },
    'ai592cl4': {
      'es': 'Gold Up ',
      'en': '',
    },
    't6frxoek': {
      'es': 'Tienes el potencial necesario para alcanzar el éxito.',
      'en': '',
    },
    '31y0aix1': {
      'es': '•',
      'en': '',
    },
    'mtkcdjcv': {
      'es': 'Por tu seguridad, verifica tu identidad para continuar.',
      'en': '',
    },
  },
  // Auth2
  {
    '51mq6e1x': {
      'es': 'Gold Up ',
      'en': '',
    },
    'qag2uhrp': {
      'es': 'Crear Cuenta',
      'en': '',
    },
    'y49wpb09': {
      'es': 'Crear Cuenta',
      'en': '',
    },
    'lbxsigxt': {
      'es': 'Comencemos rellenando los datos siguientes.',
      'en': '',
    },
    'ftjomfw7': {
      'es': 'Correo Electrónico',
      'en': '',
    },
    'pvkz1xtz': {
      'es': 'Contraseña',
      'en': '',
    },
    '5tlzsdwh': {
      'es': 'He leído y acepto los ',
      'en': '',
    },
    'b9o0tuaa': {
      'es': 'Términos del Servicio ',
      'en': '',
    },
    'tkjz5xiv': {
      'es': 'y la ',
      'en': '',
    },
    'wmyxe84y': {
      'es': 'Política de Privacidad',
      'en': '',
    },
    'lnfd3dhh': {
      'es': 'Hello World',
      'en': '',
    },
    '7pl2siua': {
      'es': 'Registrar Cuenta',
      'en': '',
    },
    'h4o0lr8h': {
      'es': 'Acceder',
      'en': '',
    },
    'o6fgy1ob': {
      'es': 'Bienvenido de Vuelta',
      'en': '',
    },
    'qma3by2w': {
      'es': 'Rellene la siguiente informacion para acceder a su cuenta',
      'en': '',
    },
    '45ro92jo': {
      'es': 'Correo electrónico',
      'en': '',
    },
    'z701o62p': {
      'es': 'Contraseña',
      'en': '',
    },
    '7x735jg6': {
      'es': 'Acceder',
      'en': '',
    },
    '5vx87ull': {
      'es': 'Olvidé la Contraseña?',
      'en': '',
    },
    '9pm44qya': {
      'es': 'Home',
      'en': '',
    },
  },
  // sett
  {
    'h6l9fr95': {
      'es': 'Ajustes',
      'en': '',
    },
    'ezasaexc': {
      'es': 'Tu Cuenta',
      'en': '',
    },
    'q7uwl4de': {
      'es': 'Eliminar Cuenta',
      'en': '',
    },
    'bop39omt': {
      'es': 'Cambiar Contraseña',
      'en': '',
    },
    'v0lzv9c4': {
      'es': 'Actualizar Plan',
      'en': '',
    },
    'ol0rua18': {
      'es': 'Ajustes de la Aplicación',
      'en': '',
    },
    '7phuxfjk': {
      'es': 'Ajustes de Notificaciones',
      'en': '',
    },
    'gcm6zvif': {
      'es': 'Cuentas de Bancos',
      'en': '',
    },
    'x1cvzure': {
      'es': 'Ayuda y Soporte',
      'en': '',
    },
    'ycpib1ss': {
      'es': 'Soporte',
      'en': '',
    },
    'x9pyxrnb': {
      'es': 'Terminos del Servicio',
      'en': '',
    },
    '2dn5htey': {
      'es': 'Política de Privacidad',
      'en': '',
    },
    'pxnwzj3h': {
      'es': 'Cerrar Sesión',
      'en': '',
    },
    'sdjnq3y4': {
      'es': 'Home',
      'en': '',
    },
  },
  // Planes
  {
    'g8wcoax1': {
      'es': 'Planes',
      'en': '',
    },
    '1n12gzth': {
      'es': '🟢 Base (Gratis con anuncios)',
      'en': '',
    },
    'zr3armsj': {
      'es':
          'Empieza a tomar control de tu dinero\n\n📅 Añadir eventos financieros manualmente (ingresos, gastos, ahorros)\n\n🗓️ Gestión completa desde el calendario\n\n✏️ Edición y eliminación limitada (afecta todas las recurrencias)\n\n📊 Hoja de balance del mes actual\n\n📈 Pronóstico básico de flujo de ingresos\n\n🧾 Visualización de facturas pendientes y pagadas\n\n🔔 Notificaciones predeterminadas (72h y mismo día)\n\n📢 Incluye anuncios',
      'en': '',
    },
    '8yr46qoo': {
      'es': 'Actualizar a Base con Anuncios',
      'en': '',
    },
    'cofn2o5a': {
      'es': 'Plan Actual',
      'en': '',
    },
    'lhre3ndz': {
      'es': '🔵 Base (Sin anuncios) x \$1.99 al mes ',
      'en': '',
    },
    'sd39jhmn': {
      'es':
          'Misma potencia, sin distracciones\n\n✅ Todo lo incluido en la versión Base\n\n🚫 Sin anuncios\n\n⚡ Experiencia más limpia y rápida',
      'en': '',
    },
    'ux0fy8w3': {
      'es': 'Actualizar a Base sin Anuncios',
      'en': '',
    },
    'cbbcmbe6': {
      'es': 'Plan Actual',
      'en': '',
    },
    'n8b3fnxc': {
      'es': '🟣 Premium (Todas las funciones) x \$9.99 al mes',
      'en': '',
    },
    'm67sp4zs': {
      'es':
          'Sistema completo para construir riqueza\n\n✅ Todo lo incluido en la versión Base mas:\n\n🔗 Vinculación con cuentas bancarias externas\n\n💳 Visualización de balance total (bancos + tarjetas)\n\n📅 Edición y eliminación de eventos independientes\n\n🔔 Notificaciones personalizadas (24h, 48h, 72h, 96h)\n\n📈 Flujo de efectivo anual\n\n💰 Pronóstico anual de ingresos, gastos y ahorros\n\n🎯 Creación y monitoreo de metas financieras\n\n🧠 Control financiero avanzado y automatizado',
      'en': '',
    },
    'srs3xf4m': {
      'es': 'Actualizar a Premium',
      'en': '',
    },
    'd76ouv8s': {
      'es': 'Plan Actual',
      'en': '',
    },
    'dmfm3rh3': {
      'es': 'Home',
      'en': '',
    },
  },
  // operations
  {
    'g4fvdlv8': {
      'es': 'Transacciones',
      'en': '',
    },
    '285a16rq': {
      'es': '....',
      'en': '',
    },
    '7o7nng08': {
      'es': 'Periodo ',
      'en': '',
    },
    'cytqamsy': {
      'es': 'Saldo Disponible',
      'en': '',
    },
    'ohs96x74': {
      'es': 'Pendientes',
      'en': '',
    },
    'afh1uauu': {
      'es': 'Registradas',
      'en': '',
    },
    'hcggy87v': {
      'es': 'Home',
      'en': '',
    },
  },
  // welcome
  {
    'tmi8jj9t': {
      'es': 'Home',
      'en': '',
    },
  },
  // AccionCrear
  {
    'hzna105s': {
      'es': 'Añadir',
      'en': '',
    },
    '1n5jgwc4': {
      'es': 'Ingresos',
      'en': '',
    },
    'aiotqwhc': {
      'es': 'Salario, préstamos, propinas...',
      'en': '',
    },
    'sco7c33u': {
      'es': 'Gastos',
      'en': '',
    },
    'ym8s63so': {
      'es': 'Suscripciones, facturas, deudas...',
      'en': '',
    },
    'sh89gyf2': {
      'es': 'Eventos Financieros',
      'en': '',
    },
    'iiw60dk6': {
      'es': 'Pagos de tarjetas, cierres de ciclos...',
      'en': '',
    },
    'he7l9oga': {
      'es': 'Ahorros',
      'en': '',
    },
    'ezekb3fd': {
      'es': 'Movimientos de efectivo a cuentas de ahorro...',
      'en': '',
    },
  },
  // ingreso
  {
    'nak72f8v': {
      'es': 'Ingreso',
      'en': '',
    },
    'r1xf2ued': {
      'es': 'Tipo',
      'en': '',
    },
    'nbkstgz0': {
      'es': 'Seleccionar...',
      'en': '',
    },
    '6sifcgxr': {
      'es': 'Search...',
      'en': '',
    },
    'hxjfhexu': {
      'es': 'Salario',
      'en': '',
    },
    'jws6ym4z': {
      'es': 'Propinas',
      'en': '',
    },
    'xluem7ez': {
      'es': 'Comisiones',
      'en': '',
    },
    'iu2eex6q': {
      'es': 'Venta',
      'en': '',
    },
    'zvvg5616': {
      'es': 'Regalias',
      'en': '',
    },
    '0y09ie3m': {
      'es': 'Préstamo',
      'en': '',
    },
    'hd7c4du0': {
      'es': 'Otro',
      'en': '',
    },
    '1jsp3k3f': {
      'es': 'Descripción (opcional)',
      'en': '',
    },
    'shv786po': {
      'es': 'Puedes dejar una breve descripción...',
      'en': '',
    },
    '87jnqffd': {
      'es': 'Monto ',
      'en': '',
    },
    '3eyn3nhx': {
      'es': 'Cantidad del efectivo...',
      'en': '',
    },
    '1hzpjk2o': {
      'es': '0',
      'en': '',
    },
    '8do17dfy': {
      'es': 'Ingreso recurrente',
      'en': '',
    },
    'pktf0xea': {
      'es': 'Frecuencia',
      'en': '',
    },
    '62wcjb56': {
      'es': 'Seleccionar...',
      'en': '',
    },
    'e3qowgnu': {
      'es': 'Search...',
      'en': '',
    },
    't7vddq58': {
      'es': 'Diario',
      'en': '',
    },
    'tlq2y488': {
      'es': 'Semanal',
      'en': '',
    },
    '72nvpdza': {
      'es': 'Quincenal',
      'en': '',
    },
    'ezxtnhn8': {
      'es': 'Mensual',
      'en': '',
    },
    'xv0oc039': {
      'es': 'Trimestral',
      'en': '',
    },
    '6gtu0op4': {
      'es': 'Anual',
      'en': '',
    },
    'sqy09t8s': {
      'es': 'Ajustes de Notificación',
      'en': '',
    },
    '85b3ytpz': {
      'es': '( Horas de antelación para recibir la notificación )',
      'en': '',
    },
    'yf8m56h4': {
      'es': '72',
      'en': '',
    },
    'yva3oern': {
      'es': '',
      'en': '',
    },
    '1zvpttq9': {
      'es': 'Search...',
      'en': '',
    },
    'qexd8ak6': {
      'es': '24',
      'en': '',
    },
    'ucqacvm7': {
      'es': '48',
      'en': '',
    },
    'tpj0gnuf': {
      'es': '72',
      'en': '',
    },
    'zuw6a6fr': {
      'es': '96',
      'en': '',
    },
    'ubns1aom': {
      'es': 'Añadir',
      'en': '',
    },
  },
  // cardBillCopy
  {
    'ixic4owu': {
      'es': 'Saving',
      'en': '',
    },
  },
  // Gasto
  {
    '97fe1qqr': {
      'es': 'Gasto',
      'en': '',
    },
    'td8dq3cm': {
      'es': 'Tipo',
      'en': '',
    },
    'cnzoi2i6': {
      'es': 'Seleccionar...',
      'en': '',
    },
    'p5zw222n': {
      'es': 'Search...',
      'en': '',
    },
    '5dcn854v': {
      'es': 'Factura',
      'en': '',
    },
    'l2aqbazy': {
      'es': 'Suscripción',
      'en': '',
    },
    'u3mncga9': {
      'es': 'Deuda',
      'en': '',
    },
    'hjbmq29f': {
      'es': 'Otro',
      'en': '',
    },
    'noqmetuh': {
      'es': 'Descripción (opcional)',
      'en': '',
    },
    'coajwhl4': {
      'es': 'Puedes dejar una breve descripción...',
      'en': '',
    },
    'b3clwz0e': {
      'es': 'Monto ',
      'en': '',
    },
    'y8ol0s6w': {
      'es': 'Cantidad del efectivo...',
      'en': '',
    },
    's1usey8f': {
      'es': '0',
      'en': '',
    },
    'znx8mqs5': {
      'es': 'Gasto recurrente',
      'en': '',
    },
    'qk9j07dm': {
      'es': 'Frecuencia',
      'en': '',
    },
    's4ld0l5y': {
      'es': 'Seleccionar...',
      'en': '',
    },
    'psx3wg5b': {
      'es': 'Search...',
      'en': '',
    },
    'l723uc52': {
      'es': 'Diario',
      'en': '',
    },
    'u3lxupbl': {
      'es': 'Semanal',
      'en': '',
    },
    'anu9aome': {
      'es': 'Quincenal',
      'en': '',
    },
    'tlyrhue1': {
      'es': 'Mensual',
      'en': '',
    },
    'wyq11rgz': {
      'es': 'Trimestral',
      'en': '',
    },
    '91oewpz4': {
      'es': 'Anual',
      'en': '',
    },
    'g098xmia': {
      'es': 'Ajustes de Notificación',
      'en': '',
    },
    'swdbx2rc': {
      'es': '( Horas de antelación para recibir la notificación )',
      'en': '',
    },
    'f2pcuhbv': {
      'es': '72',
      'en': '',
    },
    '8eos0e2h': {
      'es': '',
      'en': '',
    },
    'qi84zs4j': {
      'es': 'Search...',
      'en': '',
    },
    'xk9tj7n4': {
      'es': '24',
      'en': '',
    },
    'd72rl6nz': {
      'es': '48',
      'en': '',
    },
    'vtn4lve6': {
      'es': '72',
      'en': '',
    },
    '10z723aa': {
      'es': '96',
      'en': '',
    },
    '2wp0tze0': {
      'es': 'Añadir',
      'en': '',
    },
  },
  // EventoFinanciero
  {
    'y6tc0i65': {
      'es': 'Evento Financiero',
      'en': '',
    },
    'ekrspbsx': {
      'es': 'Tipo',
      'en': '',
    },
    '5s26bm7s': {
      'es': 'Seleccionar...',
      'en': '',
    },
    'e5ouairp': {
      'es': 'Search...',
      'en': '',
    },
    'fjn4emrs': {
      'es': 'Cierre de ciclo (estado de cuenta) de  tarjeta de crédito',
      'en': '',
    },
    'w8ds775y': {
      'es': 'Fecha limite de pago de tarjeta de crédito',
      'en': '',
    },
    '1wvjypr7': {
      'es': 'Otro',
      'en': '',
    },
    'ie1gjvn1': {
      'es': 'Descripción (opcional)',
      'en': '',
    },
    'c8rfxqzp': {
      'es': 'Nombre del banco y cuatro últimos dígitos de la targeta..',
      'en': '',
    },
    'alqrlo4d': {
      'es': 'Evento recurrente',
      'en': '',
    },
    'alg1ltuz': {
      'es': 'Frecuencia',
      'en': '',
    },
    'zr4by6bw': {
      'es': 'Seleccionar...',
      'en': '',
    },
    'bjn6w02x': {
      'es': 'Search...',
      'en': '',
    },
    'utewsfzs': {
      'es': 'Diario',
      'en': '',
    },
    'y17xqvb6': {
      'es': 'Semanal',
      'en': '',
    },
    'qliqd8zo': {
      'es': 'Quincenal',
      'en': '',
    },
    'zn36t7uw': {
      'es': 'Mensual',
      'en': '',
    },
    '16o9kigl': {
      'es': 'Trimestral',
      'en': '',
    },
    'h43t1ni5': {
      'es': 'Anual',
      'en': '',
    },
    'v49qdiqx': {
      'es': 'Ajustes de Notificación',
      'en': '',
    },
    'daxv087m': {
      'es': '( Horas de antelación para recibir la notificación )',
      'en': '',
    },
    'eh9begc8': {
      'es': '72',
      'en': '',
    },
    'cyr55hqe': {
      'es': '',
      'en': '',
    },
    'i5k6ghve': {
      'es': 'Search...',
      'en': '',
    },
    'g85j171q': {
      'es': '24',
      'en': '',
    },
    '7uxmqv24': {
      'es': '48',
      'en': '',
    },
    'q63ajx2e': {
      'es': '72',
      'en': '',
    },
    'nwoqfxi4': {
      'es': '96',
      'en': '',
    },
    'k61bc7u6': {
      'es': 'Añadir',
      'en': '',
    },
  },
  // ajustes
  {
    'rzj8w5zb': {
      'es': 'Este evento se repite ',
      'en': '',
    },
    '5htws18q': {
      'es': 'Categoría',
      'en': '',
    },
    'q11x5wpe': {
      'es': 'Información del Comercio',
      'en': '',
    },
    'hgqd25cj': {
      'es': 'Nombre: ',
      'en': '',
    },
    'urv07qc8': {
      'es': 'ID: ',
      'en': '',
    },
    'y3m7hivo': {
      'es': 'Sitio Web: ',
      'en': '',
    },
    'gb1i2ycp': {
      'es': 'Este evento esta vinculado a una Meta Financiera',
      'en': '',
    },
    'a6cfjds7': {
      'es':
          'Si desea Editar o Eliminar este evento debe de hacerlo en el apartado Metas Financieras en la meta correspondiente.',
      'en': '',
    },
    'mbp5inri': {
      'es': 'Editar Evento',
      'en': '',
    },
    'xt65smba': {
      'es': 'Eliminar Evento',
      'en': '',
    },
  },
  // eliminar
  {
    '311n6bnj': {
      'es': '¿Deseas eliminar este evento?',
      'en': '',
    },
    'j1jirkqa': {
      'es': 'Eliminar también eventos recurrentes.',
      'en': '',
    },
    'cw6gcryb': {
      'es': 'Cancelar Acción',
      'en': '',
    },
    'jsf6kq6a': {
      'es': 'Eliminar Evento',
      'en': '',
    },
  },
  // eliminarCuenta
  {
    'ozu0i2js': {
      'es': '¿Deseas eliminar esta cuenta?',
      'en': '',
    },
    '8l0pv8x6': {
      'es':
          'Si elimina esta cuenta, se eliminará también la lista de  eventos asociados a la misma.',
      'en': '',
    },
    'a30agwif': {
      'es': 'Cancelar Acción',
      'en': '',
    },
    'leyyj51n': {
      'es': 'Eliminar Cuenta',
      'en': '',
    },
  },
  // AjustesdeNoti
  {
    'y2s20spp': {
      'es': 'Ajustes de Notificaciones',
      'en': '',
    },
    'jdquut14': {
      'es':
          'Todas las notificaciones han sido configuradas para ejecutarse 72 horas previas a cada evento en el calendario y su modificación no está disponibles para este plan.',
      'en': '',
    },
    'p3md6mhg': {
      'es': 'Ajustes globales',
      'en': '',
    },
    'hu3iiofh': {
      'es': '',
      'en': '',
    },
    'yyrqp7ub': {
      'es': 'Search...',
      'en': '',
    },
    '6blvw7yu': {
      'es': 'Predeterminado ( Un mismo tiempo para todas las notificaciones )',
      'en': '',
    },
    'ij5wenm2': {
      'es': 'Independiente ( Cada evento define su tiempo de notificación )',
      'en': '',
    },
    'ezdvlokr': {
      'es': 'Horas de antelación',
      'en': '',
    },
    'dl12wnw8': {
      'es': '',
      'en': '',
    },
    'p7on21fc': {
      'es': 'Search...',
      'en': '',
    },
    '4o8tqkh9': {
      'es': '24',
      'en': '',
    },
    'bco6eskt': {
      'es': '48',
      'en': '',
    },
    'j2741zrr': {
      'es': '72',
      'en': '',
    },
    'oji9nq5r': {
      'es': '96',
      'en': '',
    },
    '939lghj0': {
      'es': 'Aceptar',
      'en': '',
    },
  },
  // terminos
  {
    'oq59rmz6': {
      'es': 'Términos del Servicio ',
      'en': '',
    },
    '5ivxvsyj': {
      'es':
          'Última actualización: Febrero 2026\n\nBienvenido a Gup Calendario.\nAl utilizar esta aplicación, usted acepta cumplir y estar legalmente sujeto a los siguientes Términos del Servicio. Si no está de acuerdo con alguno de estos términos, por favor no utilice la aplicación.\n\n1. Descripción del Servicio\n\nGup Calendario es una aplicación diseñada para ayudar a los usuarios a organizar sus eventos financieros, ingresos, gastos, facturas y planificación mensual mediante un calendario interactivo y herramientas de gestión financiera personal.\n\nLa aplicación no es un banco, institución financiera ni ofrece asesoría financiera profesional.\n\n2. Uso Responsable\n\nEl usuario se compromete a:\n\nProporcionar información veraz dentro de la aplicación.\n\nUtilizar la aplicación únicamente para fines personales y legales.\n\nNo intentar manipular, alterar o interferir con el funcionamiento del sistema.\n\n3. Exactitud de la Información\n\nGup Calendario organiza la información ingresada por el usuario, pero:\n\nNo garantiza la exactitud de cálculos si los datos ingresados por el usuario son incorrectos.\n\nNo se responsabiliza por decisiones financieras tomadas basadas en la información mostrada en la aplicación.\n\nEl usuario es el único responsable de la información que registra.\n\n4. Privacidad de los Datos\n\nToda la información ingresada por el usuario es privada y solo se utiliza para el funcionamiento de la aplicación.\n\nGup Calendario no vende ni comparte información personal con terceros.\n\n5. Disponibilidad del Servicio\n\nAunque nos esforzamos por mantener la aplicación disponible en todo momento, pueden existir interrupciones por mantenimiento, actualizaciones o causas técnicas fuera de nuestro control.\n\n6. Limitación de Responsabilidad\n\nGup Calendario no será responsable por:\n\nPérdidas financieras derivadas del uso de la aplicación.\n\nErrores en cálculos debido a información incorrecta proporcionada por el usuario.\n\nInterrupciones temporales del servicio.\n\n7. Actualizaciones y Cambios\n\nNos reservamos el derecho de modificar estos términos en cualquier momento. El uso continuo de la aplicación después de dichos cambios implica la aceptación de los nuevos términos.\n\n8. Terminación del Servicio\n\nPodemos suspender o cancelar el acceso de cualquier usuario que incumpla estos términos.\n\n9. Propiedad Intelectual\n\nTodo el diseño, lógica, estructura y funcionamiento de Gup Calendario son propiedad exclusiva de sus creadores y están protegidos por las leyes de propiedad intelectual.\n\n10. Contacto\n\nPara cualquier duda o soporte, puede contactarnos a través de la sección de soporte dentro de la aplicación.\n\nAl utilizar Gup Calendario, usted confirma que ha leído, entendido y aceptado estos Términos del Servicio.',
      'en': '',
    },
    'lngfke8o': {
      'es': 'Aceptar',
      'en': '',
    },
  },
  // Politica
  {
    'pej0j2zm': {
      'es': 'Política de Privacidad',
      'en': '',
    },
    'udw5vd2s': {
      'es':
          'Última actualización: 2 de mayo de 2026\n\nGold Up Group LLC (\"nosotros\", \"nuestro\" o \"la empresa\") opera la aplicación móvil Gold Up (la \"Aplicación\"). Esta Política de Privacidad describe cómo recopilamos, usamos, protegemos y compartimos tu información cuando utilizas nuestra Aplicación.\n\n1. Información que recopilamos\nPodemos recopilar los siguientes tipos de información:\n\nInformación personal\nNombre\nCorreo electrónico\nNúmero de teléfono\nCredenciales de acceso\nInformación financiera\nInformación de cuentas bancarias (a través de proveedores externos como Plaid)\nHistorial de transacciones\nSaldos de cuentas\nMetas financieras y datos de ahorro\nInformación del dispositivo\nTipo de dispositivo\nSistema operativo\nDirección IP\nDatos de uso de la aplicación\n2. Cómo utilizamos tu información\nUsamos la información recopilada para:\n\nProporcionar y operar la Aplicación\nConectar y mostrar tus cuentas financieras\nAnalizar tus ingresos, gastos y hábitos financieros\nAyudarte a gestionar presupuestos y metas financieras\nMejorar nuestros servicios y experiencia de usuario\nEnviar notificaciones, recordatorios y alertas\nGarantizar la seguridad y prevenir fraudes\n3. Servicios de terceros\nPodemos utilizar servicios de terceros que procesan información:\n\nPlaid – para conectar cuentas bancarias de forma segura\nGoogle Firebase – autenticación, base de datos y análisis\nGoogle Play – distribución de la aplicación\nEstos servicios tienen sus propias políticas de privacidad.\n\n4. Seguridad de la información\nImplementamos medidas técnicas y organizativas para proteger tu información. Sin embargo, ningún sistema es completamente seguro.\n\n5. Compartición de datos\nNo vendemos tu información personal.\n\nSolo compartimos datos en los siguientes casos:\n\nCon proveedores de servicios confiables (como Plaid)\nPara cumplir obligaciones legales\nPara prevenir fraudes o proteger nuestros derechos\n6. Control del usuario\nTienes derecho a:\n\nAcceder a tus datos\nSolicitar la eliminación de tu cuenta\nDesconectar tus cuentas bancarias\nDesactivar notificaciones\nPuedes hacerlo desde la aplicación o contactándonos.\n\n7. Privacidad de menores\nGold Up no está dirigida a menores de 13 años. No recopilamos información de menores de forma intencional.\n\n8. Cambios en esta política\nPodemos actualizar esta política en cualquier momento. Los cambios se publicarán en esta misma página.\n\n9. Contacto\nSi tienes preguntas, puedes contactarnos:\n\nGold Up Group LLC\nEmail:',
      'en': '',
    },
    'v8f93lno': {
      'es': ' support@goldupgroup.com',
      'en': '',
    },
    'ie6pk4yp': {
      'es':
          'Última actualización: 26 de marzo de 2026\n\nGold Up Group LLC (\"nosotros\", \"nuestro\" o \"la empresa\") opera la aplicación móvil Gold Up (la \"Aplicación\"). Esta Política de Privacidad describe cómo recopilamos, usamos, protegemos y compartimos tu información cuando utilizas nuestra Aplicación.\n\n1. Información que recopilamos\nPodemos recopilar los siguientes tipos de información:\n\nInformación personal\nNombre\nCorreo electrónico\nNúmero de teléfono\nCredenciales de acceso\nInformación financiera\nInformación de cuentas bancarias (a través de proveedores externos como Plaid)\nHistorial de transacciones\nSaldos de cuentas\nMetas financieras y datos de ahorro\nInformación del dispositivo\nTipo de dispositivo\nSistema operativo\nDirección IP\nDatos de uso de la aplicación\n2. Cómo utilizamos tu información\nUsamos la información recopilada para:\n\nProporcionar y operar la Aplicación\nConectar y mostrar tus cuentas financieras\nAnalizar tus ingresos, gastos y hábitos financieros\nAyudarte a gestionar presupuestos y metas financieras\nMejorar nuestros servicios y experiencia de usuario\nEnviar notificaciones, recordatorios y alertas\nGarantizar la seguridad y prevenir fraudes\n3. Servicios de terceros\nPodemos utilizar servicios de terceros que procesan información:\n\nPlaid – para conectar cuentas bancarias de forma segura\nGoogle Firebase – autenticación, base de datos y análisis\nGoogle Play – distribución de la aplicación\nEstos servicios tienen sus propias políticas de privacidad.\n\n4. Seguridad de la información\nImplementamos medidas técnicas y organizativas para proteger tu información. Sin embargo, ningún sistema es completamente seguro.\n\n5. Compartición de datos\nNo vendemos tu información personal.\n\nSolo compartimos datos en los siguientes casos:\n\nCon proveedores de servicios confiables (como Plaid)\nPara cumplir obligaciones legales\nPara prevenir fraudes o proteger nuestros derechos\n6. Control del usuario\nTienes derecho a:\n\nAcceder a tus datos\nSolicitar la eliminación de tu cuenta\nDesconectar tus cuentas bancarias\nDesactivar notificaciones\nPuedes hacerlo desde la aplicación o contactándonos.\n\n7. Privacidad de menores\nGold Up no está dirigida a menores de 13 años. No recopilamos información de menores de forma intencional.\n\n8. Cambios en esta política\nPodemos actualizar esta política en cualquier momento. Los cambios se publicarán en esta misma página.\n\n9. Contacto\nSi tienes preguntas, puedes contactarnos:\n\nGold Up Group LLC\nEmail:',
      'en': '',
    },
    'm7ymz0dp': {
      'es': 'Aceptar',
      'en': '',
    },
  },
  // CerrarSesi
  {
    'goa5fqqw': {
      'es': '¿Deseas cerrar la sesión?',
      'en': '',
    },
    'i0py4fim': {
      'es': 'Cancelar ',
      'en': '',
    },
    'xk2dpoag': {
      'es': 'Aceptar',
      'en': '',
    },
  },
  // EditarEvento
  {
    'dxsdhlib': {
      'es': 'Editar Evento',
      'en': '',
    },
    'ittwj46r': {
      'es': 'Tipo',
      'en': '',
    },
    'bm6bt7dg': {
      'es': '',
      'en': '',
    },
    'b7wchob5': {
      'es': 'Search...',
      'en': '',
    },
    'paumplas': {
      'es': 'Descripción (opcional)',
      'en': '',
    },
    '2pb67126': {
      'es': 'Puedes dejar una breve descripción...',
      'en': '',
    },
    '6agbstzt': {
      'es': 'Monto ',
      'en': '',
    },
    'n0s4p3f0': {
      'es': 'Cantidad del efectivo...',
      'en': '',
    },
    'uc28cxro': {
      'es': 'Editar también todas las recurrencias',
      'en': '',
    },
    'mm40ygy0': {
      'es': 'Frecuencia',
      'en': '',
    },
    'hildixv2': {
      'es': 'Seleccionar...',
      'en': '',
    },
    'pag61r7y': {
      'es': 'Search...',
      'en': '',
    },
    'zmnw3pdx': {
      'es': 'Diario',
      'en': '',
    },
    'fbupax7r': {
      'es': 'Semanal',
      'en': '',
    },
    'pa0leuxr': {
      'es': 'Quincenal',
      'en': '',
    },
    'jopkbkj0': {
      'es': 'Mensual',
      'en': '',
    },
    'qnirlmj3': {
      'es': 'Trimestral',
      'en': '',
    },
    'xxj5kcqe': {
      'es': 'Anual',
      'en': '',
    },
    'qiijo0z7': {
      'es': 'Ajustes de Notificación',
      'en': '',
    },
    '5zpt7j0h': {
      'es': '( Horas de antelación para recibir la notificación )',
      'en': '',
    },
    'k97rdoxo': {
      'es': '',
      'en': '',
    },
    'zvh5jcff': {
      'es': 'Search...',
      'en': '',
    },
    'qb7iolo4': {
      'es': '24',
      'en': '',
    },
    'y140w7ib': {
      'es': '48',
      'en': '',
    },
    'kcyv5x67': {
      'es': '72',
      'en': '',
    },
    'g89o8tzx': {
      'es': '96',
      'en': '',
    },
    'u7rmh6bb': {
      'es': 'Editar',
      'en': '',
    },
  },
  // Save
  {
    '4w1pry29': {
      'es': 'Ahorros',
      'en': '',
    },
    '4b7ln67a': {
      'es': 'Tipo',
      'en': '',
    },
    '3yox849c': {
      'es': 'Seleccionar...',
      'en': '',
    },
    'c70zmaqk': {
      'es': 'Search...',
      'en': '',
    },
    'vzt0drix': {
      'es': 'Transferencia entre cuentas',
      'en': '',
    },
    'tv1uw3nq': {
      'es': 'Depósito',
      'en': '',
    },
    'p2bsim9c': {
      'es': 'Otro',
      'en': '',
    },
    'xagkfr7g': {
      'es': 'Descripción (opcional)',
      'en': '',
    },
    '4g0ncbe2': {
      'es': 'Puedes dejar una breve descripción...',
      'en': '',
    },
    '1yowpdo8': {
      'es': 'Monto ',
      'en': '',
    },
    'ey9l77qp': {
      'es': 'Cantidad del efectivo...',
      'en': '',
    },
    '8p98mhdp': {
      'es': '0',
      'en': '',
    },
    'i5ftp4cb': {
      'es': 'Ahorro recurrente',
      'en': '',
    },
    'j1d4j96k': {
      'es': 'Frecuencia',
      'en': '',
    },
    '0n4v40dx': {
      'es': 'Seleccionar...',
      'en': '',
    },
    '2v42penb': {
      'es': 'Search...',
      'en': '',
    },
    'kjlvowt3': {
      'es': 'Diario',
      'en': '',
    },
    '3z5i99cg': {
      'es': 'Semanal',
      'en': '',
    },
    'w3o0pqb6': {
      'es': 'Quincenal',
      'en': '',
    },
    'w9pvml8n': {
      'es': 'Mensual',
      'en': '',
    },
    'jwmt0pcx': {
      'es': 'Trimestral',
      'en': '',
    },
    '87rhnrf3': {
      'es': 'Anual',
      'en': '',
    },
    'em3eo90m': {
      'es': 'Ajustes de Notificación',
      'en': '',
    },
    'ac5tmciv': {
      'es': '( Horas de antelación para recibir la notificación )',
      'en': '',
    },
    'p7isvi91': {
      'es': '72',
      'en': '',
    },
    '3ac9b5k5': {
      'es': '',
      'en': '',
    },
    'e6dbfi8n': {
      'es': 'Search...',
      'en': '',
    },
    'es7jl4z3': {
      'es': '24',
      'en': '',
    },
    '1n43r7ti': {
      'es': '48',
      'en': '',
    },
    '1lyyq24u': {
      'es': '72',
      'en': '',
    },
    '98u5yjjk': {
      'es': '96',
      'en': '',
    },
    'j7m1yd6e': {
      'es': 'Añadir',
      'en': '',
    },
  },
  // eliminarOtroGasto
  {
    '3gup9h38': {
      'es': '¿Deseas eliminar este evento?',
      'en': '',
    },
    'cwyrzs5h': {
      'es': 'Cancelar Acción',
      'en': '',
    },
    'wfghk420': {
      'es': 'Eliminar Evento',
      'en': '',
    },
  },
  // EditarotrGas
  {
    '3bb53nlq': {
      'es': 'Editar Evento',
      'en': '',
    },
    'da36zp0n': {
      'es': 'Descripción (opcional)',
      'en': '',
    },
    'ur6forym': {
      'es': 'Puedes dejar una breve descripción...',
      'en': '',
    },
    'wsbpdj00': {
      'es': 'Monto ',
      'en': '',
    },
    'hq35y13w': {
      'es': 'Cantidad del efectivo...',
      'en': '',
    },
    'gc6t5p44': {
      'es': 'Editar',
      'en': '',
    },
  },
  // infoOtrosGastos
  {
    '3uwhlbki': {
      'es': 'Otros Gastos Mensuales Estimados',
      'en': '',
    },
    '0g11g8b0': {
      'es':
          'Los otros gastos son todos aquellos desembolsos que no forman parte de tus gastos fijos o principales, pero que igualmente afectan tu flujo de efectivo mensual.\n\nEstos pueden incluir compras ocasionales, entretenimiento, suscripciones, imprevistos o cualquier gasto variable que no ocurre de manera constante, pero que suma a lo largo del mes.\n\nAunque suelen parecer pequeños o menos importantes, los otros gastos pueden tener un impacto significativo en tu balance financiero si no se controlan adecuadamente.\n\nDentro del cálculo del flujo de efectivo, los otros gastos se suman a los gastos principales:\n\nFlujo de efectivo mensual estimado = Ingresos − (Gastos + Otros gastos)\n\nIdentificar y monitorear estos gastos te permite tener una visión más completa de tu dinero, evitar fugas invisibles y tomar decisiones más conscientes para mantener un flujo de efectivo positivo.\n',
      'en': '',
    },
    '2e9u5k6u': {
      'es': 'Aceptar',
      'en': '',
    },
  },
  // infoFlujodeefectivo
  {
    '5mnpo9mm': {
      'es': 'Flujo de Efectivo Mensual Estimado',
      'en': '',
    },
    'bkh7hqxr': {
      'es':
          'El flujo de efectivo mensual estimado es una proyección que muestra cuánto dinero te quedará disponible al final del mes, una vez que se han considerado todos tus ingresos y tus gastos.\n\nEste indicador te permite anticiparte a tu situación financiera antes de que el mes termine, ayudándote a tomar decisiones más inteligentes sobre tu dinero, evitar déficits y planificar con mayor seguridad.\n\nEl cálculo es sencillo:\n\nFlujo de efectivo mensual estimado = Ingresos − Gastos \n\nLos ingresos incluyen todo el dinero que recibes durante el mes, como salario, ingresos adicionales o cualquier otra fuente de entrada.\nLos gastos representan tus obligaciones regulares, como renta, servicios, alimentación o transporte.\nLos otros gastos incluyen desembolsos adicionales, variables o no recurrentes que también impactan tu balance financiero.\n\nSi el resultado es positivo, significa que estás generando excedente y puedes ahorrar o invertir.\nSi es negativo, indica que estás gastando más de lo que ingresas y necesitas ajustar tus hábitos financieros.\n\nEl objetivo es mantener un flujo de efectivo positivo y creciente en el tiempo, como base para construir estabilidad y riqueza.\n',
      'en': '',
    },
    '6a7vv4kw': {
      'es': 'Aceptar',
      'en': '',
    },
  },
  // infoEfectivorestante
  {
    'i8fyxdw7': {
      'es': 'Efectivo Restante sin Categorizar',
      'en': '',
    },
    '7t1uv5t5': {
      'es':
          'El efectivo restante sin categorizar representa el dinero disponible después de haber considerado tu flujo de efectivo mensual y haber separado una parte para tus ahorros.\n\nEste valor muestra cuánto dinero aún no ha sido asignado a un propósito específico, dándote una visión clara de lo que puedes utilizar con mayor libertad o redistribuir de forma estratégica.\n\nEl cálculo es el siguiente:\n\nEfectivo restante sin categorizar = Flujo de efectivo mensual − Ahorros\n\nEste indicador es fundamental para evitar gastar sin control, ya que te permite identificar cuánto dinero realmente tienes disponible antes de tomar nuevas decisiones financieras.\n\nUn valor positivo indica que aún cuentas con margen para gastar, invertir o reasignar.\nUn valor bajo o negativo sugiere que debes ajustar tus gastos o revisar tu planificación para mantener el equilibrio financiero.\n\nGestionar correctamente este efectivo te ayuda a mantener el control total de tu dinero y a tomar decisiones más conscientes en tu camino hacia la construcción de riqueza.\n\n',
      'en': '',
    },
    'yoryvo2a': {
      'es': 'Aceptar',
      'en': '',
    },
  },
  // BankAcount
  {
    'ogdz1poa': {
      'es': '....',
      'en': '',
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
      'en': '',
    },
    'fvotkw8v': {
      'es': 'Fecha de la Transacción',
      'en': '',
    },
    'z1ld7e5i': {
      'es': 'Categoría',
      'en': '',
    },
    'dlbiwgkw': {
      'es': 'Información del Comercio',
      'en': '',
    },
    '5jd6fd0c': {
      'es': 'Nombre: ',
      'en': '',
    },
    'maxj3tld': {
      'es': 'ID: ',
      'en': '',
    },
    'e0setk01': {
      'es': 'Sitio Web: ',
      'en': '',
    },
  },
  // GoaldInfo
  {
    'h3zvofq7': {
      'es': 'Información de Meta Financiera',
      'en': '',
    },
    '11kg6irk': {
      'es': '',
      'en': '',
    },
    'clm33fy8': {
      'es': 'Cuenta',
      'en': '',
    },
    'tukmobsl': {
      'es': 'Us bank ',
      'en': '',
    },
    '1000ncyg': {
      'es': 'Save',
      'en': '',
    },
    'sxf76hee': {
      'es': '....5778',
      'en': '',
    },
    's26727ot': {
      'es': 'Monto de la Meta',
      'en': '',
    },
    '0pldfj7g': {
      'es': 'Monto Acumulado',
      'en': '',
    },
    '7sv7p17v': {
      'es': 'Monto Restante',
      'en': '',
    },
    'spgqh79n': {
      'es': 'Monto de las Cuotas',
      'en': '',
    },
    'yepr49ep': {
      'es': 'Estado',
      'en': '',
    },
    'o7uowarn': {
      'es': 'Fecha de Inicio',
      'en': '',
    },
    'z6te05a9': {
      'es': 'Fecha de Culminación',
      'en': '',
    },
    '6yehhhqp': {
      'es': 'Frecuencia',
      'en': '',
    },
    '6ddq3rbi': {
      'es': 'Número de Cuotas ',
      'en': '',
    },
    '1j0c7zlo': {
      'es': 'Cuotas Restantes',
      'en': '',
    },
    '7mywd3el': {
      'es': 'Descripción',
      'en': '',
    },
    'd315ld7r': {
      'es': 'Editar Meta Financiera',
      'en': '',
    },
    'aqs8ay02': {
      'es': 'Eliminar Meta Financiera',
      'en': '',
    },
  },
  // GoaldCreating
  {
    'svm8b7d1': {
      'es': 'Nueva Meta',
      'en': '',
    },
    'ppeg59y8': {
      'es': 'Nombre',
      'en': '',
    },
    'zsw9h5gr': {
      'es': 'Nombre de tu meta...',
      'en': '',
    },
    'mrwpgb5q': {
      'es': 'Descripción (opcional)',
      'en': '',
    },
    'rkym5y2k': {
      'es': 'Puedes dejar una breve descripción...',
      'en': '',
    },
    'dpsfmiex': {
      'es': 'Fecha de Inicio',
      'en': '',
    },
    '19oqb6ac': {
      'es': 'Fecha de Culminación',
      'en': '',
    },
    'wnlnn3ju': {
      'es': 'Frecuencia de Pago de las Cuotas',
      'en': '',
    },
    'ex259yaf': {
      'es': 'Seleccionar...',
      'en': '',
    },
    '282nxm3e': {
      'es': 'Search...',
      'en': '',
    },
    'kmzgn92i': {
      'es': 'Diario',
      'en': '',
    },
    '6s1znwyi': {
      'es': 'Semanal',
      'en': '',
    },
    'dz5880wp': {
      'es': 'Quincenal',
      'en': '',
    },
    '9nfu1a7d': {
      'es': 'Mensual',
      'en': '',
    },
    '01rs3ttk': {
      'es': 'Trimestral',
      'en': '',
    },
    'am9su8xh': {
      'es': 'Anual',
      'en': '',
    },
    'o7capmna': {
      'es': 'Monto Total de la Meta',
      'en': '',
    },
    'czekv8yc': {
      'es': 'Cantidad Total de la meta...',
      'en': '',
    },
    'tamj5w17': {
      'es': 'Número de cuotas ',
      'en': '',
    },
    '10fe6qcz': {
      'es': 'Tamaño de la Cuota',
      'en': '',
    },
    'qp5ofwzu': {
      'es': 'Cuenta Emisora (de donde se envian los fondos)',
      'en': '',
    },
    '1c71oi4g': {
      'es': 'Select...',
      'en': '',
    },
    'f4iejn0j': {
      'es': 'Search...',
      'en': '',
    },
    'gop3n9re': {
      'es': 'Option 1',
      'en': '',
    },
    'vq519gp4': {
      'es': 'Option 2',
      'en': '',
    },
    'ddfkfm8x': {
      'es': 'Option 3',
      'en': '',
    },
    '23xvfk9z': {
      'es': 'Cuenta Receptora ( La que recibe los fondos)',
      'en': '',
    },
    '28ekisda': {
      'es': 'Select...',
      'en': '',
    },
    'hwusspbn': {
      'es': 'Search...',
      'en': '',
    },
    'ubhwycag': {
      'es': 'Option 1',
      'en': '',
    },
    'pmz6rsxh': {
      'es': 'Option 2',
      'en': '',
    },
    '6tcsgmo2': {
      'es': 'Option 3',
      'en': '',
    },
    '8zjn73f9': {
      'es': 'Ajustes de Notificación',
      'en': '',
    },
    'qkvw6ba3': {
      'es': '( Horas de antelación para recibir la notificación )',
      'en': '',
    },
    'zpvtsl1i': {
      'es': '72',
      'en': '',
    },
    '1exd988d': {
      'es': '',
      'en': '',
    },
    '1b3861ky': {
      'es': 'Search...',
      'en': '',
    },
    'gipjzxme': {
      'es': '24',
      'en': '',
    },
    '1p98d3bu': {
      'es': '48',
      'en': '',
    },
    'qybg6zqz': {
      'es': '72',
      'en': '',
    },
    'z8mkg24y': {
      'es': '96',
      'en': '',
    },
    'a9a0q436': {
      'es': 'Crear ',
      'en': '',
    },
  },
  // ditarGoald
  {
    'ze49y43x': {
      'es': 'Editar  Meta',
      'en': '',
    },
    'yk59jgil': {
      'es': 'Nombre',
      'en': '',
    },
    'qi2ihfw7': {
      'es': 'Nombre de tu meta...',
      'en': '',
    },
    'fsbkajws': {
      'es': 'Descripción (opcional)',
      'en': '',
    },
    'vr7oim4f': {
      'es': 'Puedes dejar una breve descripción...',
      'en': '',
    },
    'eawdl1yo': {
      'es': 'Fecha de Inicio',
      'en': '',
    },
    'l33lmzmt': {
      'es': 'Fecha de Culminación',
      'en': '',
    },
    '3wk5nnsl': {
      'es': 'Seleccionar fecha...',
      'en': '',
    },
    'yus5xd1m': {
      'es': 'Monto Total de la Meta',
      'en': '',
    },
    '0vkgy6sy': {
      'es': 'Cantidad Total de la meta...',
      'en': '',
    },
    'urbyunnx': {
      'es': 'Frecuencia de la Cuota',
      'en': '',
    },
    'g3tgrqov': {
      'es': 'Seleccionar...',
      'en': '',
    },
    'gzn8t75x': {
      'es': 'Search...',
      'en': '',
    },
    'g2fvwi3j': {
      'es': 'Diario',
      'en': '',
    },
    'jtfvpfu2': {
      'es': 'Semanal',
      'en': '',
    },
    '1ew0awtw': {
      'es': 'Quincenal',
      'en': '',
    },
    'uk2d05u9': {
      'es': 'Mensual',
      'en': '',
    },
    'mp829wgt': {
      'es': 'Trimestral',
      'en': '',
    },
    'oe3yqfi2': {
      'es': 'Anual',
      'en': '',
    },
    '3g6k3lv1': {
      'es': 'Número de cuotas ',
      'en': '',
    },
    'frfrncfz': {
      'es': 'Tamaño de la Cuota',
      'en': '',
    },
    'd8vj6zoh': {
      'es': 'Cuenta Emisora (de donde se envian los fondos)',
      'en': '',
    },
    'ydm8e992': {
      'es': 'Select...',
      'en': '',
    },
    'mbpmjycx': {
      'es': 'Search...',
      'en': '',
    },
    'qr0jox13': {
      'es': 'Option 1',
      'en': '',
    },
    '8qs1xli9': {
      'es': 'Option 2',
      'en': '',
    },
    'gon5m95b': {
      'es': 'Option 3',
      'en': '',
    },
    '0pj7nsq2': {
      'es': 'Cuenta Receptora ( La que recibe los fondos)',
      'en': '',
    },
    'qkaizs97': {
      'es': 'Select...',
      'en': '',
    },
    'w9qsmscc': {
      'es': 'Search...',
      'en': '',
    },
    'g70zmztr': {
      'es': 'Option 1',
      'en': '',
    },
    'yrttzo5g': {
      'es': 'Option 2',
      'en': '',
    },
    '874v594n': {
      'es': 'Option 3',
      'en': '',
    },
    'h4byxrn9': {
      'es': 'Ajustes de Notificación',
      'en': '',
    },
    's5a09dy6': {
      'es': '( Horas de antelación para recibir la notificación )',
      'en': '',
    },
    'ti3i6c6r': {
      'es': '',
      'en': '',
    },
    '2ubunfsj': {
      'es': 'Search...',
      'en': '',
    },
    'l5hrpn0n': {
      'es': '24',
      'en': '',
    },
    'nirhb9u9': {
      'es': '48',
      'en': '',
    },
    'ldhpyl9w': {
      'es': '72',
      'en': '',
    },
    'gxreoyjk': {
      'es': '96',
      'en': '',
    },
    'lxex0fh8': {
      'es': 'Editar Meta',
      'en': '',
    },
  },
  // eliminarMeta
  {
    '7ww0rgna': {
      'es': '¿Deseas eliminar esta meta?',
      'en': '',
    },
    'g905qoyd': {
      'es': 'Conservas todos tus fondos en tu cuenta de ahorros.',
      'en': '',
    },
    '775o6jyi': {
      'es': 'Cancelar Acción',
      'en': '',
    },
    'kiz03qaf': {
      'es': 'Eliminar Meta ',
      'en': '',
    },
  },
  // ajustesDuplicados
  {
    'l3ycy71x': {
      'es':
          'Hemos encontrado dos movimientos que parecen representar la misma transacción.',
      'en': '',
    },
    'xz04ghwl': {
      'es':
          'Opciones:\n\nConservar movimiento del banco (recomendado)\nMantiene la sincronización automática y actualizaciones futuras.\n\nConservar movimiento manual\nÚtil si hiciste ajustes personalizados.',
      'en': '',
    },
    '2igk3ei3': {
      'es':
          'Seleccionar la opción correcta evitará que tu balance y tus proyecciones anuales se dupliquen.',
      'en': '',
    },
    'ee6r03oe': {
      'es': 'Mantener el Seleccionado',
      'en': '',
    },
    '0omjyja7': {
      'es': 'Ignorar y Mantener Ambos',
      'en': '',
    },
  },
  // newsViews
  {
    'isl7qn49': {
      'es': 'Leer mas...',
      'en': '',
    },
  },
  // Verificatucorreo
  {
    'snqulxdm': {
      'es': 'Verifica tu correo',
      'en': '',
    },
    'nijh9tt5': {
      'es':
          'Hemos enviado un enlace de verificación a tu correo electrónico.\nRevisa tu bandeja de entrada y haz clic en el enlace para activar tu cuenta.\n\nSi no lo ves, revisa la carpeta de spam.',
      'en': '',
    },
    'cc85de08': {
      'es': '¿No recibiste el correo?  ',
      'en': '',
    },
    'gf6f5mif': {
      'es': 'Reenviar',
      'en': '',
    },
    '3ev1pcim': {
      'es': 'Ya verifiqué mi correo',
      'en': '',
    },
  },
  // Biometria
  {
    'eyj49yki': {
      'es': '¿Deseas activar la verificación por Biometría?',
      'en': '',
    },
    'm0j2qs5f': {
      'es': '¿Deseas desactivar la verificación por Biometría?',
      'en': '',
    },
    '1xl92ebk': {
      'es': 'Cancelar ',
      'en': '',
    },
    'xwpaigw7': {
      'es': 'Activar',
      'en': '',
    },
    'xk0zaf17': {
      'es': 'Autentícate para acceder a tu cuenta',
      'en': '',
    },
    'sjcpba0p': {
      'es': 'Desactivar',
      'en': '',
    },
  },
  // bokimg
  {
    'd7pvzbe9': {
      'es':
          'Hay algo que sabes… pero no dices en voz alta:\n\nNo quieres una vida promedio.\nQuieres más dinero. Más libertad. Más control sobre tu tiempo.\n\nY lo quieres ahora… no dentro de 10 años.\n\nEste libro existe por eso.\n\nEl autor ya hizo el trabajo por ti:\nleyó, filtró y condensó lo mejor del mundo de la riqueza en un sistema claro, directo y accionable.\n\nAquí vas a entender por qué otros avanzan mientras tú sigues igual…\ny, lo más importante, cómo cambiarlo desde hoy.\n\nPorque la verdad es incómoda:\nno te falta capacidad… te falta dirección.\n\nY mientras lo piensas, otros ya están tomando lo que tú deseas.\n\nLa pregunta no es si puedes lograrlo…\nes si estás listo para dejar de esperar\ny empezar a construir.\n',
      'en': '',
    },
    '1twjul8e': {
      'es': 'Descubrir en Amazon',
      'en': '',
    },
    'y68vfliu': {
      'es': 'Cancelar Acción',
      'en': '',
    },
  },
  // BankAccounts
  {
    '7ymly05i': {
      'es': 'Cuentas Bancarias',
      'en': '',
    },
  },
  // eliminarCuentaDeBanco
  {
    'q9zz2dg3': {
      'es': '¿Deseas desvincular esta cuenta?',
      'en': '',
    },
    'v09ah60v': {
      'es':
          'Si desvinculas esta cuenta, se eliminarán todos los datos de la misma dentro de Gold Up y los  eventos asociados.',
      'en': '',
    },
    'kkpd3g6r': {
      'es': 'Cancelar Acción',
      'en': '',
    },
    'zrd9qi95': {
      'es': 'Desvincular Cuenta',
      'en': '',
    },
  },
  // correoEnviado
  {
    '2dhh6xvc': {
      'es': 'Hemos enviado un email',
      'en': '',
    },
    'jnpje9w9': {
      'es':
          'Hemos enviado un email a tu cuenta de correo electrónico para restablecer tu contraseña. ',
      'en': '',
    },
    'cm2ou1v8': {
      'es': 'Aceptar',
      'en': '',
    },
  },
  // ErrorBiometria
  {
    'fp1xpacb': {
      'es': 'Error de Biometría',
      'en': '',
    },
    'oyn5kdho': {
      'es':
          'No tienes activada la biometría en tu dispositivo. Por favor, actívala en los ajustes del sistema para continuar',
      'en': '',
    },
    '9l39i04f': {
      'es': 'Aceptar',
      'en': '',
    },
  },
  // CreditCard
  {
    'fr2wnasf': {
      'es': '....',
      'en': '',
    },
  },
  // Miscellaneous
  {
    'pa76gc43': {
      'es': 'Schedule',
      'en': '',
    },
    's0ch64wu': {
      'es': 'Cancel',
      'en': '',
    },
    '8em9bud8': {
      'es': 'Email Address',
      'en': '',
    },
    'vxz8in4x': {
      'es': 'Enter your email...',
      'en': '',
    },
    'jl66636i': {
      'es': 'Any further details needed?',
      'en': '',
    },
    'f100wut1': {
      'es': '',
      'en': '',
    },
    'xmywmuq8': {
      'es':
          'Esta aplicación necesita que aceptes recibir notificaciones. Usamos las notificaciones para avisarte con anticipación sobre ingresos, gastos y eventos financieros importantes de recordatorios programados, para que no se te pase nada.',
      'en': '',
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

// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<String> listenPlaidDeepLink() async {
  try {
    // Uri.base NO sirve en iOS/Android: en movil devuelve el directorio de
    // trabajo del proceso (file:///...), nunca el deep link entrante. Por eso
    // esta accion devolvia SIEMPRE '' en el telefono y el retorno de Plaid
    // nunca abria la pestaña de cuentas.
    //
    // defaultRouteName si trae la ruta con la que el sistema abrio la app.
    // Con FlutterDeepLinkingEnabled=true en Info.plist, iOS entrega ahi el
    // deep link: goldup://goldup.com/plaid-success?itemId=...
    //
    // LIMITE CONOCIDO: defaultRouteName es la ruta de ARRANQUE. Cubre el caso
    // de arranque en frio (la app fue cerrada mientras el usuario estaba en
    // Safari, cosa habitual por presion de memoria con navegador + app del
    // banco abiertos). Si la app solo estaba en segundo plano y se reanuda, el
    // valor no se actualiza. Cerrar ese caso exige un listener de deep links
    // (paquete app_links) mas un observador de ciclo de vida, que es un cambio
    // mayor y con dependencia nueva.
    final raw = WidgetsBinding.instance.platformDispatcher.defaultRouteName;
    if (raw.isEmpty || raw == '/') {
      return '';
    }

    final uri = Uri.tryParse(raw);
    if (uri == null) {
      return '';
    }

    // El scheme custom puede llegar entero (host 'goldup.com' y path
    // '/plaid-success') o ya normalizado a '/plaid-success'. Se cubren ambas
    // formas concatenando host y path antes de buscar.
    final target = '${uri.host}${uri.path}';
    if (!target.contains('plaid-success')) {
      return '';
    }

    return uri.queryParameters['itemId'] ?? '';
  } catch (e) {
    return '';
  }
}

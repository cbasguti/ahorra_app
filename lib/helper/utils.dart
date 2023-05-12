import 'package:intl/intl.dart';

/// Función para formatear un precio entero como dinero.
///
/// Toma un [price] entero y devuelve una cadena formateada
/// con el símbolo de dólar y separadores de miles.
String formatPrice(int price) {
  final formatter = NumberFormat("#,##0", "es_AR");

  // Formatear el precio con separadores de miles y el símbolo de dólar.
  String formattedPrice = '\$${formatter.format(price)}';

  // Devolver el precio formateado como una cadena.
  return formattedPrice;
}

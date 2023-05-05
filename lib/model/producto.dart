class Producto {
  String nombre;
  String imagen;
  String categoria;
  List prices;

  Producto({
    required this.nombre,
    required this.imagen,
    required this.categoria,
    required this.prices,
  });

  @override
  String toString() {
    return 'Nombre: $nombre\nImagen: $imagen\nCategoria: $categoria\nPrecios: $prices';
  }
}

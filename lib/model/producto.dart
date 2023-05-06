class Producto {
  int id;
  String nombre;
  String imagen;
  String categoria;
  Map precios;

  Producto({
    required this.id,
    required this.nombre,
    required this.imagen,
    required this.categoria,
    required this.precios,
  });

  // Getter for prices
  Map get getPrices => precios;

  // Get lowest price
  int getLowestPrice() {
    int lowestPrice = 999999999;
    precios.forEach((key, value) {
      if (value < lowestPrice) {
        lowestPrice = value;
      }
    });
    return lowestPrice;
  }

  // Get price by index
  int getPriceByIndex(int index) {
    int i = 0;
    int price = 0;
    precios.forEach((key, value) {
      if (i == index) {
        price = value;
      }
      i++;
    });
    return price;
  }

  // Get lowest price store
  String getLowestPriceStore() {
    int lowestPrice = 999999999;
    String lowestPriceStore = '';
    precios.forEach((key, value) {
      if (value < lowestPrice) {
        lowestPrice = value;
        lowestPriceStore = key;
      }
    });
    return lowestPriceStore;
  }

  // Get Store by index
  String getStoreByIndex(int index) {
    int i = 0;
    String store = '';
    precios.forEach((key, value) {
      if (i == index) {
        store = key;
      }
      i++;
    });
    return store;
  }

  Producto dummyProduct() {
    return Producto(
        id: 0,
        nombre: 'Leche Entera Colanta 1L',
        imagen: 'https://i.ibb.co/9Nx3hMy/colanta.jpg',
        categoria: 'Lacteos',
        precios: {
          'Exito': 3000,
          'Jumbo': 3500,
          'Carulla': 3200,
          'D1': 2900,
        });
  }

  @override
  String toString() {
    return 'Id: $id\nNombre: $nombre\nImagen: $imagen\nCategoria: $categoria\nPrecios: $precios';
  }
}

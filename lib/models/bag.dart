

class Bag {
  String name;
  String categoria;
  String description;
  String imagePath;
  List<Link> links;
  List<Product> products;

  Bag({
    required this.name,
    required this.categoria,
    required this.description,
    required this.imagePath,
    required this.links,
    required this.products,
   
  });
}

class Link {
  String wsp;
  String web;

  Link({
    required this.wsp,
    required this.web,
  });
  
}

class Product {
  String productName;
  String description;
  double price;
  double desc;
  String imagePro;

  Product({
    required this.productName,
    required this.description,
    required this.price,
    required this.desc,
     required this.imagePro,
  });
}

List<Bag> listOfBags() {
  return [
    Bag(
      name: 'CHIASSA',
      categoria: 'Moda',
      description: 'Bienvenido a Chiassa, donde la comodidad y el estilo se unen sin costuras. Somos una marca dedicada a ofrecerte la mejor experiencia en ropa interior, eliminando las molestias de las costuras tradicionales. Ven y conoce nuestros productos:Av. Larco 345 Int. S6 - Miraflores - Lima - Perú Horario de 11am a 2pm / 3pm a 8pm',
      imagePath: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCk4mN64jbDEi65LiiCTJl_ih20YpGav5B3w&s',
      links: [
        Link(web: 'https://chiassa.tiendada.com/' ,wsp: 'wa.link/fy3tw3')
      ],
      products: [
        Product(productName: 'Escote V - Rosa/M', description: 'Tallas X - L - XL', price: 120.50, desc: 33, imagePro: 'https://chiassa.tiendada.com/api/scrooge/file/FL-48AB5756' ),
        Product(productName: 'Silla ergonómica', description: 'Silla cómoda para oficina', price: 75.00, desc: 20, imagePro: '')
      ],
    ),
    Bag(
      name: 'Didi',
      categoria: 'FastFood',
      description: '',
      links: [],
      imagePath: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgjde4OlJg5vjEsU6MsGcJ6hUU5dpNijUJm0vVWLBLykFoyJmpAeoaRzVsvD4Cg6-Xpr8&usqp=CAU',
      products: [
        Product(productName: 'Hamburguesa', description: 'Hamburguesa clásica con queso', price: 8.50, desc: 20, imagePro: ''),
        Product(productName: 'Papas fritas', description: 'Porción grande de papas fritas', price: 3.50,desc: 20, imagePro: ''),
      ],
    ),
    Bag(
      name: 'Rappi',
      categoria: 'FastFood',
      description: '',
      links: [],
      imagePath: 'https://about.rappi.com/sites/default/files/styles/max_650x650/public/2022-11/20221025-101439welinkpc.png?itok=sUbQlIZb',
      products: [
        Product(productName: 'Pizza', description: 'Pizza familiar de pepperoni', price: 15.00, desc: 20, imagePro: ''),
        Product(productName: 'Refresco', description: 'Botella de 1 litro de refresco', price: 2.00, desc: 20, imagePro: ''),
      ],
    ),
    Bag(
      name: 'Amazon',
      categoria: 'Mueble',
      description: '',
      links: [],
      imagePath: 'https://www.antevenio.com/wp-content/uploads/2018/03/480X480-amazon-ads-como-funciona.jpg',
      products: [
        Product(productName: 'Lámpara de escritorio', description: 'Lámpara LED moderna', price: 25.99, desc: 20, imagePro: ''),
        Product(productName: 'Estante modular', description: 'Estante para libros y decoración', price: 60.00, desc: 20, imagePro: ''),
      ],
    ),
    Bag(
      name: 'FarmaInka',
      categoria: 'Salud',
      description: '',
      links: [],
      imagePath: 'https://kajabi-storefronts-production.kajabi-cdn.com/kajabi-storefronts-production/blogs/31115/images/EELn2Qe9TpmipXaqnynz_a6618a56339627.Y3JvcCwzMjkwLDI1NzUsMCwxNg.png',
      products: [
        Product(productName: 'Paracetamol', description: 'Caja de 20 tabletas de 500mg', price: 3.50, desc: 20, imagePro: ''),
        Product(productName: 'Alcohol en gel', description: 'Botella de 250ml', price: 2.99, desc: 20, imagePro: ''),
      ],
    ),
  ];
}

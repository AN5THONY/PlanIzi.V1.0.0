class Bag {
  String name;
  String categoria;
  String imagePath;


  Bag({
    required this.name,
    required this.categoria,
    required this.imagePath,
  });
}

  List<Bag> listOfBags() {
    return [
      Bag(name: 'Temu',
       categoria: 'Mueble',
       imagePath: 'https://ichef.bbci.co.uk/ace/ws/640/cpsprodpb/5cd6/live/11c97b70-e7e8-11ee-9410-0f893255c2a0.png.webp'),
      Bag(name: 'Didi',
      categoria: 'FastFood',
      imagePath: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgjde4OlJg5vjEsU6MsGcJ6hUU5dpNijUJm0vVWLBLykFoyJmpAeoaRzVsvD4Cg6-Xpr8&usqp=CAU'),
      Bag(name: 'Rappi', 
      categoria: 'FastFood',
      imagePath: 'https://about.rappi.com/sites/default/files/styles/max_650x650/public/2022-11/20221025-101439welinkpc.png?itok=sUbQlIZb'),
      Bag(name: 'Amazon', 
      categoria: 'Mueble',
      imagePath: 'https://www.antevenio.com/wp-content/uploads/2018/03/480X480-amazon-ads-como-funciona.jpg'),
      Bag(name: 'FarmaInka', 
      imagePath: 'https://kajabi-storefronts-production.kajabi-cdn.com/kajabi-storefronts-production/blogs/31115/images/EELn2Qe9TpmipXaqnynz_a6618a56339627.Y3JvcCwzMjkwLDI1NzUsMCwxNg.png',
       categoria: 'Salud')
    ];
  }

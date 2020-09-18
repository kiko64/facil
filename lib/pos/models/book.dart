class Book {
  final int id;
  final String name;
  final int numberOfPages;
  final double price;
  final String publicationDate;
  final bool status;

  const Book(
      {this.id,
      this.name,
      this.numberOfPages,
      this.price,
      this.publicationDate,
      this.status});

  factory Book.fromMap(Map map) {
    return Book(
        id: map['id'],
        name: map['name'],
        numberOfPages: map['numberOfPages'],
        price: map['price'],
        publicationDate: map['publicationDate'],
        status: map['status']);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'numberOfPages': numberOfPages,
      'price': price,
      'publicationDate': publicationDate,
      'status': status
    };
  }
}

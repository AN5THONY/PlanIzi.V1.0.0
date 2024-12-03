class PremiumOptionModel {
  final int months;
  final double price;
  final String description;
  final String discount;
  final bool isHighlighted;

  PremiumOptionModel({
    required this.months,
    required this.price,
    required this.description,
    required this.discount,
    required this.isHighlighted,
  });
}

class OrderHistory {
  final String time;
  final String location;
  final String carName;
  final String repairs;
  final String price;
  final String ctoName;
  final String isPerformed;

  const OrderHistory(
      {this.time,
      this.location,
      this.carName,
      this.repairs,
      this.ctoName,
      this.price,
      this.isPerformed});
}

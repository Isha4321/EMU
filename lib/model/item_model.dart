import 'dart:convert';

List<Item> itemFromJson(String str) => List<Item>.from(json.decode(str).map((x) => Item.fromJson(x)));

String itemToJson(List<Item> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Item {
  Item({
    required this.itemCode,
    required this.itemDesc,
    required this.dateofPurchase,
    required this.dateofIssue,
    required this.quantityInStock,
    required this.quantityIssued,
    required this.balancedStock,
    required this.location,
    required this.attendedBy,
    required this.remarks,
    required this.linkQr,

  });

  String itemCode;
  String itemDesc;
  String dateofPurchase;
  String dateofIssue;
  int quantityInStock;
  int quantityIssued;
  int balancedStock;
  String location;
  String attendedBy;
  String remarks;
  String linkQr;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    itemCode: json["itemCode"],
    itemDesc: json["itemDesc"],
    dateofPurchase: json["dateofPurchase"],
    dateofIssue: json["dateofIssue"],
    quantityInStock: json["quantityInStock"],
    quantityIssued: json["quantityIssued"],
    balancedStock: json["balancedStock"],
    location: json["location"],
    attendedBy: json["attendedBy"],
    remarks: json["remarks"],
    linkQr:json["linkQr"],
  );

  Map<String, dynamic> toJson() => {
    'itemCode':itemCode,
    'itemDesc':itemDesc,
    'dateofPurchase':dateofPurchase,
    'dateofIssue':dateofIssue,
    'quantityInStock':quantityInStock,
    'quantityIssued':quantityIssued,
    'balancedStock':balancedStock,
    'location':location,
    'attendedBy':attendedBy,
    'remarks':remarks,
    'linkQr':linkQr,

  };
}
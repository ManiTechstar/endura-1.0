class ChemicalListModel {
  String? name;
  String? gallonsDelivered;
  String? gallonsOnHand;
  String? recRate;
  String? actualRate;
  String? comments;
  String? rate;
  bool? soar;

  ChemicalListModel(
      {this.name,
      this.gallonsDelivered,
      this.gallonsOnHand,
      this.recRate,
      this.actualRate,
      this.comments,
      this.rate,
      this.soar});

  ChemicalListModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    gallonsDelivered = json['gallonsDelivered'];
    gallonsOnHand = json['gallonsOnHand'];
    recRate = json['recRate'];
    actualRate = json['actualRate'];
    comments = json['comments'];
    rate = json['rate'];
    soar = json['soar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['gallonsDelivered'] = gallonsDelivered;
    data['gallonsOnHand'] = gallonsOnHand;
    data['recRate'] = recRate;
    data['actualRate'] = actualRate;
    data['comments'] = comments;
    data['rate'] = rate;
    data['soar'] = soar;
    return data;
  }
}

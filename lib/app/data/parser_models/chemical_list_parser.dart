class ChemicalListParamsModel {
  String? name;
  String? gallonsDelivered;
  String? gallonsOnHand;
  String? recRate;
  String? actualRate;
  String? comments;
  String? rate;
  bool? soar;



  ChemicalListParamsModel(
      {this.name,
        this.gallonsDelivered,
        this.gallonsOnHand,
        this.recRate,
        this.actualRate,
        this.comments,
        this.rate,
        this.soar});


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

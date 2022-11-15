class ItemData {
  String? descricao;
  String? data;

  ItemData({this.descricao, this.data}) {
    descricao = this.descricao;
    data = this.data;
  }

  toJson() {
    return {
      "descricao": descricao,
      "data": data
    };
  }

  fromJson(jsonData) {
    return ItemData(
        descricao: jsonData['descricao'],
        data: jsonData['data']);
  }
}
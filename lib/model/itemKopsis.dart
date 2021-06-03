class ItemKopsis {
  //pembuatan atribut pada itemKopsis
  int _idKopsis;
  String _namaKopsis;
  int _tanggal;

  int get id => _idKopsis;

  String get namaKopsis => this._namaKopsis;
  set namaKopsis(String value) => this._namaKopsis = value;

  get tanggal => this._tanggal;
  set tanggal(value) => this._tanggal = value;

// konstruktor versi 1
  ItemKopsis(this._namaKopsis, this._tanggal);

// konstruktor versi 2: konversi dari Map ke Item
  ItemKopsis.fromMap(Map<String, dynamic> map) {
    this._idKopsis = map['id'];
    this._namaKopsis = map['namaKopsis'];
    this._tanggal = map['tanggal'];
  }
  
// konversi dari Item ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['idKopsis'] = this._idKopsis;
    map['namaKopsis'] = namaKopsis;
    map['tanggal'] = tanggal;
    return map;
  }
}

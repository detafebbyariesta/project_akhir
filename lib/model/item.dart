class Item {
  int _id;
  String _nama;
  String _namaBarang;
  int _price;
  int _stok;
  int _kodeBarang;

  int get id => _id;

  String get nama => this._nama;
  set nama(String value) => this._nama = value;

  String get namaBarang => this._namaBarang;
  set namaBarang(String value) => this._namaBarang = value;

  get price => this._price;
  set price(value) => this._price = value;

  get stok => this._stok;
  set stok(value) => this._stok = value;


  get kodeBarang => this._kodeBarang;
  set kodeBarang(value) => this._kodeBarang = value;

// konstruktor versi 1
  Item(this._nama, this._namaBarang, this._price, this._stok, this._kodeBarang);

// konstruktor versi 2: konversi dari Map ke Item
  Item.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._nama = map['nama'];
    this._namaBarang = map['namaBarang'];
    this._price = map['price'];
    this._stok = map['stok'];
    this._kodeBarang = map['kodeBarang'];
  }
  
// konversi dari Item ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['nama'] = nama;
    map['namaBarang'] = namaBarang;
    map['price'] = price;
    map['stok'] = stok;
    map['kodeBarang'] = kodeBarang;
    return map;
  }
}

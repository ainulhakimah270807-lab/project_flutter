class ImmutablePoint {

  final int x;
  final int y;

  const ImmutablePoint(this.x, this.y);
}

void main() {
  var point1 = const ImmutablePoint(10, 10);
  var point2 = const ImmutablePoint(10, 10);

  print(point1 == point2); 
  
  // hasilnya false karena point1 dan point2 dibuat dengan const, sehingga mereka adalah instance yang sama di memori.
  // kecuali jika ditambah cons akan bernilai true karena point1 dan point2 akan merujuk ke instance yang sama di memori.
}
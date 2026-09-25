Future<String> hello (String name){
  return Future.delayed(Duration(seconds: 2),(){
    return "Hello $name";

  }); // Future.delayed

}

void main () {
  hello("Ainul Hakimah")
    .then((value) => print(value));

  print(100);

}
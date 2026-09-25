Future<String> hello (String name){
  return Future.delayed(Duration(seconds: 2),(){
    // return "Hello $name";
    throw Error();
  }); // Future.delayed

}

void main () {
  hello("Ainul Hakimah")
    .onError((error, StackTrace)=> "404NotFound")
    .then((value) => print(value));

  print(100);

}
Future<String> hello (String name){
  // return Future.delayed(Duration(seconds: 2),(){
  // return "Hello $name";
  // throw Error();
  return Future.error(Exception("Ups"));

}

void main () {
  hello("Ainul Hakimah")
    // .onError((error, StackTrace)=> "404NotFound")
    .then((value) => print(value))
    .catchError((error)=> print('Error with message ${error.message}'));

  print('Regenerate');

}
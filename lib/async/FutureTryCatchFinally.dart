Future<String> hello (String name){

  // percobaan jika tidak error
  return Future.value("Hello $name");
  // percobaan jika error
  // return Future.error(Exception("Ups"));

}

void main () {
  hello("Ainul Hakimah")

    .then((value) => print(value))
    .whenComplete(() => print("Success to Generate"))
    .catchError((error)=> print('Error with message ${error.message}'));

  print('Regenerate');

}
Future<void> hello (){
  return Future.delayed(Duration(seconds: 2),(){

    print("Ainul Hakimah");

  }); // Future.delayed

}

void main () {
  hello();
  print('Done');

}
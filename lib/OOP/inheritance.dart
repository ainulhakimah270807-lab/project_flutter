class Manager {
  String? name;
  void sayHello (String name) {
    print('Hello $name,my name is ${this.name}');

  }

}
class VicePresident extends Manager {
}

void main ( ){
  var manager = Manager();
  manager.name = 'Ainul';
  manager.sayHello('Hakimah');

  var vp = VicePresident();
  vp.name = "Abid";
  vp.sayHello ("Farkhan");


}
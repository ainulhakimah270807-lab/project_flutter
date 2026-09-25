class Manager {
  String? name;
  void sayHello (String name) {
    print('Hello $name,my name is ${this.name}');

  }

}

// bisa langsung di copas dari parent ke child untuk void sayHello dan pr
class VicePresident extends Manager {
  void sayHello (String name) {
    print('Hello $name,my name is ${this.name}');

  }

}
// Run | Debug | Profile
void main ( ){
  var manager = Manager();
  manager.name = 'Ainul';
  manager.sayHello('Hakimah');
}
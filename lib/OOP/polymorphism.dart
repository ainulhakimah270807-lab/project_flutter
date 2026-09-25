class Employee {
  String name;
  Employee(this.name);
}

class Manager extends Employee {
  Manager(String name) : super(name);
}

class VicePresident extends Manager {
  VicePresident(String name) : super(name);
}

void main() {
  Employee employee = Employee('Ainul');
  print(employee);

  // contoh polymophisme, disini mencoba merubah bentuk dari employee ke manager
  employee = Manager('Hakimah');
  print(employee);

  // polymorphism employee ke VP
  employee = VicePresident("Farkhan");
  print(employee);
}
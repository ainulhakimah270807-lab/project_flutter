//setelah void tidak ada print atau say hello, print dide

void main () {
  var upperFunction = (String name){
    return name.toUpperCase();
  };

  var lowerFunction = (String name) => name.toLowerCase();
  var result1 = upperFunction ('Ainul');
  print(result1);

  var result2 = lowerFunction ("Hakimah");
  print(result2);
}
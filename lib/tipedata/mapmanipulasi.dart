void main( ){

var name = <String, String>{};

name['first'] = 'Ainul';
name['middle'] = 'Hakimah';
name['last'] = 'Yaqin'; 

print(name);
print(name['first']);

name ['middle'] = 'Farhan';
name.remove('last');

print(name);

}
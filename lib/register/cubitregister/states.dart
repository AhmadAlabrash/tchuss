

abstract class Statesocialregister {}

class Iniatialshop extends Statesocialregister {}

class Registersuccess extends Statesocialregister {
  String? la;
  Registersuccess(this.la);
}

class Registerfailed extends Statesocialregister {}

class Registerloading extends Statesocialregister {}

class Createuserfailed extends Statesocialregister {}

class Createusersuccess extends Statesocialregister {}

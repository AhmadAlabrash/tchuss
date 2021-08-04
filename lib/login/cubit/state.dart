abstract class Statesociallogin {}

class Iniatialsocial extends Statesociallogin {}

class Loginsuccess extends Statesociallogin {
  String? la;
  Loginsuccess(this.la);
}

class Loginfailed extends Statesociallogin {}

class Loginloading extends Statesociallogin {}

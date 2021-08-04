import 'package:tchuss/model/usermodel.dart';

abstract class Stateshome {}

class Iniatialsocialhome extends Stateshome {}

class Getdatasuccess extends Stateshome {
  Usermodel? la;
  Getdatasuccess(this.la);
}

class Getdatafailed extends Stateshome {}

class Homechangebottom extends Stateshome {}

class Getdataloading extends Stateshome {}

class Homepost extends Stateshome {}

class Getimagesuccess extends Stateshome {}

class Getimagefailed extends Stateshome {}

class Getimagecoversuccess extends Stateshome {}

class Getimagecoverfailed extends Stateshome {}

class Getimagepostsuccess extends Stateshome {}

class Getimagepostfailed extends Stateshome {}

class Postimagesuccess extends Stateshome {}

class Postimagefailed extends Stateshome {}

class Postimagecoversuccess extends Stateshome {}

class Postimagecoverfailed extends Stateshome {}

class Uploadsuccess extends Stateshome {}

class Uploadfailed extends Stateshome {}

class RemoveImage extends Stateshome {}

class Uploaddatasuccess extends Stateshome {}

class Uploaddatafailed extends Stateshome {}

class Postpostsuccess extends Stateshome {}

class Postpostfailed extends Stateshome {}

class Getpostsuccess extends Stateshome {}

class Getpostfailed extends Stateshome {}

class Postloading extends Stateshome {}

class Postloadingnoimage extends Stateshome {}

class Postlikesuccess extends Stateshome {}

class Postilikefailed extends Stateshome {}

class Getalluserssuccess extends Stateshome {}

class Getallusersfailed extends Stateshome {}

class Sendmessagesuccess extends Stateshome {}

class Sendmessagefailed extends Stateshome {}

class Sendmessageanothersuccess extends Stateshome {}

class Sendmessageanotherfailed extends Stateshome {}

class Getmessages extends Stateshome {}

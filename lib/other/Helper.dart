
class Method{
  static List<User> loggedUser = [];
  static  var lawyerTypes = ['Criminal Lawyer','Civil Lawyer','Business lawyer',
    'Immigration Lawyer','Tax Lawyer','Family lawyer','Labor Lawyer'];

  static var cities = ['Rawalpindi','Lahore','Islamabad','Karachi','Peshawar','Quetta'];
  static var courts = ['Supreme Court','High Court','Lower Court'];

  static List<Personal> personalInfo = [];
}


class User{
  var fname,lname,email,password,type,gender,picture,contact,status;
   User({this.fname,this.lname,this.password,this.type,this.gender,
     this.picture,this.email,this.contact,this.status});
}

class Personal{ var address='',education='',city='',officeNo=''; }

class Case{ var cases ='',type='',won='',loss='',percentage='',total='';}




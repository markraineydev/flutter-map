class DataModel{

  late String name, email, id;

  DataModel(this.name, this.email);

  DataModel.fromMap(Map<String, dynamic> data){
    name = data["name"];
    email = data["email"];
  }

  Map<String, dynamic> toMap(){
    return {
      "name" : name,
      "email" : email,
    };
  }
}
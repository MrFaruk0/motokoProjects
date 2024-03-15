import Map "mo:base/HashMap";
import Text "mo:base/Text";

actor {

  type Name = Text;
  type Phone = Text;

  type Entry = {
    desc: Text;
    phone: Phone;

  };

  //variable
  //let immutable
  //var mutable

  let phonebook = Map.HashMap<Name, Entry>(0, Text.equal, Text.hash); //0 hashmapin başlamasını istedğimiz değer

  //functions
  //query => sorgulamak
  //update güncelleme

  public func insert(name: Name, entry: Entry) : async (){
    phonebook.put(name, entry);

  };

  public query func lookup(name: Name) : async ?Entry { //soru işareti ne olursa olsun döndür demek
    phonebook.get(name) //return phonebook.get(name);
  };


};

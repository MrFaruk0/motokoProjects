import Icrc1Ledger "canister:icrc1_ledger_canister";
import Debug "mo:base/Debug";
import Result "mo:base/Result";
import Option "mo:base/Option"; //if gibi none some donduren
import Blob "mo:base/Blob"; //dosya döndürüyo
import Error "mo:base/Error"; //hatayı görmek için
import Nat "mo:base/Nat"; //naturel sayılar
import Principal "mo:base/Principal";

actor {

  type Account = {
    owner : Principal; //genel olarak herşeyi kontrol etmek için kullanılan yapı
    subaccount : ?[Nat8];
  };

  type TransferArgs = {
    amount : Nat;
    toAccount : Account;
  };

  public shared ({caller}) func transfer(args : TransferArgs) : async Result.Result<Icrc1Ledger.BlockIndex, Text> {
    //shared çünkü 2 kullanıcı arası kullanabilmek için
    //caller parametresi çünkü çağırmak gerekiyo
    Debug.print(
      "Transferring"
      # debug_show(args.amount)
      # " token to account"
      # debug_show(args.toAccount)
    );
  };

  let transferArgs : Icrc1Ledger.TransferArgs = {
      memo = null;
      amount = args.amount; //TransferArgs üzerinden zaten bağlamıştık args.amount ile alabiliyoruz
      from_subaccount = null;
      fee = null;
      to = args.toAccount;
      created_at_time = null;
  };

  try {
    let transferResult = await Icrc1Ledger.icrc1_transfer(transferArgs); //işlemi bekle await

    switch (transferResult) {
      case(#Err(transferError)) {
        #err("Couldn't transfer funds:\n" # debug_show(transferError))
      };
      case (#Ok(blockIndex)) {return #ok blockIndex};
    };
  } catch (error: Error) {
    #err("Reject message: " # Error.message(error));
  };



};

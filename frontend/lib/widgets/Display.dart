import 'package:flutter/material.dart';
import 'package:life_debugger/data/User.dart';

void showUserDetails(User current, BuildContext context){
  showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      context: context,
      builder: (context){
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(current.profilePicURL,height: 150,),
              SizedBox(height: 15,),
              Text(current.name,style: TextStyle(fontSize: 25),),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.phone),
                  SizedBox(width: 10,),
                  Text(current.phoneNumber,style: TextStyle(fontSize: 20),)
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.email),
                  SizedBox(width: 10,),
                  Text(current.email,style: TextStyle(fontSize: 20),)
                ],
              ),
              SizedBox(height: 10,),
              if(current.mod)Container(
                padding: EdgeInsets.all(8.0),
                color: Colors.red,
                child: Text("Mod",style: TextStyle(fontSize: 20),),
              )
            ],
          ),
        );
      }

  );
}

void comingSoon(BuildContext context){
  showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      context: context,
      backgroundColor: Colors.white12,
      builder: (context){
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(child: Image.network("https://drive.google.com/uc?export=view&id=1HxUXxtbsqV93zijewUxGa808XQEjGOoL"))
            ],
          ),
        );
      }
      );
}

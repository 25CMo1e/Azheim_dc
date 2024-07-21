import 'package:azheim_care/pages/settings_page.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget{
  const MyDrawer({super.key});


  @override
  Widget build (BuildContext context){
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child:  Column(
        children: [
      //home title
      Padding(  
      padding:  const EdgeInsets.only(left:25.0, top:25),
      child: ListTile(
       title: const Text("H O M E"),
       leading: const Icon(Icons.home),
       onTap: () => Navigator.pop(context),
       ),
     ),
    
    //setting tile
      Padding(  
      padding:  const EdgeInsets.only(left:25.0, top:25),
      child: ListTile(                                                               
       title: const Text("S E T T L E"),
       leading: const Icon(Icons.settings),
       onTap: () {
         Navigator.pop(context);
         Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => SettingsPage(),
            ),
          );
       },
       ),
     ),
        
      ],)
    );
  }
}
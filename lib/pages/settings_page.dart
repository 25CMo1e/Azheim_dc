import 'package:azheim_care/themes/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget{
  const SettingsPage({super.key});

  @override
    Widget build(BuildContext context){
      return Scaffold(
        appBar: AppBar(
        title: const Text("S E T T I N G S"),
        ),
        body: Container(
          decoration: BoxDecoration(
            color:Theme.of(context).colorScheme.primary,
            ),
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(25),
        child: Row(
          children: [
      const Text("Dark Mode"),
      CupertinoSwitch(
        value: 
         Provider.of<ThemeProvider>(context,listen: false).isDarkMode, 
        onChanged: (value) => 
          Provider.of<ThemeProvider>(context, listen:false)
        .toggleTheme(),
         ),
        ],
        )
      ),
  
      );
  
    }
}
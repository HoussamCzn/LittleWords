import 'package:flutter/material.dart';

class Testbouton extends StatefulWidget {
  const Testbouton({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TestboutonState createState() => _TestboutonState();
}

class _TestboutonState extends State<Testbouton> {
  

  void _showConfirmationDialog() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) { 
        return Container(
          height: 200,
          child: Column(
            children: [
              
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  
                },
                child: Text("Jeter"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  
                },
                child: Text("Detruire"),
              ),
            ],
          ),
        );
      },
    );
  }


  // au lieu d'un Alertdialog je voudrais un Showmodalbottomsheet avec 2 boutons et un texte en dessous du texte j'ai un bouton qui ferme la fenetre 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Boutons avec confirmation"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _showConfirmationDialog,
              child: Text("bouton 1"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _showConfirmationDialog,
              child: Text("beton 2"),
            ),
            SizedBox(height: 16),
            
          ],
        ),
      ),
    );
  }
}

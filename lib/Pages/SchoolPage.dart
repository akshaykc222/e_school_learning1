
import 'package:ess_plus/Provider/LoginProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SchoolPage extends StatefulWidget {
  const SchoolPage({Key? key}) : super(key: key);

  @override
  _SchoolPageState createState() => _SchoolPageState();
}

class _SchoolPageState extends State<SchoolPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<LoginProvider>(
        builder: (_,provider,child){
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,

              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(provider.imageUrl),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(provider.schoolName,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
                )
              ],
            ),
          );
        },

      ),
    );
  }
}

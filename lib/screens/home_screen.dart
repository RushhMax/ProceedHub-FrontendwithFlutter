import 'package:flutter/material.dart';
import 'package:proceed_hub_frontend/constants/image_string.dart';
import 'package:proceed_hub_frontend/constants/text_string.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(image: AssetImage(iLOGO), height: height * 0.5 ),
            Column(
              children: [
                Text(tWelcomeTitle,
                style: Theme
                  .of(context)
                  .textTheme
                  .headlineLarge),
                Text(tWelcomeSubtitle,
                style: Theme
                  .of(context)
                  .textTheme
                  .bodyMedium),
              ],
            ),
            Row(
              children: [
                Expanded(child: OutlinedButton(onPressed: (){
                  Navigator.pushNamed(context, '/login');
                }, child: Text('LOGIN'))),
                SizedBox(width: 20),
                Expanded(child:ElevatedButton(onPressed: (){
                  Navigator.pushNamed(context, '/register');
                }, child: Text('REGISTER'))),
              ],
            )
          ]
        ),
      )
      // Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       ElevatedButton(
      //         onPressed: () {
      //           Navigator.pushNamed(context, '/login');
      //         },
      //         child: Text('Login'),
      //       ),
      //       SizedBox(height: 20),
      //       ElevatedButton(
      //         onPressed: () {
      //           Navigator.pushNamed(context, '/register');
      //         },
      //         child: Text('Register'),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
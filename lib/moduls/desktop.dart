import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class DeskTopScreen extends StatelessWidget {
  const DeskTopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.teal,
              height: double.infinity,
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Login with your account',
                  style: Theme.of(context).textTheme.headline4
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Email'),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Password'),
                ),
                 SizedBox(
                  height: 15.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.teal,
                        height: 45.0,
                        child: MaterialButton(
                          onPressed: () {},
                          child: Text(
                            'login'.toUpperCase(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0,),
                      Expanded(
                      child: Container(
                        color: Colors.blue,
                        height: 45.0,
                        child: MaterialButton(
                          onPressed: () {},
                          child: Text(
                            'register'.toUpperCase(),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}

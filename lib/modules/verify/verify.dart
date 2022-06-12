import 'package:flutter/material.dart';

import 'otp.dart';

class Verify extends StatefulWidget {
  const Verify({Key key}) : super(key: key);

  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        },
          icon: const Icon(Icons.arrow_back_ios_outlined,
            color: Colors.black,),
        ),
      ),

      body:  SingleChildScrollView(
        child: Container(
            color: Colors.white,
            child: Column(
              children: [
                const Image(image: AssetImage('assets/images/logo black.png',
                ),
                  width: 125,
                  height: 125,),

                const SizedBox(
                  height: 24,
                ),

                const Text(
                  'Enter your phone number',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "we'll send you a verification code",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 28.0),                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,

                        ),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black26),
                              borderRadius: BorderRadius.circular(20)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.deepOrange,width: 2.0),
                              borderRadius: BorderRadius.circular(20)),

                          prefix: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              '(+02)',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          // suffixIcon: Icon(
                          //   Icons.highlight_remove_rounded,
                          //   color: Colors.grey,
                          // ),

                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        child: MaterialButton(
                          height: 55,
                          minWidth: 240,
                          elevation:5.0,
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const Otp()),
                            );
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),

                          child: const Text(
                            'Next',
                            style:
                            TextStyle(fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ),

    );
  }
}
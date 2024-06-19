import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OnBoardingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity, 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text("Welcome to PaP", 
                style: TextStyle(
                  color: Colors.black,
                  fontSize:27,
                  fontWeight:FontWeight.w700,
                )
              ),
              const SizedBox(
                height: 5,
              ),
              const Text("L'application qui vous aide à organiser tout type de célébrations", 
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 50,
              ),
           

              const SizedBox(
                height: 50,
              ),

              Expanded(
                child: Container(
                  width: double.infinity,

                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12, 
                        blurRadius: 5, 
                        spreadRadius: 2
                      )
                    ],
                    borderRadius: BorderRadius.only(topRight: Radius.circular(16), topLeft: Radius.circular(16))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                     
                      const Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Text("Party Planning",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20, 
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                     
                      const Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Text("Organiser des fêtes n'a jamais été facile à cause des dépenses et de tout le stress qu'elle nous apporte, l'application Party planning a été concu pour nous alléger la vie en ce qui concerne l'organisation des fêtes",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16, 
                            fontWeight: FontWeight.normal
                          ),
                        ),
                      ),
                     



                      const Padding(
                        padding: EdgeInsets.only(
                          left: 15,
                          right: 15,
                        )
                      ),
                                          
                      MaterialButton(
                        minWidth: double.infinity,
                        color: Colors.white,
                        elevation: 2,
                        onPressed: (){}, 


                        child: const Text("S'inscrire", 
                        style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff274560),
                        fontWeight: FontWeight.w500,
                      ),
                      ))

                      
                    ],
                  ),
                ),
              ),
            ]
          ),
        ),
      )
    );
  }
}
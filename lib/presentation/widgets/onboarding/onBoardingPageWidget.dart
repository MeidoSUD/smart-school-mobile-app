

import 'package:flutter/material.dart';

class OnBoardingPageWidget extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final bool showButton;
  final String buttonText;

  const OnBoardingPageWidget({super.key
  
      , required this.image
      , required this.title
      , required this.description
      , required this.showButton 
      , required this.buttonText 
      });

  @override
  Widget build(BuildContext context) {
    final  theme = Theme.of(context);
    return Stack(
        children: [
          
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.15,
            left: MediaQuery.of(context).size.width * 0.125,
            child: Container(
             
                padding: const EdgeInsets.all(0),
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.75,
                decoration:  BoxDecoration(
                color:  theme.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(40))
                ),
                child : Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                     
                      Text(title, style: const TextStyle(
                        
                        fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white)),
                      const SizedBox(height: 10),
                      Text(description, textAlign: TextAlign.center, 
                      style: const TextStyle(fontSize: 20, color: Colors.white70,)),
                     
                    
                      // Image.asset(image, height: 200),
                    ],
                  ),
                )  
              
            ),
          ),
      
        Positioned(
            top: MediaQuery.of(context).size.height * 0.05,
            left: MediaQuery.of(context).size.width * 0.125,

            child: Image.asset(image,
            fit: BoxFit.contain, 
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.75,  )
          ),

      


      
    ]
    );
  }
}
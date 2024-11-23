import 'package:flutter/material.dart';
import 'package:live_currency_rate/live_currency_rate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  bool isLoading = false;
String currentRate = "0";
String from = "USD";
String to = "LBP";
var currencyCode = [
    'KWD',
    'BHD',
    'OMR',
    'JOD',
    'GBP',
    'EUR',
    'KYD',
    'CHF',
    'USD',
    'SGD',
    'CAD',
    'AUD',
    'NZD',
    'ZAR',
    'INR',
    'LBP',  // Added Lebanon's currency code
  ];


 void fetchRate(String convertFrom , String convertTo, double amount) async{
  
        setState(() {
          isLoading = true;
        });
        CurrencyRate rates = await LiveCurrencyRate.convertCurrency(convertFrom, convertTo, amount); 
        setState(() {
          currentRate = rates.result.toStringAsFixed(2);
          isLoading = false;
                });
      }

 

  
  
  
  @override
  Widget build(BuildContext context){
    
    return Container(
      height: 100,
      width: 100,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [Colors.black,Colors.red],
        begin: Alignment.bottomLeft,
               end: Alignment.topRight)
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text("Currency converter",
          
          style: GoogleFonts.pressStart2p(
            fontSize: 15, color: Colors.white
          ) ),
          centerTitle: true,
        ),
        body:
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [ Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [DropdownButton(
                  value: from ,
                  items: currencyCode.map((String code) {
                  return DropdownMenuItem(
                    value: code,
                    child: Text(code),
                  );
                }).toList(), onChanged: (String? newValue) {
                  
                  setState(() {
                    from = newValue!;
                  });
                  fetchRate(from, to, double.parse(fromController.text));
                  
                }),
                                  SizedBox(
                                    width: 150.0,
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 30,
                                          color: Colors.white,
                                          
                                      ),
                                      
                                      cursorColor: Colors.white,
                                      onChanged: (value)=>{
                                        value == ""? fetchRate(from, to, 0):fetchRate(from, to, double.parse(value))
                                       
                                      },
                                      controller: fromController,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 15.0,
                                          horizontal: 10.0,
                                        ),
                                        border: InputBorder.none,
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(width: 3,
                                          color: Colors.white)
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(width: 3,
                                          color: Colors.white)
                                        ),
                                       
                                        focusColor: Colors.white,
                                        hintText: 'Amount',
                                        hintStyle: TextStyle(color: Colors.white,
                                        fontSize: 20)
                                      ),
                                    keyboardType: TextInputType.number,
                                     inputFormatters: <TextInputFormatter>[
                     FilteringTextInputFormatter.digitsOnly]
                     ),
                                  )
                                  
                              ]
                              
                 ),
            )
               ,
               
               Padding(
                 padding: const EdgeInsets.all(25),
                 
                 child: Align(alignment: Alignment.centerLeft,
                 child: Icon(Icons.cached,size: 50,color: Colors.white,),) ,
               ),
                           
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  DropdownButton(
                  value: to,
                  items: currencyCode.map((String code) {
                  return DropdownMenuItem(
                    value: code,
                    child: Text(code),
                  );
                }).toList(), onChanged: (String? newValue) {
                  setState(() {
                    to = newValue!;
                  }
                  );
                  fetchRate(from, to, double.parse(fromController.text));
                  
                }),
                                  Container(
                                    width: 150,
                                    decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(
                                        color: Colors.white,
                                        width: 3,
                                      )),
                                    
                                    
                                    ),
                                    
                                    
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 10
                                        ),
                                        child: Text(currentRate, style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                        
                                        ),
                                      ),
                                    
                                  
                                    ),
                                ],
                              ),
              ),
                         SizedBox(height: 40,) ,  
                        
                        isLoading? SizedBox(
                    width: 60.0, // Width of the spinner
                    height: 60.0, // Height of the spinner
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      strokeWidth: 5.0,
                    ),
                  ):Container(),
              
          ],
          ),
    )
    );
  }
}
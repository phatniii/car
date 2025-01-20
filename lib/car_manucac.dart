import 'package:car_manufac/car_mfr.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';


class CarManuFac extends StatefulWidget {
  const CarManuFac({super.key});

  @override
  State<CarManuFac> createState() => _CarManufacState();
}

class  _CarManufacState extends State<CarManuFac> {
  CarMfr?  carMfr;
  Future<CarMfr?> getCarMfr() async{
   
    var url = "vpic.nhtsa.dot.gov";

    var uri = Uri.https(url,"/api/vehicles/getallmanufacturers",{"format":"json"});
    // delay for 3 seconds
    await Future.delayed(const Duration(seconds: 3));
    var response = await get(uri);

    carMfr = carMfrFromJson(response.body);
    print(carMfr?.results![0].mfrName);

    return carMfr;
   
  }

  @override
  void initState() {
    super.initState();
    print("initiated...");
  }

  @override
  Widget build(BuildContext context) {
    print("building...");
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Account App",
          style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
        ),
        
      ),
      body: FutureBuilder(
        future: getCarMfr(), 
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            return Text("Finished loading data ${carMfr?.results![0].mfrName}");
          }
          return LinearProgressIndicator();
        },
      )
    );

  
  }
}
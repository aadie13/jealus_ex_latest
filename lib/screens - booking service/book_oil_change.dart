import 'package:flutter/material.dart';
import 'package:jealus_ex/screens%20-%20booking%20service/select_vehicle_forBooking.dart';
import 'date_time_picker.dart';


class BookOilChange extends StatefulWidget {
  @override
  _BookOilChangeState createState() => _BookOilChangeState();
}

class _BookOilChangeState extends State<BookOilChange> {
  //TODO: make the list items change color when one is selected and revert to original color when tapped again
  List<bool> _list1 = [false, false,false];
  //UserProfile serviceProvider = new UserProfile(name: "tbd", phone: "tbd", residenceType: "N/A", address: "TBD", vehicleMake: "N/A", vehicleModel: "N/A", vehicleYear: "N/A");
  //TODO: change the above from User to a mechanic
  //Creating temporary inputs for a new booking which will be edited across the booking process
  //Booking currentBooking = new Booking(serviceProvider: serviceProvider, startDate: startDate, startTimeHrs: startTimeHrs, startTimeMins: startTimeMins, service: service);
  //Service0708 currentService = new Service0708("Oil Change",null,null,null);
  String serviceName = "Oil Change";
  int serviceIndex = 1; // represents the first item in the servicesList in service_model.dart
  late String? typeSpecific;

  @override
  Widget build(BuildContext context) {
    bool pressAttention = false;
    return Scaffold(
      appBar: AppBar(
        title: Column(
            children: [
              Text("Oil Change", style: TextStyle(fontSize: 30.0),),
              GestureDetector(
                child: Text("User's Selected car make, model and year", style: TextStyle(fontSize: 12.0),),
                onTap: (){
                  print("tapped subtitle");
                  //TODO: add address of HOME, if user pressed address allow to change at his discretion
                  //TODO: if tapped on car, user can select from the list of its vehicles of add a new vehicle.
                },
              )
            ]),
        //TODO : Add a row showing the Car information and address
      ),

      body: Padding(
        padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 20.0),
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 20.0),
                child: ElevatedButton(
                  child: Container(
                    height: 50.0,
                    child: Center(
                      child: Text(
                        "Regular Oil Change",
                        style: TextStyle(fontSize: 28.0, color: Colors.black),
                      ),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _list1[0] = !_list1[0];
                      _list1[1] = false;
                      _list1[2] = false;
                      //typeSpecific = "Regular";
                    });
                  },
                  style: ElevatedButton.styleFrom
                    (
                    primary: _list1[0] ? Colors.grey : Colors.white70,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 20.0),
                child: ElevatedButton(
                  child: Container(
                    height: 50.0,
                    child: Center(
                      child: Text(
                        "Synthetic Oil Change",
                        style: TextStyle(fontSize: 28.0, color: Colors.black),
                      ),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _list1[1] = !_list1[1];
                      _list1[0] = false;
                      _list1[2] = false;
                      //typeSpecific = "Synthetic";
                    });
                  },
                  style: ElevatedButton.styleFrom
                    (
                    primary: _list1[1] ? Colors.grey : Colors.white70,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 20.0),
                child: ElevatedButton(
                  child: Container(
                    height: 50.0,
                    child: Center(
                      child: Text(
                        "Bring Your Own Oil",
                        style: TextStyle(fontSize: 28.0, color: Colors.black),
                      ),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _list1[2] = !_list1[2];
                      _list1[1] = false;
                      _list1[0] = false;
                      //typeSpecific = "Bring Your Own Oil"; //TODO: make this as a field of class Detailing
                      //TODO: Make each Service a class (Detailing, OilChange, TireSwap, Inspection, Battery Change.
                    });
                  },
                  style: ElevatedButton.styleFrom
                    (
                    primary: _list1[2] ? Colors.grey : Colors.white70,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:100.0, left: 20, right: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Est. Service Cost (Includes Labour cost) is XX Dollars",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:8.0),
                      child: Text("Est. Service duration is XX Hrs",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    //TODO: get data from mechanic app to fill in the value for the estimated cost and duration here
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: BottomAppBar(
          child: new Row(
            //crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              //SizedBox(width: MediaQuery.of(context).size.width * 0.60),
              Padding(
                padding: const EdgeInsets.only(top:12.0),
                child: Text("Proceed", style: TextStyle(fontSize: 26.0),),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0, bottom: 2.0),
                child: IconButton(
                    onPressed: (){
                      if (_list1[0] == true){
                        typeSpecific = "Regular";
                      } else if (_list1[1] == true){
                        typeSpecific = "Synthetic";
                      } else if (_list1[2] == true){
                        typeSpecific = "BYOO";
                      } else {
                        typeSpecific = null;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SelectVehiclesToBook(typeSpecific: typeSpecific,
                            serviceIndex: serviceIndex)),
                      );},
                    icon: Icon(Icons.keyboard_arrow_right, size: 50,)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

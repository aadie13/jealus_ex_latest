import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jealus_ex/models/booking_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jealus_ex/controllers/booking_controller.dart';
import 'package:jealus_ex/models/service_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'confirm_booking.dart';

class DateTimePicker extends StatefulWidget {

  final int serviceIndex;
  final String? typeSpecific;
  final String? detailingPackage;
  final int? numberOfTires2Swap;
  final int? numberofTires2Store;
  //const DateTimePicker(this.service);
  DateTimePicker({Key? key, required this.serviceIndex, this.typeSpecific, this.detailingPackage, this.numberOfTires2Swap, this.numberofTires2Store}) : super(key: key);
  @override
  _DateTimePickerState createState() => _DateTimePickerState();

}

class _DateTimePickerState extends State<DateTimePicker> {
  //final db = FirebaseFirestore.instance;
  double? _height;
  double? _width;
  //Service0708 service;
  String? _setTime, _setDate;

  String? _hour, _minute, _time;

  String? dateTime;


  DateTime selectedDate = DateTime.now();
  //Service0708 service;

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();


  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        //TODO; Understand what DatePicker MOde above is,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
       // widget.booking.startDate = selectedDate;
        //NOTE: added booking here
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        // widget.booking.startTimeHr = selectedTime.hour;
        // widget.booking.startTimeMins = selectedTime.minute;
        //NOTE: booking added here
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour! + ' : ' + _minute!;
        _timeController.text = _time!;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }

  @override
  void initState() {
    _dateController.text = DateFormat.yMd().format(DateTime.now());

    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    dateTime = DateFormat.yMd().format(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Date time picker'),
      ),
      body: Container(
        width: _width,
        height: _height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  'Choose Date',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5),
                ),
                InkWell(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Container(
                    width: _width! / 1.7,
                    height: _height! / 9,
                    margin: EdgeInsets.only(top: 30),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: TextFormField(
                      style: TextStyle(fontSize: 40),
                      textAlign: TextAlign.center,
                      enabled: false,
                      keyboardType: TextInputType.text,
                      controller: _dateController,
                      onSaved: (String? val) {
                        _setDate = val;
                      },
                      decoration: InputDecoration(
                          disabledBorder:
                          UnderlineInputBorder(borderSide: BorderSide.none),
                          // labelText: 'Time',
                          contentPadding: EdgeInsets.only(top: 0.0)),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  'Choose Time',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5),
                ),
                InkWell(
                  onTap: () {
                    _selectTime(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 30),
                    width: _width! / 1.7,
                    height: _height! / 9,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: TextFormField(
                      style: TextStyle(fontSize: 40),
                      textAlign: TextAlign.center,
                      onSaved: (String? val) {
                        _setTime = val;
                      },
                      enabled: false,
                      keyboardType: TextInputType.text,
                      controller: _timeController,
                      decoration: InputDecoration(
                          disabledBorder:
                          UnderlineInputBorder(borderSide: BorderSide.none),
                          // labelText: 'Time',
                          contentPadding: EdgeInsets.all(5)),
                    ),
                  ),
                ),
                Text(
                  widget.typeSpecific ?? " ",
                  style: TextStyle(fontSize: 20.0),
                ),
                Text(
                  //widget.booking.service.numberOfTires2Swap ?? " ",
                  widget.numberOfTires2Swap!=null ? widget.numberOfTires2Swap.toString() : "0",
                  style: TextStyle(fontSize: 20.0),
                ),
                Text(
                  //widget.booking.service.numberofTires2Store ?? " ",
                  widget.numberofTires2Store!=null ? widget.numberofTires2Store.toString(): "0",
                  style: TextStyle(fontSize: 20.0),
                ),
                RaisedButton(
                    child: Text("Confirm Dates"),
                    onPressed: () {
                      //await db.collection("Bookings").add(widget.booking.toJason());
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ConfirmBooking(typeSpecific: widget.typeSpecific,
                            serviceIndex: widget.serviceIndex, selectedDate: selectedDate, startTime: selectedTime,
                            detailingPackage: widget.detailingPackage, numberOfTires2Swap: widget.numberOfTires2Swap,
                            numberofTires2Store: widget.numberofTires2Store)),
                      );
                    }),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
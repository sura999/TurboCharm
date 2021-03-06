import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turbocharm/providers/car_provider.dart';
import 'package:turbocharm/services/database.dart';
import '../widgets/bottom_navigation.dart';
import './error_dialog.dart';
import '../screen/home/homepage_screen.dart';

class DropdownWidgets extends StatefulWidget {
  @override
  _DropdownWidgetsState createState() => _DropdownWidgetsState();
}

class _DropdownWidgetsState extends State<DropdownWidgets>
    with SingleTickerProviderStateMixin {
  String selectBrand;
  String selectCar;
  AnimationController _movementController;
  @override
  void initState() {
    _movementController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700))
          ..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _movementController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final carData = Provider.of<CarProvider>(context, listen: false);
    var brand = [];
    carData.items.forEach((element) {
      brand.add(element.brand);
    });

    final user = Provider.of<User>(context);
    return Column(
      children: <Widget>[
        DropdownButton(
            hint: Text('Choose Your Brand                ',
                style: TextStyle(
                    color: Colors.white60, fontWeight: FontWeight.w100)),
            value: selectBrand,
            onChanged: (newValue) {
              setState(() {
                selectBrand = newValue;
                selectCar = null;
              });
            },
            items: brand.toSet().toList().map((car) {
              return DropdownMenuItem(
                  child: Text(car, style: TextStyle(color: Colors.white)),
                  value: car);
            }).toList()),
        SizedBox(height: 15),
        DropdownButton(
            hint: Text('Choose Your Car                     ',
                style: TextStyle(
                    color: Colors.white60, fontWeight: FontWeight.w100)),
            value: selectCar,
            onChanged: (newValue) {
              setState(() {
                selectCar = newValue;
              });
            },
            items: carData.carName(selectBrand).toSet().toList().map((car) {
              return DropdownMenuItem(
                  child: Text(car, style: TextStyle(color: Colors.white)),
                  value: car);
            }).toList()),
        SizedBox(height: 10),
        IconButton(
            onPressed: () {
              if (selectBrand != null && selectCar != null) {
                DatabaseService(uid: user.uid).updateUserData(
                    carData.carIdByName(selectCar, selectBrand));
                Navigator.popAndPushNamed(context, BottomDownBar.routeName,
                    arguments: ScreenArguments(
                      selectBrand,
                      selectCar,
                    ));
              } else {
                showDialog(context: context, child: ErrorDialog());
              }
            },
            icon: AnimatedBuilder(
              animation: _movementController,
              builder: (context, child) {
                return Transform.translate(
                    child: child,
                    offset: Offset(_movementController.value * 4, 10));
              },
              child: Container(
                height: 30,
                child: Transform.translate(
                  offset: Offset(5, 0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 30,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
            )),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}

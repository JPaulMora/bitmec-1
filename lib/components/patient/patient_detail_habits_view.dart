import 'package:flutter/material.dart';

import 'package:bitmec/my_theme.dart';
import 'package:bitmec/screens.dart';
import 'package:bitmec/components.dart';
import 'package:bitmec/providers.dart';
import 'package:bitmec/models.dart';

class PatientDetailHabitsView extends StatefulWidget {
  @override
  _PatientDetailHabitsViewState createState() =>
      _PatientDetailHabitsViewState();
}

class _PatientDetailHabitsViewState extends State<PatientDetailHabitsView> {
  PatientProvider _provider;

  @override
  Widget build(BuildContext context) {
    if (_provider == null) {
      setState(() {
        _provider = PatientProvider.of(context);
      });
    }

    return SingleChildScrollView(
      child: ListOfSection(
        title: 'Hábitos',
        children: _buildList(context),
        onPressedAdd: () {
          Navigator.pushNamed(
            context,
            HabitCreateUpdateScreen.routeName,
            arguments: {'method': 'create'},
          );
        },
      ),
    );
  }

  List<Widget> _buildList(context) {
    if (_provider.object.habits.isEmpty) {
      return [Text('No hay hábitos registrados')];
    }

    return _provider.object.habits.map(
      (h) => _HabitCard(habit: h),
    ).toList();
  }
}

class _HabitCard extends StatelessWidget {
  final Habit habit;

  _HabitCard({ this.habit });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          HabitCreateUpdateScreen.routeName,
          arguments: {
            'method': 'update',
            'data': habit,
          }
        );
      },

      child: Card(
        child: Padding(
          padding: MyTheme.tenPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(habit.habit, style: TextStyle(
                    color: MyTheme.skyBlue,
                    fontSize: 24.0,
                  )),

                  Padding(padding: const EdgeInsets.symmetric(vertical: 5.0)),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('¿Lo practica actualmente?'),
                      Text(habit.practiceCurrently() ? 'Sí' : 'No',
                        style: TextStyle(color: MyTheme.skyBlue),
                      )
                    ],
                  )
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  color: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FormattedDate(habit.habitStartDate, prefix: 'Fecha de inicio: '),
                        FormattedDate(habit.habitEndDate, prefix: 'Fecha de fin:'),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

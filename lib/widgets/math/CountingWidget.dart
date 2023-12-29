import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'event/CountingEvent.dart';

class CountingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NumberBloc(),
      child: CountingView(),
    );
  }
}

class CountingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NumberBloc countingBloc = BlocProvider.of<NumberBloc>(context);
    return BlocProvider(
      create: (context) => countingBloc,
      child: Stack(alignment: Alignment.center, children: [
         Scaffold(
        appBar: AppBar(
          title: Text('Number List'),
        ),
        body: BlocBuilder<NumberBloc, Map<String, List<int>>>(
          builder: (context, numbers) {
            var list = numbers["Q"];
            return Column(
              children: [
                SizedBox(
                  height: 400,
                  child: ListView.builder(
                    itemCount: list!.length,
                    itemBuilder: (context, index) {
                      return NumberTile(number: list[index]);
                    },
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ...numbers["A"]!
                        .map((value) => ElevatedButton(
                            onPressed: () {
                              if(value == numbers["S"]!.first);

                              countingBloc.add(NumberPressedEvent());
                            }, child: Text(value.toString())))
                        .toList(),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    ]),
    );
  }
}

class NumberTile extends StatelessWidget {
  final int number;

  const NumberTile({Key? key, required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.all(8),
      child: Center(
        child: Text(
          '$number',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

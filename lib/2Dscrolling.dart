import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

class TableExample extends StatefulWidget {
  const TableExample({super.key});

  @override
  State<TableExample> createState() => _TableExampleState();
}

class _TableExampleState extends State<TableExample> {
  late final ScrollController _verticalController = ScrollController();

  List<int> numberList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
  List<String> stringList = [
    'one',
    'two',
    'three',
    'four',
    'five',
    'six',
    'seven',
    'eight',
    'nine',
    'ten',
    'eleven',
    'twelve',
    'thirteen',
    'fourteen',
    'fifteen'
  ];
  List<String> romanStringList = [
    'I',
    'II',
    'III',
    'IV',
    'V',
    'VI',
    'VII',
    'VIII',
    'IX',
    'X',
    'XI',
    'XII',
    'XIII',
    'XIV',
    'XV'
  ];
  List<double> doubleList = [
    1.0,
    2.0,
    3.0,
    4.0,
    5.0,
    6.0,
    7.0,
    8.0,
    9.0,
    10.0,
    11.0,
    12.0,
    13.0,
    14.0,
    15.0
  ];

  @override
  Widget build(BuildContext context) {
    List<dynamic> grid = [
      [...doubleList],
      [...stringList],
      [...romanStringList],
      [...doubleList]
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Table View with List'),
      ),
      body: TableView.list(
        verticalDetails: ScrollableDetails.vertical(controller: _verticalController),
        columnBuilder: _buildColumnSpan,
        cells: List.generate(
          numberList.length,
          (rowIndex) {
            return List.generate(
              grid.length,
              (colIndex) {
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '${grid[colIndex][rowIndex]}',
                    style: TextStyle(fontSize: 20),
                  ),
                );
              },
            );
          },
        ),
        rowBuilder: _buildRowSpan,
      ),
      persistentFooterButtons: <Widget>[
        TextButton(
          onPressed: () {
            _verticalController.jumpTo(0);
          },
          child: const Text('Jump to Top'),
        ),
        TextButton(
          onPressed: () {
            _verticalController
                .jumpTo(_verticalController.position.maxScrollExtent);
          },
          child: const Text('Jump to Bottom'),
        ),
      ],
    );
  }

  TableSpan _buildColumnSpan(int index) {
    const TableSpanDecoration decoration = TableSpanDecoration(
      border: TableSpanBorder(
        trailing: BorderSide(),
      ),
    );

    switch (index % 5) {
      case 0:
        return TableSpan(
          foregroundDecoration: decoration,
          extent: const FixedTableSpanExtent(100),
          onEnter: (_) => print('Entered column $index'),
          recognizerFactories: <Type, GestureRecognizerFactory>{
            TapGestureRecognizer:
                GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
              () => TapGestureRecognizer(),
              (TapGestureRecognizer t) =>
                  t.onTap = () => print('Tap column $index'),
            ),
          },
        );
      case 1:
        return TableSpan(
          foregroundDecoration: decoration,
          extent: const FractionalTableSpanExtent(0.5),
          onEnter: (_) => print('Entered column $index'),
          cursor: SystemMouseCursors.contextMenu,
        );
      case 2:
        return TableSpan(
          foregroundDecoration: decoration,
          extent: const FixedTableSpanExtent(120),
          onEnter: (_) => print('Entered column $index'),
        );
      case 3:
        return TableSpan(
          foregroundDecoration: decoration,
          extent: const FixedTableSpanExtent(145),
          onEnter: (_) => print('Entered column $index'),
        );
      case 4:
        return TableSpan(
          foregroundDecoration: decoration,
          extent: const FixedTableSpanExtent(200),
          onEnter: (_) => print('Entered column $index'),
        );
    }
    throw AssertionError(
        'This should be unreachable, as every index is accounted for in the switch clauses.');
  }

  TableSpan _buildRowSpan(int index) {
    final TableSpanDecoration decoration = TableSpanDecoration(
      color: index.isEven ? Colors.purple[100] : null,
      border: const TableSpanBorder(
        trailing: BorderSide(
          width: 3,
        ),
      ),
    );

    switch (index % 3) {
      case 0:
        return TableSpan(
          backgroundDecoration: decoration,
          extent: const FixedTableSpanExtent(50),
          recognizerFactories: <Type, GestureRecognizerFactory>{
            TapGestureRecognizer:
                GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
              () => TapGestureRecognizer(),
              (TapGestureRecognizer t) =>
                  t.onTap = () => print('Tap row $index'),
            ),
          },
        );
      case 1:
        return TableSpan(
          backgroundDecoration: decoration,
          extent: const FixedTableSpanExtent(65),
          cursor: SystemMouseCursors.click,
        );
      case 2:
        return TableSpan(
          backgroundDecoration: decoration,
          extent: const FractionalTableSpanExtent(0.15),
        );
    }
    throw AssertionError(
        'This should be unreachable, as every index is accounted for in the switch clauses.');
  }
}

// colIndex == 0
//   ? Padding(
//       padding: EdgeInsets.all(8.0),
//       child: Text(
//         '${numberList[rowIndex]}',
//         style: TextStyle(fontSize: 20),
//       ),
//     )
//   : colIndex == 1
//       ? Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Text(
//             '${stringList[rowIndex]}',
//             style: TextStyle(fontSize: 20),
//           ),
//         )
//       : colIndex == 2
//           ? Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text(
//                 '${romanStringList[rowIndex]}',
//                 style: TextStyle(fontSize: 20),
//               ),
//             )
//           : Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text(
//                 '${doubleList[rowIndex]}',
//                 style: TextStyle(fontSize: 20),
//               ),
//             );

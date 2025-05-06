// import 'package:flutter/material.dart';

// class PlansheetLogsScreen extends StatelessWidget {
//   const PlansheetLogsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: const Text(
//           'Plansheets Logs',
//           style: TextStyle(
//               fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           children: [
//             SizedBox(
//               height: 100,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   folderButton('100% DSA Submission'),
//                   const SizedBox(width: 12),
//                   folderButton('DSA Approved Plans - 8/21/23'),
//                   const SizedBox(width: 12),
//                   folderButton('DSA Approved Plans - 8/21/23'),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 12),
//             Wrap(
//               spacing: 8,
//               runSpacing: 8,
//               children: const [
//                 FilterInput(label: 'Plansheet Discipline'),
//                 FilterInput(label: 'Drawing No'),
//                 FilterInput(label: 'Revision'),
//                 FilterInput(label: 'Revision Date'),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Wrap(
//               spacing: 8,
//               runSpacing: 8,
//               children: const [
//                 FilterInput(label: 'Search'),
//                 FilterInput(label: 'AHJ Revision'),
//                 FilterInput(label: 'From Date'),
//                 FilterInput(label: 'To Date'),
//               ],
//             ),
//             const SizedBox(height: 4),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: const [
//                     Text(
//                       "Sets",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         decoration: TextDecoration.underline,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: DataTable(
//                     border: TableBorder.all(),
//                     columns: const [
//                       DataColumn(label: Text('Set No.')),
//                       DataColumn(label: Text('Size')),
//                       DataColumn(label: Text('Quantity')),
//                       DataColumn(label: Text('Remarks')),
//                       DataColumn(label: Text('Color')),
//                       DataColumn(label: Text('Material')),
//                       DataColumn(label: Text('Weight')),
//                       DataColumn(label: Text('Price')),
//                     ],
//                     rows: List.generate(
//                       4,
//                       (index) => DataRow(cells: [
//                         DataCell(Text('Set ${index + 1}')),
//                         DataCell(Text('XL')),
//                         DataCell(Text('20')),
//                         DataCell(Text('Ready')),
//                         DataCell(Text('Red')),
//                         DataCell(Text('Cotton')),
//                         DataCell(Text('10kg')),
//                         DataCell(Text('\$100')),
//                       ]),
//                     ),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget folderButton(String label) {
//     return Expanded(
//       child: Container(
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.black),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.folder, size: 30, color: Colors.black),
//             const SizedBox(height: 6),
//             Text(label,
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(fontSize: 10)),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class FilterInput extends StatelessWidget {
//   final String label;
//   const FilterInput({super.key, required this.label});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 150,
//       child: TextField(
//         decoration: InputDecoration(
//           labelText: label,
//           border: const OutlineInputBorder(),
//           isDense: true,
//         ),
//       ),
//     );
//   }
// }

// class TableHeader extends StatelessWidget {
//   final String title;
//   const TableHeader(this.title, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Text(
//         title,
//         style: const TextStyle(fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class PlansheetLogsScreen extends StatelessWidget {
  const PlansheetLogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Plansheets Logs',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  folderButton('100% DSA Submission'),
                  const SizedBox(width: 12),
                  folderButton('DSA Approved Plans - 8/21/23'),
                  const SizedBox(width: 12),
                  folderButton('DSA Approved Plans - 8/21/23'),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilterDropdown(
                    label: 'Plansheet Discipline',
                    items: ['Discipline 1', 'Discipline 2', 'Discipline 3']),
                FilterDropdown(
                    label: 'Revision',
                    items: ['Revision 1', 'Revision 2', 'Revision 3']),
                FilterDropdown(
                    label: 'AHJ Revision', items: ['AHJ 1', 'AHJ 2', 'AHJ 3']),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilterInput(label: 'Search'),
                FilterDatePicker(label: 'From Date', context: context),
                FilterDatePicker(label: 'To Date', context: context),
              ],
            ),
            const SizedBox(height: 4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Text(
                      "Sets",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    border: TableBorder.all(),
                    columns: const [
                      DataColumn(label: Text('Set No.')),
                      DataColumn(label: Text('Size')),
                      DataColumn(label: Text('Quantity')),
                      DataColumn(label: Text('Remarks')),
                      DataColumn(label: Text('Color')),
                      DataColumn(label: Text('Material')),
                      DataColumn(label: Text('Weight')),
                      DataColumn(label: Text('Price')),
                    ],
                    rows: List.generate(
                      4,
                      (index) => DataRow(cells: [
                        DataCell(Text('Set ${index + 1}')),
                        DataCell(Text('XL')),
                        DataCell(Text('20')),
                        DataCell(Text('Ready')),
                        DataCell(Text('Red')),
                        DataCell(Text('Cotton')),
                        DataCell(Text('10kg')),
                        DataCell(Text('\$100')),
                      ]),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget folderButton(String label) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.folder, size: 30, color: Colors.black),
            const SizedBox(height: 6),
            Text(label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 10)),
          ],
        ),
      ),
    );
  }
}

class FilterInput extends StatelessWidget {
  final String label;
  const FilterInput({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          isDense: true,
        ),
      ),
    );
  }
}

class FilterDropdown extends StatelessWidget {
  final String label;
  final List<String> items;
  const FilterDropdown({super.key, required this.label, required this.items});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: (value) {},
      ),
    );
  }
}

class FilterDatePicker extends StatelessWidget {
  final String label;
  final BuildContext context;
  const FilterDatePicker(
      {super.key, required this.label, required this.context});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        onTap: () async {
          final DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );
          if (pickedDate != null) {
            final formattedDate = "${pickedDate.toLocal()}".split(' ')[0];
          }
        },
      ),
    );
  }
}

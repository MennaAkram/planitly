import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';

class CustomTable extends StatefulWidget {
  const CustomTable({super.key});

  @override
  State<CustomTable> createState() => _DynamicTableExampleState();
}

class _DynamicTableExampleState extends State<CustomTable> {
  List<Map<String, String>> data = [
    {"Data": ""},
  ];

  List<Map<String, String>> savedRows = [];

  void addRow() {
    setState(() {
      final newRow = <String, String>{};
      for (var column in data.first.keys) {
        newRow[column] = "";
      }
      data.add(newRow);
    });
  }

  void addColumn() {
    setState(() {
      final newColumnKey = "Column${data.first.keys.length + 1}";
      for (var row in data) {
        row[newColumnKey] = "";
      }
    });
  }

  void updateColumnTitle(int columnIndex, String newTitle) {
    setState(() {
      String oldColumnKey = data.first.keys.elementAt(columnIndex);
      for (var row in data) {
        row[newTitle] = row.remove(oldColumnKey)!;
      }
    });
    saveTableData();
  }

  void updateCell(int rowIndex, String columnKey, String newValue) {
    setState(() {
      data[rowIndex][columnKey] = newValue;
    });
    saveTableData();
  }

  void saveTableData() {
    setState(() {
      savedRows = List.from(data);
    });
    debugPrint("Table data saved: $savedRows");
  }

  @override
  Widget build(BuildContext context) {
    final columnCount = data.first.keys.length + 1;
    final screenWidth = MediaQuery.of(context).size.width;
    final columnWidth = columnCount == 2 ? screenWidth / 2 : 200.0;

    return Padding(
      padding: const EdgeInsets.only(top: 56, bottom: 16),
      child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Table(
                  columnWidths: {
                    for (var i = 0; i < columnCount; i++) i: FixedColumnWidth(columnWidth),
                  },
                  border: TableBorder.all(
                    color: Theme.of(context).appColors.secondary,
                  ),
                  children: [
                    TableRow(
                      children: [
                        ...data.first.keys.map(
                              (key) => _buildCell(context, key, 0, key, isColumnTitle: true),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: IconButton(
                            onPressed: addColumn,
                            icon: Icon(
                              Icons.add,
                              size: 16,
                              color: Theme.of(context).appColors.primary,
                            ),
                            tooltip: "Add Column",
                          ),
                        ),
                      ],
                    ),
                    ...data.asMap().entries.map(
                          (entry) => TableRow(
                        children: [
                          ...entry.value.entries.map(
                                (cell) => _buildCell(
                              context,
                              cell.value,
                              entry.key,
                              cell.key,
                            ),
                          ),
                          Container(
                            height: 50,
                            alignment: Alignment.center,
                            child: Text(
                              " ",
                              style: Theme.of(context)
                                  .appTexts
                                  .labelLarge
                                  .copyWith(
                                color: Theme.of(context).appColors.black60,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Theme.of(context).appColors.secondary),
                  ),
                ),
                child: IconButton(
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                  onPressed: addRow,
                  icon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add,
                          size: 16, color: Theme.of(context).appColors.primary),
                      const SizedBox(width: 8),
                      Text(
                        "Add Row",
                        style: Theme.of(context).appTexts.labelLarge.copyWith(
                          color: Theme.of(context).appColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
    );
  }

  Widget _buildCell(BuildContext context, String? text, int rowIndex, String key,
      {bool readOnly = false, bool isColumnTitle = false}) {
    return Container(
      alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: TextFormField(
          maxLines: null,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          readOnly: readOnly,
          textAlign: TextAlign.center,
          initialValue: text,
          style: isColumnTitle ?
          Theme.of(context).appTexts.labelLarge.copyWith(
            color: Theme.of(context).appColors.black60) :
          Theme.of(context).appTexts.bodyMedium.copyWith(
            color: Theme.of(context).appColors.black87),
          onChanged: (newValue) {
            if (isColumnTitle) {
              updateColumnTitle(
                data.first.keys.toList().indexOf(key),
                newValue,
              );
            } else {
            updateCell(rowIndex, key, newValue);
            }
          },
          onFieldSubmitted: (newValue) {
            if (isColumnTitle) {
              updateColumnTitle(
                data.first.keys.toList().indexOf(key),
                newValue,
              );
            } else {
              updateCell(rowIndex, key, newValue);
            }
            FocusScope.of(context).requestFocus(FocusNode());
          }),
      );
  }

}

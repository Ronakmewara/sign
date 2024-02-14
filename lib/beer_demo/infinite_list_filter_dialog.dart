import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

class InfiniteListFilterBottomSheet extends StatefulWidget {
  const InfiniteListFilterBottomSheet({
    super.key,
    required this.onCancel,
    required this.onSubmit,
    required this.onReset,
  });

  final VoidCallback onCancel;
  final Function(String foodSearch, String brewedBefore, String brewedAfter)
      onSubmit;
  final VoidCallback onReset;

  @override
  State<InfiniteListFilterBottomSheet> createState() =>
      _InfiniteListFilteBottomSheetState();
}

class _InfiniteListFilteBottomSheetState
    extends State<InfiniteListFilterBottomSheet> {
  final TextEditingController brewedBeforeController = TextEditingController();
  final TextEditingController brewedAfterController = TextEditingController();
  final TextEditingController searchByFoodController = TextEditingController();

  DateTime? brewedBefore;
  DateTime? brewedAfter;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const Center(
                  child: Text(
                'Select filters',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Brewed Before',
                  suffix: const Align(
                      heightFactor: 1.0,
                      widthFactor: 1.0,
                      child: Icon(Icons.date_range)),
                ),
                controller: brewedBeforeController,
                readOnly: true,
                onTap: () async {
                  brewedBefore = await showMonthYearPicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1995),
                    lastDate: DateTime(2025),
                  );
                  if (brewedBefore != null) {
                    setState(() {
                      String formattedDate =
                          DateFormat('MM-yyyy').format(brewedBefore!);
                      brewedBeforeController.text = formattedDate;
                    });
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Brewed After',
                  suffix: const Align(
                      heightFactor: 1.0,
                      widthFactor: 1.0,
                      child: Icon(Icons.date_range)),
                ),
                controller: brewedAfterController,
                readOnly: true,
                onTap: () async {
                  brewedAfter = await showMonthYearPicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1995),
                    lastDate: DateTime(2025),
                  );
                  if (brewedAfter != null) {
                    setState(() {
                      String formattedDate =
                          DateFormat('MM-yyyy').format(brewedAfter!);
                      brewedAfterController.text = formattedDate;
                    });
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'filter By Food..',
                ),
                controller: searchByFoodController,
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        widget.onReset();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7))),
                      child: const Text(
                        'Reset',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                  Row(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            widget.onSubmit(
                                searchByFoodController.text,
                                brewedBeforeController.text,
                                brewedAfterController.text);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7))),
                          child: const Text('OK',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: ElevatedButton(
                            onPressed: () {
                              widget.onCancel();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7))),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ));
  }
}

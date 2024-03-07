import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:sizer/sizer.dart';

class InfiniteListFilterBottomSheet extends StatefulWidget {
  const InfiniteListFilterBottomSheet({
    super.key,
    required this.onCancel,
    required this.onSubmit,
    required this.onReset, required this.foodSearch, required this.brewedBefore, required this.brewedAfter,
  });

  final VoidCallback onCancel;
  final Function(String foodSearch, String brewedBefore, String brewedAfter) onSubmit;
  final VoidCallback onReset;
  final String foodSearch;
   final String brewedBefore;
  final String brewedAfter;

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
  void initState() {

    super.initState();

    searchByFoodController.text = widget.foodSearch;
    brewedAfterController.text = widget.brewedAfter;
    brewedBeforeController.text = widget.brewedBefore;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(

          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                const Text(
                  'Select filters',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  height: 0.01,
                  color: Colors.black26,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    labelText: 'Brewed Before',
                      suffixIcon:Icon(Icons.date_range,size: 25,) ,
                      isDense: true
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
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    labelText: 'Brewed After',
                      suffixIcon:Icon(Icons.date_range ,size: 25,) ,
      
                      isDense: true
      
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
                        String newFormattedDate =
                            DateFormat('MM-yyyy').format(brewedAfter!);
                        brewedAfterController.text = newFormattedDate;
                      });
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(
      
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
      
                    labelText: 'filter By Food',
                     suffixIcon:Icon(Icons.search,size: 25,) ,
                    isDense: true
                  ),
                  controller: searchByFoodController,
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
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
                      ],
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}

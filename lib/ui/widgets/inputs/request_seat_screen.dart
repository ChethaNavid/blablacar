import 'package:blablacar/ui/theme/theme.dart';
import 'package:flutter/material.dart';

class RequestSeatScreen extends StatefulWidget {
  final int requestedSeat;

  const RequestSeatScreen({super.key, this.requestedSeat = 1});

  @override
  State<RequestSeatScreen> createState() => _RequestSeatScreenState();
}

class _RequestSeatScreenState extends State<RequestSeatScreen> {
  late int selectedSeatCount;
  int seatLimit = 8;

  @override
  void initState() {
    super.initState();
    selectedSeatCount = widget.requestedSeat;
  }

  void onClose() {
    Navigator.pop(context);
  }

  void reduce() {
    if (selectedSeatCount > 1) {
      setState(() {
        selectedSeatCount--;
      });
    }
  }

  void add() {
    if (selectedSeatCount < seatLimit) {
      setState(() {
        selectedSeatCount++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: onClose,
          icon: Icon(Icons.clear, color: BlaColors.primary),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          spacing: 50,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Number of seats to book", style: BlaTextStyles.heading),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: reduce,
                  icon: Icon(
                    size: 30,
                    Icons.remove_circle_outline,
                    color: selectedSeatCount > 1
                        ? BlaColors.primary
                        : BlaColors.iconLight,
                  ),
                ),

                Text(selectedSeatCount.toString(), style: BlaTextStyles.heading),

                IconButton(
                  onPressed: add,
                  icon: Icon(
                    size: 30,
                    Icons.add_circle_outline,
                    color: selectedSeatCount < seatLimit
                        ? BlaColors.primary
                        : BlaColors.iconLight,
                  ),
                ),
              ],
            ),

            const Spacer(),

            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: BlaColors.primary,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () => Navigator.pop(context, selectedSeatCount),
                  icon: const Icon(Icons.arrow_forward, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

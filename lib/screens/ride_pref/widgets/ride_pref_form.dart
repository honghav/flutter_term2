import 'package:flutter/material.dart';
import 'package:flutter_ronanii/dummy_data/dummy_data.dart';

import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  final TextEditingController departureController = TextEditingController();
  final TextEditingController arrivalController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController seatsController = TextEditingController(text: '1');
  DateTime selectedDate = DateTime.now();

  void _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  void _openLocationSearch(TextEditingController controller) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LocationSearchScreen()),
    );
    if (result != null) {
      setState(() {
        controller.text = result;
      });
    }
  }


  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    // TODO
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------


  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------


  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: departureController,
            readOnly: true,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.location_on),
              hintText: "Leaving from",
              border: OutlineInputBorder(),
            ),
            onTap: () => _openLocationSearch(departureController),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: arrivalController,
            readOnly: true,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.location_on_outlined),
              hintText: "Going to",
              border: OutlineInputBorder(),
            ),
            onTap: () => _openLocationSearch(arrivalController),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: dateController,
            readOnly: true,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.calendar_today),
              hintText: "Today",
              border: OutlineInputBorder(),
            ),
            onTap: _selectDate,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: seatsController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.person),
              hintText: "1",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            child: const Text(
              "Search",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ]);
  }
}

class LocationSearchScreen extends StatefulWidget {
  const LocationSearchScreen({super.key});

  @override
  State<LocationSearchScreen> createState() => _LocationSearchScreenState();
}

class _LocationSearchScreenState extends State<LocationSearchScreen> {
  final TextEditingController searchController = TextEditingController();
  final List<Location> allLocations = fakeLocations;
  List<Location> filteredLocations = [];

  @override
  void initState() {
    super.initState();
    filteredLocations = List.from(allLocations);
  }

  void _filterLocations(String query) {
    setState(() {
      filteredLocations = allLocations
          .where((location) => location.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search Location")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search location",
                border: OutlineInputBorder(),
              ),
              onChanged: _filterLocations,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: filteredLocations.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("${filteredLocations[index].name}, ${filteredLocations[index].country.name}"),
                    onTap: () {
                      Navigator.pop(context, filteredLocations[index].name);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

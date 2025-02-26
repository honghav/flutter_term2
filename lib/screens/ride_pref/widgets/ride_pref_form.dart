import 'package:flutter/material.dart';
import 'package:flutter_ronanii/dummy_data/dummy_data.dart';
import 'new_widget.dart'; // Import the new widget
import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';

class RidePrefForm extends StatefulWidget {
  final RidePref? initRidePref;
  final Function(RidePref)? onSearch;

  const RidePrefForm({super.key, this.initRidePref, this.onSearch});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  Location? arrival;
  DateTime departureDate = DateTime.now();
  int requestedSeats = 1;
  bool isLoading = false; // Loading state for button

  final TextEditingController departureController = TextEditingController();
  final TextEditingController arrivalController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      arrival = widget.initRidePref!.arrival;
      departureDate = widget.initRidePref!.departureDate;
      requestedSeats = widget.initRidePref!.requestedSeats;

      departureController.text = departure?.name ?? '';
      arrivalController.text = arrival?.name ?? '';
      dateController.text = "${departureDate.toLocal()}".split(' ')[0];
    }
  }

  void _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: departureDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        departureDate = pickedDate;
        dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  void _openLocationSearch(TextEditingController controller, bool isDeparture) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LocationSearchScreen()),
    );
    if (result != null) {
      setState(() {
        controller.text = result;
        if (isDeparture) {
          departure = Location(name: result, country: Country.france); // Default country for now
        } else {
          arrival = Location(name: result, country: Country.france);
        }
      });
    }
  }

  void _switchLocations() {
    setState(() {
      String tempText = departureController.text;
      departureController.text = arrivalController.text;
      arrivalController.text = tempText;

      Location? tempLocation = departure;
      departure = arrival;
      arrival = tempLocation;
    });
  }

  bool get isSearchEnabled =>
      departureController.text.isNotEmpty &&
          arrivalController.text.isNotEmpty &&
          departure != null &&
          arrival != null &&
          departureDate.isAfter(DateTime.now());

  void _onSearch() {
    if (isLoading || !isSearchEnabled) return; // Prevent duplicate calls
    setState(() => isLoading = true);

    widget.onSearch?.call(
      RidePref(
        departure: departure!,
        arrival: arrival!,
        departureDate: departureDate,
        requestedSeats: requestedSeats,
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      setState(() => isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: departureController,
          readOnly: true,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.location_on),
            hintText: "Leaving from",
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: const Icon(Icons.swap_vert),
              onPressed: _switchLocations,
            ),
          ),
          onTap: () => _openLocationSearch(departureController, true),
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
          onTap: () => _openLocationSearch(arrivalController, false),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: dateController,
          readOnly: true,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.calendar_today),
            hintText: "Select Date",
            border: OutlineInputBorder(),
          ),
          onTap: _selectDate,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(Icons.person, size: 36),
            IconButton(
              onPressed: requestedSeats > 1
                  ? () => setState(() => requestedSeats--)
                  : null,
              icon: const Icon(Icons.remove_circle_outline, size: 30),
            ),
            Text(
              '$requestedSeats',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: () => setState(() => requestedSeats++),
              icon: const Icon(Icons.add_circle_outline, size: 30),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // CustomButton(
        //   text: isLoading ? "Searching..." : "Search",
        //   onPressed: isSearchEnabled && !isLoading ? _onSearch : null,
        // ),
      ],
    );
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
          .where((location) =>
          location.name.toLowerCase().contains(query.toLowerCase()))
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
                    title: Text(
                      "${filteredLocations[index].name}, ${filteredLocations[index].country.name}",
                    ),
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

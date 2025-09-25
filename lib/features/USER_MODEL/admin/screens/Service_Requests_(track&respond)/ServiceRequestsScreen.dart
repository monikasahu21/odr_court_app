import 'package:flutter/material.dart';

class ServiceRequestsScreen extends StatefulWidget {
  const ServiceRequestsScreen({super.key});

  @override
  State<ServiceRequestsScreen> createState() => _ServiceRequestsScreenState();
}

class _ServiceRequestsScreenState extends State<ServiceRequestsScreen> {
  List<Map<String, String>> requests = [
    {
      "reqId": "REQ101",
      "user": "Amit Sharma",
      "subject": "Login issue",
      "date": "20 Sep 2025",
      "status": "Pending",
      "response": ""
    },
    {
      "reqId": "REQ102",
      "user": "Priya Singh",
      "subject": "Payment not reflected",
      "date": "21 Sep 2025",
      "status": "In Progress",
      "response": "We are checking with the finance team."
    },
    {
      "reqId": "REQ103",
      "user": "Rahul Verma",
      "subject": "Unable to upload documents",
      "date": "22 Sep 2025",
      "status": "Resolved",
      "response": "Issue has been fixed. Please retry."
    },
  ];

  String searchQuery = "";

  void _updateStatus(int index, String newStatus) {
    setState(() {
      requests[index]["status"] = newStatus;
    });
  }

  void _respondToRequest(int index) {
    String reply = requests[index]["response"] ?? "";
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Respond to ${requests[index]['reqId']}"),
          content: TextField(
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: "Your Response",
              border: OutlineInputBorder(),
            ),
            controller: TextEditingController(text: reply),
            onChanged: (val) => reply = val,
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: const Text("Send"),
              onPressed: () {
                setState(() {
                  requests[index]["response"] = reply;
                  requests[index]["status"] = "In Progress";
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredRequests = requests
        .where((r) =>
            r["reqId"]!.toLowerCase().contains(searchQuery.toLowerCase()) ||
            r["user"]!.toLowerCase().contains(searchQuery.toLowerCase()) ||
            r["subject"]!.toLowerCase().contains(searchQuery.toLowerCase()) ||
            r["status"]!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Service Requests"),
      ),
      body: Column(
        children: [
          // 🔍 Search bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search by Request ID, User, Subject, or Status",
                prefixIcon: const Icon(Icons.search),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onChanged: (val) {
                setState(() {
                  searchQuery = val;
                });
              },
            ),
          ),

          // 📋 Requests Table
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
                columns: const [
                  DataColumn(label: Text("Request ID")),
                  DataColumn(label: Text("User")),
                  DataColumn(label: Text("Subject")),
                  DataColumn(label: Text("Date")),
                  DataColumn(label: Text("Status")),
                  DataColumn(label: Text("Response")),
                  DataColumn(label: Text("Actions")),
                ],
                rows: List.generate(filteredRequests.length, (index) {
                  final req = filteredRequests[index];
                  return DataRow(cells: [
                    DataCell(Text(req["reqId"]!)),
                    DataCell(Text(req["user"]!)),
                    DataCell(Text(req["subject"]!)),
                    DataCell(Text(req["date"]!)),
                    DataCell(Text(req["status"]!)),
                    DataCell(Text(
                      req["response"]!.isEmpty
                          ? "No response yet"
                          : req["response"]!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )),
                    DataCell(Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.reply, color: Colors.blue),
                          tooltip: "Respond",
                          onPressed: () => _respondToRequest(index),
                        ),
                        PopupMenuButton<String>(
                          onSelected: (value) {
                            _updateStatus(index, value);
                          },
                          itemBuilder: (context) => const [
                            PopupMenuItem(
                                value: "Pending", child: Text("Mark Pending")),
                            PopupMenuItem(
                                value: "In Progress",
                                child: Text("Mark In Progress")),
                            PopupMenuItem(
                                value: "Resolved",
                                child: Text("Mark Resolved")),
                          ],
                          child: const Icon(Icons.more_vert),
                        ),
                      ],
                    )),
                  ]);
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

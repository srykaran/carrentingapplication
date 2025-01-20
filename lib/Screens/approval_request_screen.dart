import 'package:flutter/material.dart';

class ApprovalRequestsScreen extends StatefulWidget {
  @override
  _ApprovalRequestsScreenState createState() => _ApprovalRequestsScreenState();
}

class _ApprovalRequestsScreenState extends State<ApprovalRequestsScreen> {
  // Dummy list of approval requests
  List<Map<String, String>> approvalRequests = [
    {
      'carName': 'Toyota Camry',
      'owner': 'john.doe@example.com',
      'status': 'Pending',
    },
    {
      'carName': 'Honda Accord',
      'owner': 'jane.smith@example.com',
      'status': 'Pending',
    },
    {
      'carName': 'Tesla Model 3',
      'owner': 'elon.musk@example.com',
      'status': 'Pending',
    },
  ];

  // Function to approve a car request
  void approveRequest(int index) {
    setState(() {
      approvalRequests[index]['status'] = 'Approved';
    });
  }

  // Function to reject a car request
  void rejectRequest(int index) {
    setState(() {
      approvalRequests[index]['status'] = 'Rejected';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Approval Requests'),
      ),
      body: approvalRequests.isEmpty
          ? Center(
        child: Text('No Approval Requests at the Moment!'),
      )
          : ListView.builder(
        itemCount: approvalRequests.length,
        itemBuilder: (context, index) {
          final request = approvalRequests[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Icon(Icons.car_rental, size: 40),
              title: Text(request['carName']!),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Owner: ${request['owner']}'),
                  Text('Status: ${request['status']}'),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.check, color: Colors.green),
                    onPressed: request['status'] == 'Pending'
                        ? () => approveRequest(index)
                        : null,
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.red),
                    onPressed: request['status'] == 'Pending'
                        ? () => rejectRequest(index)
                        : null,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

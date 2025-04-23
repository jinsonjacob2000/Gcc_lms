import 'package:flutter/material.dart';
import 'package:portfolio_lms/Models/profileModel/get_attendance.dart';
import 'package:provider/provider.dart';
import 'package:portfolio_lms/Viewmodel/student_provider/student_profile.dart';

class ApplyLeaveForm extends StatefulWidget {
  @override
  _ApplyLeaveFormState createState() => _ApplyLeaveFormState();
}

class _ApplyLeaveFormState extends State<ApplyLeaveForm> {
  DateTime? leaveDate;
  TextEditingController reasonController = TextEditingController();

  void _pickLeaveDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (picked != null) {
      setState(() {
        leaveDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 🗓️ Leave Date Picker
        InkWell(
          onTap: _pickLeaveDate,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.green),
                SizedBox(width: 10),
                Text(
                  leaveDate == null
                      ? "Select Leave Date"
                      : "${leaveDate!.day}/${leaveDate!.month}/${leaveDate!.year}",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 20),

        // 📝 Reason TextField
        TextFormField(
          controller: reasonController,
          maxLines: 3,
          decoration: InputDecoration(
            labelText: "Reason for Leave",
            border: OutlineInputBorder(),
          ),
        ),

        SizedBox(height: 20),

        // 📤 Submit Button
        ElevatedButton(
          onPressed: () {
            final profileProvider = Provider.of<StudentProfile>(
              context,
              listen: false,
            );

            if (leaveDate != null && reasonController.text.isNotEmpty) {
              profileProvider.sendLeaveREquestprovider(
                leaveDate!,
                reasonController.text,
              );
              // ✅ Handle leave submission here
              // print("Leave Date: $leaveDate");
              // print("Reason: ${reasonController.text}");

              Navigator.pop(context); // Close the dialog
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Please select a date and enter a reason"),
                ),
              );
            }
          },
          child: Text("Submit Leave"),
        ),
      ],
    );
  }
}

class LeaveHistoryScreen extends StatefulWidget {
  const LeaveHistoryScreen({super.key});

  @override
  State<LeaveHistoryScreen> createState() => _LeaveHistoryScreenState();
}

class _LeaveHistoryScreenState extends State<LeaveHistoryScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch leave history when the screen opens
    final provider = Provider.of<StudentProfile>(context, listen: false);
    provider.fetchLeaveHistory();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StudentProfile>(context);

    if (provider.isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Leave History')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (provider.leaveHistory.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Leave History')),
        body: const Center(child: Text("No leave history found.")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Leave History')),
      body: ListView.builder(
        itemCount: provider.leaveHistory.length,
        itemBuilder: (context, index) {
          final leave = provider.leaveHistory[index];
          return ListTile(
            leading: const Icon(Icons.date_range),
            title: Text(
              "Date: ${leave.leaveDate.toLocal().toString().split(' ')[0]}",
            ),
            subtitle: Text("Reason: ${leave.reason}"),
            trailing: Chip(
              label: Text(
                leave.status,
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor:
                  leave.status == "Pending"
                      ? Colors.orange
                      : leave.status == "Approved"
                      ? Colors.green
                      : Colors.red,
            ),
          );
        },
      ),
    );
  }
}

class ViewAttendanceWidget extends StatelessWidget {
  const ViewAttendanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StudentProfile>(context, listen: false);

    return FutureBuilder(
      future: provider.loadAttendance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show loading spinner while data loads
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Show error if something went wrong
          return Center(child: Text('Error loading attendance data'));
        } else {
          final attendanceList = provider.attendanceList;

          int presentCount = attendanceList
              .where((a) => a.status.toString().toLowerCase() == "status.present")
              .length;

          int absentCount = attendanceList
              .where((a) => a.status.toString().toLowerCase() == "status.absent")
              .length;

          int leaveCount = attendanceList
              .where((a) => a.status.toString().toLowerCase() == "status.leave")
              .length;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Total Present: $presentCount"),
              Text("Total Absent: $absentCount"),
              Text("Total Leave: $leaveCount"),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: attendanceList.length,
                  itemBuilder: (context, index) {
                    final item = attendanceList[index];
                    return ListTile(
                      leading: const Icon(Icons.calendar_today),
                      title: Text(
                        item.date.toLocal().toString().split(" ")[0],
                      ),
                      trailing: Chip(label: Text(item.status)),
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

class SendAttendanceWidget extends StatefulWidget {
  const SendAttendanceWidget({super.key});

  @override
  State<SendAttendanceWidget> createState() => _SendAttendanceWidgetState();
}

class _SendAttendanceWidgetState extends State<SendAttendanceWidget> {
  String selectedStatus = "present"; // This now persists properly

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StudentProfile>(context, listen: false);
    final today = DateTime.now();
    final todayFormatted =
        "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

    return FutureBuilder(
      future: provider.loadAttendance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading attendance'));
        } else {
          final attendanceList = provider.attendanceList;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Mark Attendance for Today: $todayFormatted",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              RadioListTile<String>(
                title: const Text("Present"),
                value: "present",
                groupValue: selectedStatus,
                onChanged: (value) {
                  setState(() {
                    selectedStatus = value!;
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text("Absent"),
                value: "absent",
                groupValue: selectedStatus,
                onChanged: (value) {
                  setState(() {
                    selectedStatus = value!;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      // Call your submit API with selectedStatus
                      await provider.submitTodayAttendance(status:selectedStatus );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Attendance marked as $selectedStatus")),
                      );
                    },
                    child: const Text("Submit Attendance"),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          );
        }
      },
    );
  }
}



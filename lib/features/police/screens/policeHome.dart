import 'package:flutter/material.dart';
import 'package:jailerecord/features/auth/services/auth_service.dart';
import 'package:jailerecord/features/police/screens/addcase.dart';
import 'package:jailerecord/features/police/screens/casedisplay.dart';
import 'package:jailerecord/features/police/services/policeservices.dart';

import '../../../models/case.dart';

class PoliceHome extends StatefulWidget {
  const PoliceHome({super.key});

  @override
  State<PoliceHome> createState() => _PoliceHomeState();
}

class _PoliceHomeState extends State<PoliceHome> {
  List<Case>? allCases = [];
  bool isLoading = true;

  getAllCases() async {
    try {
      final fetchedCases = await PoliceServices.getAllCases(context: context);
      setState(() {
        allCases = fetchedCases;
        print(allCases);
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    getAllCases();
    super.initState();
  }

  final Map<String, dynamic> _jsonData = {
    "msg": "Successful",
    "data": [
      {
        "documents": "gmeet",
        "Prisoners": {"name": "something", "status": true},
        "Court": {
          "id": 3,
          "name": "Karnataka High Court",
          "location": "Bangalore"
        },
        "Police": {"id": 1, "uid": "ok123", "name": "sampee", "badge": "seri"},
        "Lawyer": {
          "id": 1,
          "uid": "ramesh_naidu",
          "name": "Koushik",
          "contact": "ulalaulala",
          "email_id": "ninajjigandusuleghuttdulemunde"
        }
      },
      {
        "documents": "mallika.s",
        "Prisoners": {"name": "Suman Prasad", "status": true},
        "Court": {"id": 2, "name": "Bombay High Court", "location": "Mumbai"},
        "Police": {"id": 1, "uid": "ok123", "name": "sampee", "badge": "seri"},
        "Lawyer": {
          "id": 1,
          "uid": "ramesh_naidu",
          "name": "Koushik",
          "contact": "ulalaulala",
          "email_id": "ninajjigandusuleghuttdulemunde"
        }
      },
      {
        "documents": "mallika.s",
        "Prisoners": {"name": "Suman Prasad", "status": true},
        "Court": {"id": 2, "name": "Bombay High Court", "location": "Mumbai"},
        "Police": {"id": 1, "uid": "ok123", "name": "sampee", "badge": "seri"},
        "Lawyer": {
          "id": 1,
          "uid": "ramesh_naidu",
          "name": "Koushik",
          "contact": "ulalaulala",
          "email_id": "ninajjigandusuleghuttdulemunde"
        }
      },
      {
        "documents": "mallika.s",
        "Prisoners": {"name": "Suman Prasad", "status": true},
        "Court": {"id": 2, "name": "Bombay High Court", "location": "Mumbai"},
        "Police": {"id": 1, "uid": "ok123", "name": "sampee", "badge": "seri"},
        "Lawyer": {
          "id": 1,
          "uid": "ramesh_naidu",
          "name": "Koushik",
          "contact": "ulalaulala",
          "email_id": "ninajjigandusuleghuttdulemunde"
        }
      }
    ]
  };

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> cases =
        List<Map<String, dynamic>>.from(_jsonData['data']);

    return Scaffold(
      appBar: AppBar(
          title: const Text('Police - Cases',
              style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1))),
          backgroundColor: Colors.black,
          actions: [
            TextButton.icon(
              onPressed: () {
                AuthService.signOut(context: context);
              },
              label: Text(
                'Sign Out',
                style: TextStyle(color: Colors.white),
              ),
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
            )
          ]),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : allCases != null
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: allCases!.length,
                    itemBuilder: (context, index) {
                      var caseData = allCases![index];
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 1.0),
                          borderRadius: BorderRadius.circular(6.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text(
                            'Case ${caseData.caseId}:',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          subtitle:
                              Text('Prisoner name: ${caseData.prisoner.name}'),
                          trailing: const Icon(Icons.arrow_forward,
                              color: Colors.black),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CaseDetailsPage(caseData: caseData),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                )
              : Center(child: Text('No cases found')),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddForm()));
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.white,
    );
  }
}

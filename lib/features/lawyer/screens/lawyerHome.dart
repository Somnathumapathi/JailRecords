import 'package:flutter/material.dart';
import 'package:jailerecord/features/auth/services/auth_service.dart';
import 'package:jailerecord/features/lawyer/screens/casedisplay.dart';
import 'package:jailerecord/features/lawyer/screens/lawyerProfileScreen.dart';
import 'package:jailerecord/features/lawyer/screens/mycases.dart';
import 'package:jailerecord/models/case.dart';
import 'package:jailerecord/provider/laywerProvider.dart';
import 'package:provider/provider.dart';

import '../../police/services/policeservices.dart';

class LawyerHome extends StatefulWidget {
  const LawyerHome({super.key});

  @override
  State<LawyerHome> createState() => _LawyerHomeState();
}

class _LawyerHomeState extends State<LawyerHome> {
  List<Case>? allCases = [];
  bool isLoading = true;
  int _screenIdx = 1;

  getbody(double screenWidth, double screenHeight) {
    if (_screenIdx == 0) {
      return const LawyerProfileScreen();
    } else if (_screenIdx == 1) {
      return isLoading
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
              : Center(child: Text('No cases found'));
    } else if (_screenIdx == 2) {
      return MyCasesScreen();
    }
  }

  // getuser() async {
  //   AuthService.getUser(context: context);
  // }

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
    // AuthService.
    print(Provider.of<LawyerProvider>(context, listen: false).laywer.name);
    // getuser();
    getAllCases();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // List<Map<String, dynamic>> cases =
    //     List<Map<String, dynamic>>.from(_jsonData['data']);
    final _scWidth = MediaQuery.of(context).size.width;
    final _scHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Lawyer - Cases', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        actions: [
          TextButton.icon(
            onPressed: () {
              AuthService.signOut(context: context);
            },
            label: Text('Sign Out'),
            icon: Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: getbody(_scWidth, _scHeight),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cases),
              label: 'All cases',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cases_outlined),
              label: 'My cases',
            ),
          ],
          currentIndex: _screenIdx,
          selectedItemColor: Colors.amber[800],
          onTap: (value) {
            setState(() {
              _screenIdx = value;
            });
          }),
    );
  }
}

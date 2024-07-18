import 'package:flutter/material.dart';
import 'package:jailerecord/features/auth/services/auth_service.dart';
import 'package:jailerecord/features/lawyer/screens/casedisplay.dart';
import 'package:jailerecord/features/lawyer/services/lawyerSrevices.dart';
import 'package:jailerecord/models/case.dart';
import 'package:jailerecord/provider/laywerProvider.dart';
import 'package:provider/provider.dart';

import '../../police/services/policeservices.dart';

class MyCasesScreen extends StatefulWidget {
  const MyCasesScreen({super.key});

  @override
  State<MyCasesScreen> createState() => _MyCasesScreenState();
}

class _MyCasesScreenState extends State<MyCasesScreen> {
  List<Case>? myCases = [];
  bool isLoading = true;

  getMyCases() async {
    try {
      print('reached');
      final fetchedCases = await LawyerServices.getMyCases(
          context: context,
          lawyerId:
              Provider.of<LawyerProvider>(context, listen: false).laywer.id);
      setState(() {
        myCases = fetchedCases;
        print(myCases);
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
    getMyCases();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : myCases != null
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: myCases!.length,
                    itemBuilder: (context, index) {
                      var caseData = myCases![index];
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
      backgroundColor: Colors.white,
    );
  }
}

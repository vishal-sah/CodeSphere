import 'package:codesphere/widgets/hackathon_extensiontile.dart';
import 'package:flutter/material.dart';

class HackathonPageOrganiser extends StatelessWidget {
  const HackathonPageOrganiser({
    super.key,
    required this.teamsData,
  });
  final List<Map<String, dynamic>> teamsData;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // child: Column(
      //   children: teamsData
      //       .map(
      //         (e) => HackathonExpansionTile(
      //           teams: e,
      //         ),
      //       )
      //       .toList(),
      // ),
      child: ListView.builder(
        itemCount: teamsData.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return HackathonExpansionTile(
            teams: teamsData[index],
            index: index + 1,
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

class HackathonExpansionTile extends StatefulWidget {
  const HackathonExpansionTile({
    super.key,
    required this.teams,
    required this.index,
  });
  final Map<String, dynamic> teams;
  final int index;

  @override
  State<HackathonExpansionTile> createState() => _HackathonExpansionTileState();
}

class _HackathonExpansionTileState extends State<HackathonExpansionTile> {
  @override
  Widget build(BuildContext context) {
    Color color;
    Color bgcolor;
    bool isAccepted = false;
    bool isPending = false;
    if (widget.teams['status'].toString().toLowerCase() == 'accepted') {
      color = Colors.green;
      bgcolor = Colors.green.shade100;
      isAccepted = true;
    } else if (widget.teams['status'].toString().toLowerCase() == 'rejected') {
      color = Colors.red;
      bgcolor = Colors.red.shade100;
    } else {
      color = Colors.black;
      bgcolor = Colors.grey.shade300;
      isPending = true;
    }

    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200],
      ),
      child: ExpansionTile(
        leading: Text(
          widget.index.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        title: Row(
          children: [
            SizedBox(
              width: size.width * 0.25,
              child: Text(
                widget.teams['name'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                isAccepted == true
                    ? Text(
                        widget.teams['score'].toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )
                    : const Text(''),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: bgcolor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      widget.teams['status'].toString().toUpperCase(),
                      style: TextStyle(color: color),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[300],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      ...widget.teams['members'].map((e) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // CircleAvatar(
                            //   radius: 20,
                            //   backgroundImage: NetworkImage(e[0]),
                            // ),
                            const CircleAvatar(
                              radius: 20,
                              child: Icon(Icons.person),
                            ),
                            const SizedBox(width: 8),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                e[1],
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
                const Spacer(),
                Column(
                  children: [
                    const SizedBox(height: 8),
                    if (isAccepted)
                      Column(
                        children: [
                          MaterialButton(
                            padding: const EdgeInsets.all(20),
                            color: Colors.blue.shade100,
                            hoverColor: Colors.blue,
                            onPressed: () {},
                            child: const Text('View Submission'),
                          ),
                          const SizedBox(height: 8),
                          // a button to give score to the team
                          MaterialButton(
                            padding: const EdgeInsets.all(20),
                            color: Colors.blue.shade100,
                            hoverColor: Colors.blue,
                            onPressed: () {
                              // add a dialog box to give score
                            },
                            child: const Text('Give Score'),
                          ),
                        ],
                      ),
                    if (isPending)
                      Column(
                        children: [
                          MaterialButton(
                            padding: const EdgeInsets.all(20),
                            color: Colors.blue.shade100,
                            hoverColor: Colors.blue,
                            onPressed: () {},
                            child: const Text('Accept Team'),
                          ),
                          const SizedBox(height: 8),
                          MaterialButton(
                            padding: const EdgeInsets.all(20),
                            color: Colors.red.shade100,
                            hoverColor: Colors.red,
                            onPressed: () {},
                            child: const Text('Reject Team'),
                          ),
                        ],
                      ),
                    const SizedBox(height: 8),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

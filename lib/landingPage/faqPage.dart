import 'package:flutter/material.dart';

class FAQsPage extends StatelessWidget {
  const FAQsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text('User FAQs:'),
          const SizedBox(height: 30,),
          ...userFaqs.map((faq) {
            return FAQTile(question: faq[0], answer: faq[1],);
          }),
          const SizedBox(height: 60,),
          const Text('Organizer FAQs:'),
          const SizedBox(height: 30,),
          ...organizerFaqs.map((faq) {
            return FAQTile(question: faq[0], answer: faq[1],);
          }),
        ],
      ),
    );
  }
}

class FAQTile extends StatelessWidget {
  final String question;
  final String answer;

  const FAQTile({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200],
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              answer,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}



List<List<String>> userFaqs = [
  [
    "Why my team members are unable to initiate submissions on CodeSphere?",
    "If you are participating as a team, then the submissions can only be made by the team admin."
  ],
  [
    "Can I update a project after I have submitted it for judging?",
    "You can update your project from https://codesphere.co/projects. Any updates made will show up in the project history."
  ],
  [
    "My friend cannot join my team. What could be the possible reason?",
    "General reasons:\n- The Team code entered is invalid. Check the code and re-enter.\n- Your friend is already a part of some team. They can leave the existing team and "
        "join the new team!\nBefore Submitting the Team for Review:\n- Your friend has submitted the application individually. They can withdraw their application and join "
        "the team.\nAfter Submitting the Team for Review:\n- Your friend has submitted the application individually. You cannot edit teammates while your application is under"
        " review. You can edit your team after you've been accepted to the hackathon.\nNote: Only accepted hackers will be able to join your accepted team."
  ],
  [
    "Can I apply individually in a strictly Team Hackathon?",
    "Yes, you can apply to such hackathons individually and even can get accepted individually, but in order to submit the project, it is compulsory to join/create a team."
  ],
  [
    "Why I am not able to submit my profile for review?",
    "To submit a profile for review, it is important and compulsory to complete the application 100%. Just complete the required questions, and then you will be good to go!"
  ],
  [
    "Where can I see submissions made by other hackers?",
    "The submissions are always visible on the Submissions tab under any particular hackathon. Click on the specific submission card to explore the project!"
  ],
  [
    "Where can I see the winners?",
    "After the hackathon ends, the organizing team can highlight the winners under the Submissions tab. The winners of the hackathon or any other category will get a special badge on their project card!"
  ],
  [
    "How can I submit feedback to organizers?",
    "When the hackathon ends, check your dashboard and there you will find a custom card to share your feedback anonymously!"
  ],
  [
    "Can I delete a project uploaded on CodeSphere?",
    "You cannot delete a project submitted to a hackathon. If you wish to delete a side-project (projects uploaded on https://codesphere.co/projects), you can reach out to us at help@codesphere.co while stating the reason for doing so."
  ],
  [
    "What if someone has withdrawn by mistake and wants to join the hackathon again?",
    "In such cases, we recommend dropping a mail at hello@codesphere.co and we will be able to help you out there!"
  ],
  [
    "Can we update a team after submitting it for review?",
    "Yes, you are allowed to update the team before making the submission to the hackathon. Once you make the submission, you won't be able to make any further changes."
  ],
  [
    "What is the deadline for joining/creating a team at a hackathon?",
    "You can join/create a team before the submission deadline. Upon making the submission, your team will be finalized, and you won't be able to make any changes to it."
  ],
  [
    "How do I delete my CodeSphere Account?",
    "You can delete your account from the Settings Tab while logged in to your CodeSphere account. Refer to the Settings Tab for more details."
  ],
];

List<List<String>> organizerFaqs = [
  [
    "When can we access the CodeSphere portal for registrations?",
    "The Organizer Dashboard is visible as soon as your hackathon is verified by CodeSphere. If you have submitted your hackathon for review, reach out to us at community@codesphere.co to learn the next steps."
  ],
  [
    "Some participants missed their RSVP deadline and their status shows 'Withdrawn'. What should I do?",
    "You can extend the RSVP deadline in the Admin Tab and send out an announcement to the accepted hackers to RSVP if they haven't yet.\n\nYou can also choose to RSVP them yourself from the Admin Tab. Start searching for the team or the hacker to reveal the Status section, and click on the toggle to RSVP them."
  ],
  [
    "Can we extend the registration deadline after it starts?",
    "You can extend the application deadline from the Admin Tab in your Organizer Dashboard."
  ],
  [
    "Can we extend the project submission deadline?",
    "You can extend the project submission deadline from the Admin Tab in your Organizer Dashboard.\n\nBut make sure to extend it before the initial submission deadline passes!"
  ],
  [
    "I cannot add teammates in my organizer dashboard.",
    "Only the creator of the hackathon has permission to add teammates. The other members, even with all permissions, cannot add or remove teammates."
  ],
  [
    "Can I change the fields present in the Application Form?",
    "If you haven't submitted your hackathon for review, you can make the changes by updating your hackathon."
  ],
  [
    "Where can I view the submissions made to my Hackathon?",
    "You can find the submissions on your hackathon's microsite."
  ],
  [
    "How do I add Problem Statements to the Hackathon?",
    "You can add it as a track to your hackathon via the Prizes Tab. This will enable the hacker to select the track if their hack is built around the problem statement.\n\nRefer to the documentation for the same."
  ],
  [
    "While setting up my hackathon, I had specified the minimum number of team members. But I still see people submitting applications individually.",
    "Hackers can submit their applications individually, and you can accept them as well. Although, before making a submission, they will have to join/create a team with the minimum number of team members mentioned."
  ]
];

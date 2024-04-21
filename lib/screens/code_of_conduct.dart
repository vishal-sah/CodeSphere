import 'package:flutter/material.dart';

class CodeOfConductPage extends StatelessWidget {
  const CodeOfConductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Code of Conduct'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width < 720 ? 20 : MediaQuery.of(context).size.width*0.2),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: 'Applicability'),
            Text(
              'This policy shall be applicable on all spaces related to Devfolio, including the following, as well as their online counterparts (if any):',
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                '- hackathons\n- talks, presentations, or demos\n- workshops\n- parties and social events\n- social media channels, etc.',
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'This Code of Conduct also applies equally to all sponsors and partners of hackathons, and to all projects that are made at the hackathon.',
            ),
            SizedBox(height: 24.0),
            SectionTitle(title: 'No plagiarism or re-using of past work'),
            Text(
              'We encourage you to submit projects only prepared in the duration of the hackathon. However, if you decide to submit projects consisting '
                  'of re-used code, or re-submit a project that you have already submitted previously to any other hackathon, you are to disclose such '
                  'previous use and its extent with the submission. If upon inspection, it is found that the project has re-used code that was not disclosed'
                  ' with the submission, the organizer may ask the participant to point out similarities and differences between the old and new work, and/or '
                  'disqualify the submission from winning awards automatically.',
            ),
            SizedBox(height: 24.0),
            SectionTitle(title: 'No discrimination'),
            Text(
              'Hackathons hosted on Devfolio are dedicated to providing a safe and comfortable environment and harassment-free experience for everyone. No discrimination, on the basis of the following, shall be tolerated:',
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                '- gender\n- gender identity and expression\n- age\n- sexual orientation\n- disability\n- physical appearance\n- body size\n- race\n- ethnicity\n- nationality\n- religion\n- political views\n- previous hackathon attendance or lack of\n- computing experience or lack of\n- chosen programming language or tech stack',
              ),
            ),
            SizedBox(height: 24.0),
            SectionTitle(title: 'No harassment'),
            Text(
              'We do not tolerate harassment of hackathon participants in any form, including:',
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                '- offensive discriminatory verbal comments\n- public display of sexual material\n- deliberate intimidation\n- stalking\n- wilful disruption\n- inappropriate physical contact\n- unwelcome sexual advances\n- taking of photographs and audio/video recordings without consent',
              ),
            ),
            SizedBox(height: 24.0),
            SectionTitle(title: 'No recording without consent'),
            Text(
              'While photography and videography are encouraged, other participants must be given a reasonable chance to opt out from '
                  'being photographed. If they object to the taking of their photograph, comply with their request. If they express their '
                  'disapproval after the photo or video has been captured, please delete it from your records, and in case it has been '
                  'shared online, take reasonable steps to retract it from social media as well. It is inappropriate to take photographs'
                  ' in contexts where people have a reasonable expectation of privacy (in bathrooms or where participants are sleeping).',
            ),
            SizedBox(height: 24.0),
            SectionTitle(title: 'Creation of a safe space'),
            Text(
              'No sponsors, partners, or participants shall use sexualised images, activities, or other material at the hackathons for any non-permitted purpose. The use of sexualised clothing/uniforms/costumes, and anything that creates a sexualised environment is prohibited.',
            ),
            SizedBox(height: 24.0),
            SectionTitle(title: 'Intellectual Property'),
            Text(
              'You will own any developments made by you, and all rights, titles and interests in those developments, including the '
                  'intellectual property rights therein, shall belong to you. By posting your submission on Devfolio, you are granting '
                  'Devfolio a non-exclusive, worldwide, royalty-free license to use, distribute, display and reproduce your submission '
                  'only to the extent required by us to provide services on the Devfolio platform. We will never try to steal your creations '
                  'or use them exploitatively.',
            ),
            SizedBox(height: 24.0),
            SectionTitle(title: 'Always report'),
            Text(
              'If you notice any violation of this Code of Conduct or find otherwise suspicious behavior or have any concerns, please contact a member of the hackathon organizing committee immediately.',
            ),
            Text(
              'We will be happy to help participants contact local security or local law enforcement, or otherwise assist those experiencing harassment to feel safe for the duration of the hackathon. We value your attendance.',
            ),
            SizedBox(height: 24.0),
            SectionTitle(title: 'Consequences of violations'),
            Text(
              'In case any participant violates this Code of Conduct, the organizer may, at their own discretion:',
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                '- expel them from the hackathon with no refund (if applicable)\n- block their access to Devfolio resources including the website\n- report their behaviour to local law enforcement',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple
            ),
          ),
        ),
        const Divider(height: 1,),
        const SizedBox(height: 7,),
      ],
    );
  }
}

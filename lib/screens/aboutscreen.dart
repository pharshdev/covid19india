import 'package:covid19india/widgets/screen.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Screen(
        onWillPop: () async {
          Navigator.pop(context);
        },
        body: Scrollbar(
            child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                shrinkWrap: true,
                itemCount: _faqs.length,
                itemBuilder: (ctx, index) => _faqWidget(
                    question: _faqs[index].question,
                    answer: _faqs[index].answer,
                    context: context))));
  }

  Widget _faqWidget(
      {@required String question, @required String answer, context}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(question, style: Theme.of(context).textTheme.headline6),
      SizedBox(height: 8.0),
      Text(answer,
          style: Theme.of(context)
              .textTheme
              .headline6
              .apply(color: Colors.blueAccent)),
      SizedBox(height: 24.0)
    ]);
  }

  final List<Faq> _faqs = [
    Faq(question: 'Are you official?', answer: 'No'),
    Faq(
        question:
            'What are your sources? How is the data gathered for this project?',
        answer:
            'We are using state bulletins and official handles to update our numbers. The data is validated by a group of volunteers and published into a Google sheet and an API. API is available for all at api.covid19india.org. We would love it if you can use this data in the fight against this virus. The source list is here.'),
    Faq(
        question:
            'Why does covid19india.org have more positive count than MoH?',
        answer:
            'MoHFW updates the data at a scheduled time. However, we update them based on state press bulletins, official (CM, Health M) handles, PBI, Press Trust of India, ANI reports. These are generally more recent.'),
    Faq(
        question: 'Where can I find the data for this?',
        answer:
            'All the data is available through an API for further analysis and development here : api.covid19india.org'),
    Faq(
        question: 'Who are you?',
        answer:
            '''We are a group of dedicated volunteers who curate and verify the data coming from several sources. We extract the details, like a patient's relationship with other patients to identify local and community transmissions, travel history and status. We never collect or expose any personally identifiable data regarding the patients.'''),
    Faq(
        question:
            '''Why are you guys putting in time and resources to do this while not gaining a single penny from it?''',
        answer:
            '''Because it affects all of us. Today it's someone else who is getting infected; tomorrow it could be us. We need to prevent the spread of this virus. We need to document the data so that people with knowledge can use this data to make informed decisions.'''),
  ];
}

class Faq {
  final String question;
  final String answer;

  Faq({@required this.question, @required this.answer});
}

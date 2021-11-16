import 'package:flutter/material.dart';
import 'package:transcribe/phrase/controller/phrase_model.dart';
import 'package:transcribe/phrase/phrase_card.dart';
import 'package:transcribe/search_phrase/controller/search_phrase_list_connector.dart';
import 'package:transcribe/theme/app_icon.dart';

class SearchPhrase extends StatelessWidget {
  final PhraseModel? phrase;
  final IconData icon;
  final String label;
  final String messageTooltip;
  final bool required;
  final bool? isFieldValid;
  const SearchPhrase({
    Key? key,
    required this.label,
    required this.phrase,
    this.icon = AppIconData.people,
    this.required = false,
    this.messageTooltip = '',
    required this.isFieldValid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.topCenter,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              const SearchPhraseListConnector());
                    },
                    icon: const Icon(
                      AppIconData.search,
                      color: Colors.white,
                    ),
                    label: Text(
                      label,
                      softWrap: true,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  required
                      ? const Text(
                          ' *',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        )
                      : Container(),
                ]),
            color: Colors.green.shade900,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(
                  icon,
                  color: Colors.blue,
                ),
              ),
              Container(
                width: 1,
                height: 48,
                color: Colors.blue,
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                // flex: 15,
                child: Column(
                  children: [
                    phrase != null
                        ? PhraseCard(
                            phrase: phrase!,
                          )
                        : Container(),
                    isFieldValid ?? true
                        ? Container()
                        : const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'This field cannot be empty.',
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            ),
                          )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class SelectLocationSheet extends StatelessWidget {
  const SelectLocationSheet({super.key, required this.placemarks});

  final List<Placemark> placemarks;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      maxChildSize: .9,
      minChildSize: .5,
      initialChildSize: .5,
      builder: (context, controller) {
        return ListView(
          controller: controller,
          padding: EdgeInsets.all(10),
          children: [
            SizedBox(height: 10),
            TextViewWidget(
              text: 'Please tap one location to select',
              textSize: 16,
            ),
            SizedBox(height: 40),
            ListView.separated(
              shrinkWrap: true,
              itemCount: placemarks.length,
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemBuilder: (context, index) {
                var e = placemarks[index];

                var data = e.toJson()
                  ..removeWhere((key, value) => '$value'.isEmpty);

                return GestureDetector(
                  onTap: () => context.pop(e),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: colorGreyLight),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: data.entries.map((e) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextViewWidget(text: e.key.capitalize()),
                            SizedBox(width: 20),
                            Expanded(
                              child: TextViewWidget(
                                maxLines: 1,
                                text: '${e.value}',
                                textAlign: TextAlign.end,
                                textOverflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

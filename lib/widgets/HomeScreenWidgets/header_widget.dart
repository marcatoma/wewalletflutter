import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mewallet/models/models.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
    required this.user,
    required this.size,
  }) : super(key: key);

  final Size size;
  final Usuario user;

  @override
  Widget build(BuildContext context) {
    final fecha = DateFormat('hh:mm a').format(DateTime.now());
    return SizedBox(
      width: double.infinity,
      height: size.height > size.width ? size.height * .15 : size.height * .20,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${fecha.contains('AM') ? 'Buenos Dias' : 'Buenas Tardes'},',
                    style:
                        const TextStyle(fontSize: 18, color: Colors.blueGrey),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    user.nombre,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              Transform(
                transform: Matrix4.rotationZ(50),
                alignment: Alignment.center,
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications, size: 35)),
              ),
              const SizedBox(width: 10),
              const CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://cdn-icons-png.flaticon.com/512/147/147142.png'),
                radius: 25,
              )
            ],
          ),
        ),
      ),
    );
  }
}

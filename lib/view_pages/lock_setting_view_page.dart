import 'package:flutter/material.dart';
import 'package:jny_self_services_library/controllers/lock_setting_page_controller.dart';

class LockSettingViewPage extends StatelessWidget {
  final LockSettingPageController controller;
  
  const LockSettingViewPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.widget.updatePIN != null && controller.widget.updatePIN == true ? 'Change Lock PIN' : 'Lock Page',
        ),
      ),
      body: controller.widget.updatePIN != null && controller.widget.updatePIN == true ?
      controller.showOldPIN == true ?
      Stack(
        children: [
          Opacity(
            opacity: 0.0,
            child: IgnorePointer(
              child: TextField(
                controller: controller.oldPinController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Enter The Current PIN Codes',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: controller.oldPinController.text.isNotEmpty ? Theme.of(context).colorScheme.primary : Colors.black54,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: controller.oldPinController.text.length > 1 ? Theme.of(context).colorScheme.primary : Colors.black54,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: controller.oldPinController.text.length > 2 ? Theme.of(context).colorScheme.primary : Colors.black54,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: controller.oldPinController.text.length > 3 ? Theme.of(context).colorScheme.primary : Colors.black54,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: controller.oldPinController.text.length > 4 ? Theme.of(context).colorScheme.primary : Colors.black54,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: controller.oldPinController.text.length > 5 ? Theme.of(context).colorScheme.primary : Colors.black54,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => controller.inputOldPIN(1),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Text(
                          '1',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => controller.inputOldPIN(2),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Text(
                          '2',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => controller.inputOldPIN(3),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Text(
                          '3',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => controller.inputOldPIN(4),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Text(
                          '4',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => controller.inputOldPIN(5),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Text(
                          '5',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => controller.inputOldPIN(6),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Text(
                          '6',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => controller.inputOldPIN(7),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Text(
                          '7',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => controller.inputOldPIN(8),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Text(
                          '8',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => controller.inputOldPIN(9),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Text(
                          '9',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => controller.inputOldPIN(0),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Text(
                          '0',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: InkWell(
                      onTap: () => controller.eraseOldPIN(),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Icon(
                          Icons.backspace_sharp,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ) :
      controller.showNewPIN == true ?
      Stack(
        children: [
          Opacity(
            opacity: 0.0,
            child: IgnorePointer(
              child: TextField(
                controller: controller.newPinController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Enter The New PIN Codes',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: controller.newPinController.text.isNotEmpty ? Theme.of(context).colorScheme.primary : Colors.black54,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: controller.newPinController.text.length > 1 ? Theme.of(context).colorScheme.primary : Colors.black54,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: controller.newPinController.text.length > 2 ? Theme.of(context).colorScheme.primary : Colors.black54,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: controller.newPinController.text.length > 3 ? Theme.of(context).colorScheme.primary : Colors.black54,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: controller.newPinController.text.length > 4 ? Theme.of(context).colorScheme.primary : Colors.black54,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: controller.newPinController.text.length > 5 ? Theme.of(context).colorScheme.primary : Colors.black54,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => controller.inputNewPIN(1),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Text(
                          '1',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => controller.inputNewPIN(2),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Text(
                          '2',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => controller.inputNewPIN(3),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Text(
                          '3',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => controller.inputNewPIN(4),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Text(
                          '4',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => controller.inputNewPIN(5),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Text(
                          '5',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => controller.inputNewPIN(6),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Text(
                          '6',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => controller.inputNewPIN(7),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Text(
                          '7',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => controller.inputNewPIN(8),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Text(
                          '8',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => controller.inputNewPIN(9),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Text(
                          '9',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => controller.inputNewPIN(0),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Text(
                          '0',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: InkWell(
                      onTap: () => controller.eraseNewPIN(),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Icon(
                          Icons.backspace_sharp,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ) :
      Stack(
        children: [
          Opacity(
            opacity: 0.0,
            child: IgnorePointer(
              child: TextField(
                controller: controller.confPinController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Confirming The New PIN Codes',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: controller.confPinController.text.isNotEmpty ? Theme.of(context).colorScheme.primary : Colors.black54,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: controller.confPinController.text.length > 1 ? Theme.of(context).colorScheme.primary : Colors.black54,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: controller.confPinController.text.length > 2 ? Theme.of(context).colorScheme.primary : Colors.black54,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: controller.confPinController.text.length > 3 ? Theme.of(context).colorScheme.primary : Colors.black54,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: controller.confPinController.text.length > 4 ? Theme.of(context).colorScheme.primary : Colors.black54,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: controller.confPinController.text.length > 5 ? Theme.of(context).colorScheme.primary : Colors.black54,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => controller.inputConfPIN(1),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Text(
                          '1',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => controller.inputConfPIN(2),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Text(
                          '2',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => controller.inputConfPIN(3),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Text(
                          '3',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => controller.inputConfPIN(4),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Text(
                          '4',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => controller.inputConfPIN(5),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Text(
                          '5',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => controller.inputConfPIN(6),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Text(
                          '6',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => controller.inputConfPIN(7),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Text(
                          '7',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => controller.inputConfPIN(8),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Text(
                          '8',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => controller.inputConfPIN(9),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Text(
                          '9',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => controller.inputConfPIN(0),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Text(
                          '0',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: InkWell(
                      onTap: () => controller.eraseConfPIN(),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Icon(
                          Icons.backspace_sharp,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ) :
      Stack(
        children: [
          Opacity(
            opacity: 0.0,
            child: IgnorePointer(
              child: TextField(
                controller: controller.pinController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Enter The PIN Codes',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: controller.pinController.text.isNotEmpty ? Theme.of(context).colorScheme.primary : Colors.black54,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: controller.pinController.text.length > 1 ? Theme.of(context).colorScheme.primary : Colors.black54,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: controller.pinController.text.length > 2 ? Theme.of(context).colorScheme.primary : Colors.black54,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: controller.pinController.text.length > 3 ? Theme.of(context).colorScheme.primary : Colors.black54,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: controller.pinController.text.length > 4 ? Theme.of(context).colorScheme.primary : Colors.black54,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: controller.pinController.text.length > 5 ? Theme.of(context).colorScheme.primary : Colors.black54,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => controller.inputPIN(1),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Text(
                          '1',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => controller.inputPIN(2),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Text(
                          '2',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => controller.inputPIN(3),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Text(
                          '3',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => controller.inputPIN(4),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Text(
                          '4',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => controller.inputPIN(5),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Text(
                          '5',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => controller.inputPIN(6),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Text(
                          '6',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => controller.inputPIN(7),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Text(
                          '7',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => controller.inputPIN(8),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Text(
                          '8',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => controller.inputPIN(9),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Text(
                          '9',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => controller.inputPIN(0),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Text(
                          '0',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: InkWell(
                      onTap: () => controller.erasePIN(),
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Icon(
                          Icons.backspace_sharp,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
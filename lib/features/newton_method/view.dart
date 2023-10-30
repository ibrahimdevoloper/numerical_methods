import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';


import 'controller.dart';

class NewtonMethodPage extends StatelessWidget {
  final controller = Get.put(NewtonMethodController());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Newton-Raphson Method'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: GetBuilder<NewtonMethodController>(
              init: controller,
              builder: (controller) {
                return Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('Function Expression:'),
                      const SizedBox(height: 8,),
                      TextFormField(
                        onChanged: (value) {
                          controller.function = value;
                        },
                        decoration: const InputDecoration(
                            hintText: 'ex: 1/(2*x)',
                            suffixIcon: SizedBox(width: 16, child: Center(
                                child: Text("=0")))
                        ),
                        validator: (value) {
                          if (value?.isEmpty != false) {
                            return "The Field is empty";
                          }
                          final validFunctionPattern = RegExp(
                              r'^[xX(,)+\-*\/0-9. \^sin|cos|tan|sqrt|exp|log|ln|abs|ceil|floor|round|trunc|toDegrees|toRadians|]*$',
                              caseSensitive: false);
                          var matcher =
                          validFunctionPattern.hasMatch((value ?? ""));
                          return !matcher
                              ? "Expression is empty or incorrect"
                              : null;
                        },
                      ),
                      const SizedBox(height: 16,),
                      Text(
                          'Number of Iterations:${controller
                              .numberOfIterations}'),
                      const SizedBox(height: 8,),
                      Slider(
                        value: controller.numberOfIterations.toDouble(),
                        min: 100,
                        max: 100000,
                        onChanged: (value) {
                          controller.numberOfIterations = value.toInt();
                        },
                      ),
                      const SizedBox(height: 16,),
                      Text('Error: ${controller.error}'),
                      const SizedBox(height: 8,),
                      Slider(
                        value: controller.error,
                        min: 0.000001,
                        max: 0.1,
                        onChanged: (value) {
                          controller.error = value;
                        },
                      ),
                      const SizedBox(height: 16,),
                      const Text('Convergance Range'),
                      const SizedBox(height: 8,),
                      if(ResponsiveBreakpoints
                          .of(context)
                          .isDesktop)
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Range start, ex: 1.4,-5.0,10',
                                ),
                                keyboardType: const TextInputType
                                    .numberWithOptions(
                                  decimal: true,
                                  signed: true,
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r"[0-9\-\+\.]"))
                                ],
                                onChanged: (value) {
                                  var string = value ?? "";
                                  controller.rangeStart = double.parse(string);
                                },
                                validator: (value) {
                                  var string = value ?? "";
                                  var doubleValue = double.tryParse(string);
                                  if (value?.isEmpty != false) {
                                    return "The Field is empty";
                                  } else if (doubleValue == null) {
                                    return "value is not correct";
                                  } else if ((controller.rangeStart) >
                                      controller.rangeEnd) {
                                    return "Range End must be greater than range start at least by one";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                              width: 8,
                            ),
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Range end, ex: 1.4,-5.0,10',
                                ),
                                keyboardType: const TextInputType
                                    .numberWithOptions(
                                  decimal: true,
                                  signed: true,
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r"[0-9\-\+\.]"))
                                ],
                                onChanged: (value) {
                                  var string = value ?? "";
                                  controller.rangeEnd = double.parse(string);
                                },
                                validator: (value) {
                                  var string = value ?? "";
                                  var doubleValue = double.tryParse(string);
                                  if (value?.isEmpty != false) {
                                    return "The Field is empty";
                                  } else if (doubleValue == null) {
                                    return "value is not correct";
                                  } else if ((controller.rangeStart) >
                                      controller.rangeEnd) {
                                    return "Range End must be greater than range start at least by one";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            )
                          ],
                        ), if(ResponsiveBreakpoints
                          .of(context)
                          .isMobile)
                        Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Range start, ex: 1.4,-5.0,10',
                              ),
                              keyboardType: const TextInputType
                                  .numberWithOptions(
                                decimal: true,
                                signed: true,
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r"[0-9\-\+\.]"))
                              ],
                              onChanged: (value) {
                                var string = value ?? "";
                                controller.rangeStart = double.parse(string);
                              },
                              validator: (value) {
                                var string = value ?? "";
                                var doubleValue = double.tryParse(string);
                                if (value?.isEmpty != false) {
                                  return "The Field is empty";
                                } else if (doubleValue == null) {
                                  return "value is not correct";
                                } else if ((controller.rangeStart) >
                                    controller.rangeEnd) {
                                  return "Range End must be greater than range start at least by one";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 8,
                              width: 8,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Range end, ex: 1.4,-5.0,10',
                              ),
                              keyboardType: const TextInputType
                                  .numberWithOptions(
                                decimal: true,
                                signed: true,
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r"[0-9\-\+\.]"))
                              ],
                              onChanged: (value) {
                                var string = value ?? "";
                                controller.rangeEnd = double.parse(string);
                              },
                              validator: (value) {
                                var string = value ?? "";
                                var doubleValue = double.tryParse(string);
                                if (value?.isEmpty != false) {
                                  return "The Field is empty";
                                } else if (doubleValue == null) {
                                  return "value is not correct";
                                } else if ((controller.rangeStart) >
                                    controller.rangeEnd) {
                                  return "Range End must be greater than range start at least by one";
                                } else {
                                  return null;
                                }
                              },
                            )
                          ],
                        ),
                      const SizedBox(height: 16,),
                      GetBuilder<NewtonMethodController>(
                          init:controller,
                          builder: (controller) {
                        if(controller.isLoading) {
                          return const SizedBox(
                              height: 100,
                              child: Center(child: CircularProgressIndicator()));
                        }else {
                          return ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() == true) {
                              controller.startNewtonMethod();
                            }
                            // values.clear();
                            // startNewtonMethod(numberOfIterations, initialValue, error);
                          },
                          child: const Text('Start Newton-Raphson Method'),
                        );
                        }
                      }),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}

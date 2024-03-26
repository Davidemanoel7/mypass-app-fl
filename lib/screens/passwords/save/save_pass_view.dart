import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mypass/screens/passwords/save/save_pass_control.dart';
import 'package:mypass/utils/themes.dart';

class SavePassView extends StatelessWidget {
  SavePassView({super.key});

  TextEditingController descriptionTextCtrl = TextEditingController();
  TextEditingController urlTextCtrl = TextEditingController();

  final SavePassControll savePassControll = Get.put(SavePassControll());

  @override
  Widget build(BuildContext context) {
    String password = Get.arguments['pass'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,  
        elevation: 0,
        title: Text(
          'Nova senha',
          style: MyPassFonts.style.kLabelMedium(context,
            color: MyPassColors.black1B,
            fontWeight: FontWeight.w700
          ),
        ),
        centerTitle: true,
    ),
    body: CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Adicione uma descrição e um link, assim fica mais fácil reconhecer esta senha...',
                    style: MyPassFonts.style.kLabelMedium(context,
                      color: MyPassColors.blueLight,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                    padding: const EdgeInsets.symmetric( horizontal: 8),
                    alignment: Alignment.center,
                    height: 56,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(
                        width: 1,
                        color: MyPassColors.greyBD,
                      )
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            password,
                            style: MyPassFonts.style.kLabelMedium(context,
                              color: MyPassColors.blueLight
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            await Clipboard.setData( ClipboardData( text: password )).then((_) => 
                              Get.snackbar(
                                "",
                                "",
                                titleText: Text(
                                  'Copiado',
                                  style: MyPassFonts.style.kLabelLarge(context,
                                    fontWeight: FontWeight.bold,
                                    color: MyPassColors.purpleLight,
                                  ),
                                ),
                                messageText: Text(
                                  'Senha copiada para a área de transferência',
                                  style: MyPassFonts.style.kLabelSmall(context,
                                    fontWeight: FontWeight.w400,
                                    color: MyPassColors.black1B
                                  ),
                                ),
                                colorText: MyPassColors.black1B,
                                leftBarIndicatorColor: MyPassColors.purpleLight,
                                animationDuration: const Duration( seconds: 1 ),
                                backgroundColor: Colors.white,
                                snackPosition: SnackPosition.TOP,
                                borderWidth: 2,
                                borderRadius: 16,
                                borderColor: MyPassColors.whiteF0,
                                isDismissible: true,
                                dismissDirection: DismissDirection.horizontal,
                                duration: const Duration( seconds: 4 ),
                                forwardAnimationCurve: Curves.easeInOutQuad,
                              )
                            );
                          },
                          icon: const Icon(
                            Icons.copy,
                            color: MyPassColors.greyBD,
                          )
                        )
                      ],
                    ),
                  )
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: TextFormField(
                      controller: descriptionTextCtrl,
                      decoration: InputDecoration(
                        labelText: 'Descrição',
                        alignLabelWithHint: true,
                        labelStyle: MyPassFonts.style.kLabelSmall( context,
                          color: MyPassColors.greyDarker
                        ),
                        hintText: 'Exemplo: Facebook',
                        hintStyle: MyPassFonts.style.kLabelSmall(
                          context,
                          color: const Color.fromARGB(73, 0, 0, 0)
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: MyPassColors.greyBD,
                            strokeAlign: BorderSide.strokeAlignCenter,
                          ),
                          borderRadius: BorderRadius.circular(16.0)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: MyPassColors.purpleLight,
                            width: 1.0
                          ),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      validator: (value) {
                        return value!.isEmpty ?
                          'Preenchimento obrigatório'
                          :
                          null;
                      },
                      onChanged: (value) => savePassControll.description(value),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: TextFormField(
                      controller: urlTextCtrl,
                      decoration: InputDecoration(
                        labelText: 'Link',
                        alignLabelWithHint: true,
                        labelStyle: MyPassFonts.style.kLabelSmall( context,
                          color: MyPassColors.greyDarker
                        ),
                        hintText: 'Exemplo: facebook.com',
                        hintStyle: MyPassFonts.style.kLabelSmall(
                          context,
                          color: const Color.fromARGB(73, 0, 0, 0)
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: MyPassColors.greyBD,
                            strokeAlign: BorderSide.strokeAlignCenter,
                          ),
                          borderRadius: BorderRadius.circular(16.0)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: MyPassColors.purpleLight,
                            width: 1.0
                          ),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      keyboardType: TextInputType.url,
                      onChanged: (value) => savePassControll.url(value),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Obx(()=>
                        ElevatedButton(
                            onPressed: ( savePassControll.description.isEmpty ) ? 
                            null
                            :
                            () async {
                              bool result = await savePassControll.savePassword(password);
                              debugPrint('SENHA SALVA');
                              if (result){
                                Get.toNamed('/savePassSuccess');
                              }
                            }
                            ,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: savePassControll.description.isEmpty ?
                                  MyPassColors.greyBD
                                  :
                                  MyPassColors.purpleLight,
                                alignment: Alignment.center,
                                fixedSize: Size(
                                  MediaQuery.of(context).size.width,
                                  56.0
                                ),
                              ),
                            child: Text(
                              'Salvar',
                              style: TextStyle(
                                color: ( savePassControll.description.isEmpty )
                                  ? MyPassColors.greyDarker
                                  : MyPassColors.whiteF0,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              )
                            ) 
                          )
                      )
                    ],
                  )
                )
              ],
            ),
          ),
        )
      ],
    )
    );
  }
}
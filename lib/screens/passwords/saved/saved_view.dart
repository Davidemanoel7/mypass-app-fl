import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypass/screens/passwords/saved/saved_controll.dart';
import 'package:mypass/utils/themes.dart';
import 'package:mypass/widgets/components/customShimmer.dart';
import 'package:mypass/widgets/components/passwordButton.dart';

class SavedPassView extends StatelessWidget {
  SavedPassView({super.key});

  TextEditingController searchController = TextEditingController();
  SavedController savedController = Get.put(SavedController());
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {

    RxBool scrollFetching = false.obs;

    _scrollController.addListener(() async {
      if ( !savedController.isLoading.value && _scrollController.position.pixels == _scrollController.position.maxScrollExtent ){
        savedController.pageNum.value += 1;
        scrollFetching(true);
        await savedController.fetchPasswords();
        scrollFetching(false);
      }
    });

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,  
          elevation: 0,
          title: Text(
            'Minhas senhas',
            style: MyPassFonts.style.kLabelMedium(context,
              color: MyPassColors.black1B,
              fontWeight: FontWeight.w700
            ),
          ),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            debugPrint('\nTry fetching more passwords!');
            debugPrint('PageNum: ${savedController.pageNum.value}');
            savedController.pageNum.value += 1;
            debugPrint('PageNum: ${savedController.pageNum.value}');
            await savedController.fetchPasswords();
            savedController.update();
          },
          backgroundColor: MyPassColors.purpleLight,
          child: const Icon(Icons.add),
        ),
        body: SingleChildScrollView(
          physics: const  ClampingScrollPhysics(),
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            children: <Widget>[
              Form(
                autovalidateMode: AutovalidateMode.always,
                child: TextFormField(
                  clipBehavior: Clip.antiAlias,
                  controller: searchController,
                  style: TextStyle(
                    backgroundColor:Colors.white.withOpacity(0.1),
                  ),
                  decoration: InputDecoration(
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.search,
                          color:MyPassColors.greyBD
                        )
                      ),
                    ),
                    hintText: 'pesquisar',
                    hintStyle: MyPassFonts.style.kLabelMedium(context,
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
                  textInputAction: TextInputAction.done,
                  // validator: (value) => validInput.validationMessage( ValidationType.senha, value! ),
                  onChanged: (value) {
                    debugPrint(value);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Row(
                  children: [
                    Text(
                      'Minhas senhas',
                      style: MyPassFonts.style.kLabelMedium(context,
                        color: MyPassColors.blueLight
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Obx(() => !savedController.isLoading.value && savedController.passwords.isEmpty ?
                    const Center(
                      child: Text('Nenhuma senha cadastrada...'),
                    )
                  :
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    // controller: _scrollController,
                    scrollDirection: Axis.vertical,
                    itemCount: savedController.isLoading.value ? 10 :  savedController.passwords.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                      savedController.isLoading.value
                        ? CustomShimmer(
                            height: 64,
                            width: MediaQuery.of(context).size.width,
                            borderRadius: 16
                          )
                        : PasswordButton(pass: savedController.passwords[index]),
                    separatorBuilder: (context, index) => const SizedBox(height: 8),
                  ),
                )
              ),
              Obx(() => scrollFetching.value
              ? const CircularProgressIndicator(
                color: MyPassColors.greyDarker,
              )
              : const SizedBox()
              ),
            ],
          ),
        ),
      )
    );
  }
}
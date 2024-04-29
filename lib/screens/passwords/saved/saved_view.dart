import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypass/screens/home/homeControll.dart';
import 'package:mypass/utils/themes.dart';
import 'package:mypass/widgets/components/customShimmer.dart';
import 'package:mypass/widgets/components/passwordButton.dart';

// ignore: must_be_immutable
class SavedPassView extends StatelessWidget {
  SavedPassView({super.key});

  TextEditingController searchController = TextEditingController();
  HomeControll homeController = Get.put(HomeControll());
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {

    RxBool scrollFetching = false.obs;

    _scrollController.addListener(() async {
      if ( !homeController.loadRequest.value && _scrollController.position.pixels == _scrollController.position.maxScrollExtent ){
        homeController.pageNum.value += 1;
        scrollFetching(true);
        await homeController.fetchPasswords();
        scrollFetching(false);
      }
    });

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          backgroundColor: Colors.transparent,  
          elevation: 2,
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
          onPressed: () {
            Get.toNamed('/create/password');
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                child: Obx(() => !homeController.loadRequest.value && homeController.listPasswords.isEmpty ?
                    Column(
                      children: [
                        Image.asset(
                          './lib/assets/images/key.png',
                          height: 104,
                        ),
                        const Text(
                          'Nenhuma senha cadastrada...',
                          style: TextStyle(
                            color: MyPassColors.greyDarker,
                            fontSize: 14,
                            fontWeight: FontWeight.w200
                          ),
                        )
                      ],
                    )
                  :
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    // controller: _scrollController,
                    scrollDirection: Axis.vertical,
                    itemCount: homeController.loadRequest.value ? 8 :  homeController.listPasswords.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                      homeController.loadRequest.value
                        ? CustomShimmer(
                            height: 64,
                            width: MediaQuery.of(context).size.width,
                            borderRadius: 16
                          )
                        : PasswordButton(pass: homeController.listPasswords[index]),
                    separatorBuilder: (context, index) => const SizedBox(height: 8),
                  ),
                )
              ),
              Obx(() => scrollFetching.value
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: CircularProgressIndicator(
                    color: MyPassColors.greyDarker,
                  ),
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
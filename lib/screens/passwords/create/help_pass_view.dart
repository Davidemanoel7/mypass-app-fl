import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypass/utils/themes.dart';

class HelpPassView extends StatelessWidget {
  const HelpPassView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,  
        elevation: 0,
        title: Text(
          'Dicas básicas',
          style: MyPassFonts.style.kLabelMedium(context,
            color: MyPassColors.black1B,
            fontWeight: FontWeight.w700
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Escolha uma senha segura:',
                  style: MyPassFonts.style.kLabelLarge(context,
                    color: MyPassColors.blueLight,
                    fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '1. Escolha senhas fáceis de lembrar',
                    style: MyPassFonts.style.kLabelMedium(context,
                      color: MyPassColors.blueLight
                    )  
                  ),
                  Text(
                    'Escolher senhas fáceis de lembrar evita que o usuário tenha que anotá-la em papéis e/ou arquivos, que podem chegar às mãos de pessoas erradas',
                    style: MyPassFonts.style.kLabelSmall(context,
                      color: MyPassColors.black1B
                    )
                  )
                ]
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '2. Não use palavras reais.',
                    style: MyPassFonts.style.kLabelMedium(context,
                      color: MyPassColors.blueLight
                    )  
                  ),
                  Text(
                    'Uma palavra que pode ser encontrada no dicionário pode facilitar o trabalho de invasores. Para tornar esse trabalho mais difícil, use frases ao invés de substantivos',
                    style: MyPassFonts.style.kLabelSmall(context,
                      color: MyPassColors.black1B
                    )
                  )
                ]
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '3. Combine maiúsculas, minúsculas, números e caracteres não alfanuméricos',
                    style: MyPassFonts.style.kLabelMedium(context,
                      color: MyPassColors.blueLight
                    )  
                  ),
                  Text(
                    'Utilizando uma senha gerada altomaticamente, com letras MAIÚSCULAS, números e caracteres especiais pode almentar significativamente a segurança de suas senhas.',
                    style: MyPassFonts.style.kLabelSmall(context,
                      color: MyPassColors.black1B
                    )
                  )
                ]
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '4. Não recicle senhas',
                    style: MyPassFonts.style.kLabelMedium(context,
                      color: MyPassColors.blueLight
                    )  
                  ),
                  Text(
                    'Por exemplo, não use “senha1” , “senha321” ou qualquer senha semelhante. Escolha senhas aleatórias.',
                    style: MyPassFonts.style.kLabelSmall(context,
                      color: MyPassColors.black1B
                    )
                  )
                ]
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '5. Fuja do óbvio',
                    style: MyPassFonts.style.kLabelMedium(context,
                      color: MyPassColors.blueLight
                    )  
                  ),
                  Text(
                    'Evite senhas óbvias, como: datas importantes, números telefônicos, nomes e/ou apelidos e senhas populares. Use sua criatividade ou gere uma senha aleatória que seja memorável!',
                    style: MyPassFonts.style.kLabelSmall(context,
                      color: MyPassColors.black1B
                    )
                  )
                ]
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0 ),
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyPassColors.purpleLight,
                  alignment: Alignment.center,
                  fixedSize: Size(
                    MediaQuery.of(context).size.width,
                    56.0
                  ),
                ),
                child: const Text(
                  'Voltar',
                  style: TextStyle(
                    color: MyPassColors.whiteF0,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  )
                ) 
              ),
            )
          ],
        ),
      )
    );
  }
}
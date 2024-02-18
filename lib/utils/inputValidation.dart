enum ValidationType { email, senha, texto }

class ValidationInput {
  
  bool isValid(){
    return true;
  }

  String? validationMessage(ValidationType type, String value) {
    switch(type) {
      case ValidationType.email:
        return validateEmail(value);
      
      case ValidationType.senha:
        return validatePass(value);
      
      case ValidationType.texto:
        return validateText(value);
      
      default:
        return null;
    }
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'O email não pode estar vazio';
    }

    const pattern = r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)";
    final regex = RegExp(pattern);

    if (!regex.hasMatch(email)) {
      return 'Informe um email válido';
    }

    return null;
  }

  String? validatePass(String? pass) {
    const pattern = r'^[a-zA-Z0-9_!@#.$]{6,20}$';
    final regex = RegExp(pattern);

    if (pass == null || pass.isEmpty) {
      return 'A senha não pode estar vazia';
    }

    if (pass.length < 6 || pass.length > 20) {
      return 'A senha deve ter entre 6 e 20 caracteres';
    }

    if (!regex.hasMatch(pass)) {
      return 'Informe uma senha válida';
    }

    return null;
  }

  String? validateText( String? text) {
    if ( text!.length > 200 ) {
      return 'O máximo de caracteres aceitos são 200.';
    }
    return null;
  }
}
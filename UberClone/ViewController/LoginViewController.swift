//
//  LoginViewController.swift
//  UberClone
//
//  Created by José Vitor Scheffer Boff dos Santos on 28/10/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var senha: UITextField!
    
    @IBAction func handleSignIn(_ sender: Any) {
        let retorno = self.validarCampos()
        
        if retorno == "" {
            let autenticacao = Auth.auth()
            if let emailR = self.email.text {
                if let senhaR = self.senha.text {
                    autenticacao.signIn(withEmail: emailR, password: senhaR) { usuario, erro in
                        if erro == nil {
                            if usuario != nil {
                                print("Usuário autenticado com sucesso!")
                            }
                        } else {
                            print("Erro ao autenticar usuário, tente novamente!")
                        }
                    }
                }
            }
        } else {
            print("O campo \(retorno) não foi preenhido!")
        }
    }
    
    
    func validarCampos() -> String {
        if (self.email.text?.isEmpty)! {
            return "E-mail"
        } else if (self.senha.text?.isEmpty)! {
            return "Senha"
        }
        
        return ""

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

}

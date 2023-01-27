//
//  LoginViewController.swift
//  UberClone
//
//  Created by José Vitor Scheffer Boff dos Santos on 28/10/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        clearTextFields()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction private func didPressSignIn(_ sender: Any) {
        self.view.addLoading()
        
        let validationError = self.formValidate()
        
        if validationError == "" {
            let autenticacao = Auth.auth()
            guard let email = emailField.text else {return}
            guard let password = passwordField.text else {return}
            
                    autenticacao.signIn(withEmail: email, password: password) { user, error in
                        if error == nil {
                            if user != nil {
                                self.view.removeLoading()

                                self.performSegue(withIdentifier: "segueLogin", sender: nil)
                            }
                        } else {
                            self.view.removeLoading()
                            
                            let alert = UIAlertController(title: "Ocorreu um erro", message: "Dados inválidos, verifique os campos e tente novamente.", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
                            
                            self.present(alert, animated: true)
                        }
            }
        } else {
            self.view.removeLoading()

            let alert = UIAlertController(title: "", message: "O campo \(validationError) não foi preenchido!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
            
            self.present(alert, animated: true)
        }
    }
    
    
    private func formValidate() -> String {
        if (self.emailField.text?.isEmpty)! {
            return "E-mail"
        } else if (self.passwordField.text?.isEmpty)! {
            return "Senha"
        }
        
        return ""

    }
    
    private func clearTextFields() {
        emailField.text = ""
        passwordField.text = ""
    }
}

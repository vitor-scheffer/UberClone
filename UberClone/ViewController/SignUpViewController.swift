//
//  SignUpViewController.swift
//  UberClone
//
//  Created by José Vitor Scheffer Boff dos Santos on 28/10/22.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var userType: UISwitch!
    
    @IBAction func didPressSignUp(_ sender: Any) {
        let validationError = self.formValidate()
        
        if validationError == "" {
            self.view.addLoading()
            
            let auth = Auth.auth()
            guard let email = emailField.text else { return }
            guard let name = nameField.text else { return }
            guard let password = passwordField.text else { return }
            
            auth.createUser(withEmail: email, password: password, completion: { user, error in
                if error == nil {
                    if user != nil {
                        let database = Database.database().reference()
                        let users = database.child("usuarios")
                        guard let userUID = user?.user.uid else { return }
                        
                        func checkType() -> String {
                            if self.userType.isOn {
                                return "passageiro"
                            } else {
                                return "motorista"
                            }
                        }
                        
                        let userData = [
                            "email": email,
                            "nome": name,
                            "tipo": checkType()
                        ]
                        
                        users.child(userUID).setValue(userData)
                        
                        self.view.removeLoading()
                    }
                } else {
                    self.view.removeLoading()

                    let alert = UIAlertController(title: "Ocorreu um erro", message: "Dados inválidos, verifique os campos e tente novamente.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
                    
                    self.present(alert, animated: true)
                }
            })
             
        } else {
            let alert = UIAlertController(title: "", message: "O campo \(validationError) não foi preenchido!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
            
            self.present(alert, animated: true)
        }
    }
    
    func formValidate() -> String {
        if (self.emailField.text?.isEmpty)! {
            return "E-mail"
        } else if (self.nameField.text?.isEmpty)! {
            return "Nome Completo"
        } else if (self.passwordField.text?.isEmpty)! {
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        clearTextFields()
    }

    private func clearTextFields() {
        emailField.text = ""
        nameField.text = ""
        passwordField.text = ""
    }
}

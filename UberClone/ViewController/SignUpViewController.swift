//
//  SignUpViewController.swift
//  UberClone
//
//  Created by José Vitor Scheffer Boff dos Santos on 28/10/22.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var nomeCompleto: UITextField!
    @IBOutlet weak var senha: UITextField!
    @IBOutlet weak var tipoUsuario: UISwitch!
    
    @IBAction func cadastrarUsuario(_ sender: Any) {
        let retorno = self.validarCampos()
        if retorno == "" {
            print("Cadastro realizado com sucesso!")
        } else {
            print("O campo \(retorno) não foi preenchido!")
        }
        
    }
    
    func validarCampos() -> String {
        if (self.email.text?.isEmpty)! {
            return "E-mail"
        } else if (self.nomeCompleto.text?.isEmpty)! {
            return "Nome Completo"
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

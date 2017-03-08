//
//  LoginViewController.swift
//  Instagram
//
//  Created by Arthur on 2017/3/5.
//  Copyright © 2017年 Kuan-Ting Wu (Arthur Wu). All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet var userNameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onSignIn(_ sender: Any)
    {
        PFUser.logInWithUsername(
        inBackground: userNameField.text!, password: passwordField.text!)
        { (user: PFUser?, error:Error?) in
            print("loggin")
            
            
            user?.password = self.passwordField.text!
            
            var bufferUser = User(userName: self.userNameField.text!, password: self.passwordField.text!)
            User.currentUser = bufferUser
            
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }
    }
    
    @IBAction func onSignUp(_ sender: Any)
    {
        let newUser = PFUser()
        
        newUser.username = userNameField.text!
        newUser.password = passwordField.text!
        
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if success
            {
                print("created a user")
                
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            else
            {
                print(error?.localizedDescription)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

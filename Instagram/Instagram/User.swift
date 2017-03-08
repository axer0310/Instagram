//
//  User.swift
//  Instagram
//
//  Created by Arthur on 2017/3/5.
//  Copyright © 2017年 Kuan-Ting Wu (Arthur Wu). All rights reserved.
//

import UIKit
import Parse
class User: NSObject
{
    var userName: String?
    var password: String?
    static let userDidLogoutNotification = "UserDidLogout"
    
    init(userName: String, password: String)
    {
        self.userName = userName
        self.password = password
    }
    
    
    static var _currentUser: User?
    
    class var currentUser: User?
    {
        get
        {
            if (_currentUser == nil)
            {
                
                let defaults = UserDefaults.standard
                let userName = defaults.object(forKey: "currentUserName") as? String
                let userPass = defaults.object(forKey: "currentUserPass") as? String
                if let userName = userName
                {
                    if let userPass = userPass
                    {
                        _currentUser = User(userName: userName, password: userPass)
                    }
                    
                }
                
            }
            
            return _currentUser
        }
        set(user)
        {
            _currentUser = user
            let defaults = UserDefaults.standard
            
            if let user = user
            {
                
                print(user.userName)
                print(user.password)
                
                defaults.set(user.userName!, forKey: "currentUserName")
                defaults.set(user.password!, forKey: "currentUserPass")
            }
            else
            {
                defaults.removeObject(forKey: "currentUserName")
                defaults.removeObject(forKey: "currentUserPass")
            }
            
            defaults.synchronize()
        }
        
    }
 

}

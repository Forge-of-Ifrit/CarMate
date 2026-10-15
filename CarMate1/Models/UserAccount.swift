//
//  UserAccount.swift
//  CarMate1
//
//  Created by Abdulrahmanb on 18/11/2025.
//

import Foundation
import SwiftData

@Model
class UserAccount {
    
    var username: String
    var password: String
    
    init(username: String = "", password: String = "") {
        
        self.username = username
        self.password = password
        
    }
}

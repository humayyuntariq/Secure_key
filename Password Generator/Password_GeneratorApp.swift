//
//  Password_GeneratorApp.swift
//  Password Generator
//
//  Created by Humayun Tariq on 14/08/2024.
//

import SwiftUI
import Foundation

@main
struct Password_GeneratorApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
            
            
        }
    }
}

class passwordGenerator{
    static func generatePassowrd(length: Int, num: Bool, lowerAlpha: Bool, upperAlpha: Bool, symbols: Bool) -> String
    {
        let lowercaseLetters = "abcdefghijklmnopqrstuvwxyz"
              let uppercaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
              let numbers = "0123456789"
              let specialChar = "!@#$%^&*(),.?\":{}|<>"
        
        var characterset = ""
        
        if lowerAlpha{
            characterset += lowercaseLetters
        }
        
        if num {
            characterset += numbers
        }
        
        if upperAlpha {
            characterset += uppercaseLetters
        }
        
        if symbols {
            characterset += specialChar
        }
        
        var password = ""
        
        for _ in 0..<length {
            if let randomcharacter = characterset.randomElement(){
                password.append(randomcharacter)
            }
        }
        
        
        
        // Trim any unexpected leading/trailing whitespace or newlines
               return password.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}



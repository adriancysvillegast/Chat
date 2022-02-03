//
//  Constants.swift
//  Chat
//
//  Created by Adriancys Jesus Villegas Toro on 20/12/21.
//

struct K {
    static let appName = "Flash Messages ⚡️"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    
    struct Segue {
        static let registerToChat = "RegisterToChat"
        static let loginToChat = "LoginToChat"
        static let errorLogin = "ErrorLogin"
    }
    
    struct BrandColor {
        static let purple = "BrandPurple"
        static let colorTest = "ColorTest"
        static let blue = "BrandBlue"
        static let lightBlue = "BrandLightBlue"
        static let lightPurple = "BrandLightPurple"
    }

    struct Avatar {
        static let meAvatar = "MeAvatar"
        static let youAvatar = "YouAvatar"
    }
    struct FStore{
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}

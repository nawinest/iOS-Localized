//
//  LanguageManager.swift
//  POCLanguagesLocalized
//
//  Created by Nawin Phunsawat on 2/4/2563 BE.
//  Copyright © 2563 Nawin Phunsawat. All rights reserved.
//

import UIKit

public class LanguageManager {

    public static let shared: LanguageManager = LanguageManager()
    
    fileprivate enum LanguageManagerConstants {
        static let selectedLanguage = "LanguageManagerSelectedLanguage"
        static let defaultLanguage = "LanguageManagerDefaultLanguage"
    }
    
    public enum Languages: String {
        case en
        case th
        case deviceLanguage
        
        public func isThaiLanguage() -> Bool {
            return self == .th
        }
    }
    
    init() {
        UserDefaults.standard.set(Languages.th.rawValue, forKey: LanguageManagerConstants.defaultLanguage)
    }
    
    public var currentLanguage: Languages {
        get {
            guard let currentLang = UserDefaults.standard.string(forKey: LanguageManagerConstants.selectedLanguage) else {
//                fatalError("Did you set the default language for the app ?")
                return self.defaultLanguage
            }
            return Languages(rawValue: currentLang) ?? self.defaultLanguage
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: LanguageManagerConstants.selectedLanguage)
        }
    }

    public var defaultLanguage: Languages {
        get {
            
            guard let defaultLanguage = UserDefaults.standard.string(forKey: LanguageManagerConstants.defaultLanguage) else {
                fatalError("Did you set the default language for the app ?")
            }
            return Languages(rawValue: defaultLanguage) ?? .th
        }
    }
    
    public var deviceLanguage: Languages? {
        get {
            guard let deviceLanguage = Bundle.main.preferredLocalizations.first else {
                return nil
            }
            return Languages(rawValue: deviceLanguage)
        }
    }
    
    public var isRightToLeft: Bool {
        get {
            return isLanguageRightToLeft(language: currentLanguage)
        }
    }
    
    private func isLanguageRightToLeft(language: Languages) -> Bool {
        return Locale.characterDirection(forLanguage: language.rawValue) == .rightToLeft
    }
    
    public var appLocale: Locale {
        get {
            return Locale(identifier: currentLanguage.rawValue)
        }
    }
}

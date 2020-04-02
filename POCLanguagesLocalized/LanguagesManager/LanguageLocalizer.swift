//
//  LanguageLocalizer.swift
//  POCLanguagesLocalized
//
//  Created by Nawin Phunsawat on 2/4/2563 BE.
//  Copyright © 2563 Nawin Phunsawat. All rights reserved.
//

import Foundation

class LanguageLocalizer: NSObject {
    class func doTheSwizzling() {
        MethodSwizzleGivenClassName(cls: Bundle.self, originalSelector: #selector(Bundle.localizedString(forKey:value:table:)), overrideSelector: #selector(Bundle.specialLocalizedStringForKey(_:value:table:)))
    }
}

extension Bundle {
    func matchedLocalizedValue(_ key: String, value: String?, bundlePath: String? = nil, table tableName: String?, currentLanguage: String = "en", hasValueExisted: Bool) -> String? {
        var localizedString: String?
        var path: String?
        var bundle: Bundle?
        if let bundlePath = bundlePath {
            bundle = Bundle(path: bundlePath)
        } else {
            bundle = Bundle.main
        }
        
        if let _path = bundle?.path(forResource: currentLanguage, ofType: "lproj") {
            path = _path
        } else if let _path = bundle?.path(forResource: LanguageManager.Languages.th.rawValue, ofType: "lproj") {
            path = _path
        }
        
        if let path = path, let _bundle = Bundle(path: path) {
            localizedString = _bundle.specialLocalizedStringForKey(key, value: value, table: tableName)
        }
        
        if hasValueExisted {
            if (localizedString != value) {
                return localizedString
            }
        } else {
            if (localizedString != key) {
                return localizedString
            }
        }
        
        return nil
    }
    
    @objc func specialLocalizedStringForKey(_ key: String, value: String?, table tableName: String?) -> String {
        let currentLanguage = LanguageManager.shared.currentLanguage.rawValue
        let allBundles = Bundle.allFrameworks
        var localizedString = key
        var hasValueExisted = false
        if let value = value, value.trim() != "" {
            localizedString = value
            hasValueExisted  = true
        }
        
        if let _localizedString = self.matchedLocalizedValue(key, value: value, table: tableName, currentLanguage: currentLanguage, hasValueExisted: hasValueExisted) {
            return _localizedString
        }
        
        for framework in allBundles {
            if let _localizedString = self.matchedLocalizedValue(key, value: value, bundlePath: framework.bundlePath, table: tableName, currentLanguage: currentLanguage, hasValueExisted: hasValueExisted) {
                return _localizedString
            }
        }
        
        return localizedString
    }
}


/// Exchange the implementation of two methods of the same Class
func MethodSwizzleGivenClassName(cls: AnyClass, originalSelector: Selector, overrideSelector: Selector) {
    let origMethod: Method = class_getInstanceMethod(cls, originalSelector)!
    let overrideMethod: Method = class_getInstanceMethod(cls, overrideSelector)!
    if (class_addMethod(cls, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(cls, overrideSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, overrideMethod);
    }
}

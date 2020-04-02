//
//  Extension+String.swift
//  POCLanguagesLocalized
//
//  Created by Nawin Phunsawat on 2/4/2563 BE.
//  Copyright © 2563 Nawin Phunsawat. All rights reserved.
//

import UIKit

extension String {
    public func localized(tableName: String = "Localized") -> String {
        let localizedString = NSLocalizedString(self, tableName: tableName, bundle: Bundle.main, value: "", comment: "")
        return localizedString
    }
    
    public func trim() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
}

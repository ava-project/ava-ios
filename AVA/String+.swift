//
//  String+.swift
//  AVA
//
//  Created by Jean Sarda on 05/01/2018.
//  Copyright © 2018 Jean Sarda. All rights reserved.
//

import Foundation

extension String {
    
    var localized: String {
        get {
            return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
        }
    }
    
}

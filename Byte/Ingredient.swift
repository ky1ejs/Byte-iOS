//
//  Ingredient.swift
//  Byte
//
//  Created by Kyle McAlpine on 05/02/2017.
//  Copyright © 2017 Kyle McAlpine. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Ingredient {
    let uid: String
    let name: String
    
    init(uid: String, name: String) {
        self.uid = uid
        self.name = name
    }
    
    init?(snapshot: FIRDataSnapshot) {
        guard let json = snapshot.value as? JSON else { return nil }
        self.init(json: json)
    }
    
    init?(json: JSON) {
        guard let uid = json["uid"] as? String else { return nil }
        guard let name = json["name"] as? String else { return nil }
        self.uid = uid
        self.name = name
    }
}

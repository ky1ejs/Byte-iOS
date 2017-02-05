//
//  Meal.swift
//  Byte
//
//  Created by Kyle McAlpine on 05/02/2017.
//  Copyright © 2017 Kyle McAlpine. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Meal {
    let ingredients: [Ingredient]
    
    init?(snapshot: FIRDataSnapshot) {
        guard let dict = snapshot.value as? NSDictionary else { return nil }
        self.init(dictionary: dict)
    }
    
    init?(dictionary: NSDictionary) {
        guard let ingredients = dictionary["ingredients"] as? [String : String] else { return nil }
        self.ingredients = ingredients.values.map(Ingredient.init)
    }
}

struct Ingredient {
    let name: String
    
    init(_ name: String) {
        self.name = name
    }
}

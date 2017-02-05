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
    let date: Date
    let ingredients: [Ingredient]
    
    var json: JSON {
        return [
            "date"          : date.jsonString,
            "ingredients"   : ingredients.map() { $0.uid }
        ]
    }
    
    init(date: Date, ingredients: [Ingredient]) {
        self.date = date
        self.ingredients = ingredients
    }
    
    init?(snapshot: FIRDataSnapshot) {
        guard let dict = snapshot.value as? NSDictionary else { return nil }
        self.init(dictionary: dict)
    }
    
    init?(dictionary: NSDictionary) {
        guard let date = Date(jsonString: dictionary["date"] as? String ?? "") else { return nil }
        guard let ingredients = dictionary["ingredients"] as? [AnyHashable : JSON] else { return nil }
        self.date = date
        self.ingredients = ingredients.values.flatMap(Ingredient.init)
    }
}


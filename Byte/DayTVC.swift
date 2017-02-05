//
//  DayTVC.swift
//  Byte
//
//  Created by Kyle McAlpine on 05/02/2017.
//  Copyright © 2017 Kyle McAlpine. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class DayTVC: UITableViewController {
    var meals = [Meal]()
    
    init() {
        super.init(style: .plain)
        initialise()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialise()
    }
    
    func initialise() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMeal))
        fetchMeals()
    }
    
    func fetchMeals() {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else { return }
        FIRDatabase.database().reference().child("users/\(uid)/meals").observe(.value, with: { snapshot in
            guard let meals = snapshot.value as? [String : NSDictionary] else { return }
            self.meals = meals.values.flatMap(Meal.init)
            self.tableView.reloadData()
        })
    }
    
    func addMeal() {
        present(CreateEditMealVC(), animated: true, completion: nil)
    }
}


extension DayTVC {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals[section].ingredients.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ident = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: ident) ?? UITableViewCell(style: .default, reuseIdentifier: ident)
        cell.textLabel?.text = meals[indexPath.section].ingredients[indexPath.row].name
        return cell
    }
}


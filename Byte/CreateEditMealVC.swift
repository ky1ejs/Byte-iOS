//
//  CreateEditMealVC.swift
//  Byte
//
//  Created by Kyle McAlpine on 05/02/2017.
//  Copyright © 2017 Kyle McAlpine. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CreateEditMealVC: UIViewController {
    private var date = Date()
    fileprivate var ingredients = [Ingredient]()
    
    override func loadView() {
        let view = CreateEditMealView()
        
        let datePicker = UIDatePicker(frame: .zero)
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePicked(picker:)), for: .valueChanged)
        view.dateTF.inputView = datePicker
        
        view.saveButton.target = self
        view.saveButton.action = #selector(save)
        view.cancelButton.target = self
        view.cancelButton.action = #selector(cancel)
        
        self.view = view
        
    }
    
    func save() {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else { return }
        let meal = Meal(date: date, ingredients: ingredients)
        FIRDatabase.database().reference().child("users/\(uid)/meals").childByAutoId().updateChildValues(meal.json) { error, ref in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    func datePicked(picker: UIDatePicker) {
        date = picker.date
    }
}

extension CreateEditMealVC:  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ident = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: ident) ?? UITableViewCell(style: .default, reuseIdentifier: ident)
        let isLastCell = indexPath.row == ingredients.count
        cell.textLabel?.text = isLastCell ? "Add Ingredient" : ingredients[indexPath.row].name
        cell.selectionStyle = isLastCell ? .default : .none
        return cell
    }
}

extension CreateEditMealVC:  UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(at: indexPath, animated: true) }
        guard indexPath.row == ingredients.count else { return }
    }
}


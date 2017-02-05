//
//  CreateEditMealView.swift
//  Byte
//
//  Created by Kyle McAlpine on 05/02/2017.
//  Copyright © 2017 Kyle McAlpine. All rights reserved.
//

import UIKit
import EasyPeasy

class CreateEditMealView: UIView {
    let dateTF = UITextField()
    let ingredientsTable = UITableView()
    let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: nil, action: nil)
    let cancelButton =  UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .white
        
        let navItem = UINavigationItem()
        navItem.rightBarButtonItem = saveButton
        navItem.leftBarButtonItem = cancelButton
        
        let navBar = UINavigationBar()
        navBar.items = [navItem]
        
        addSubview(navBar)
        addSubview(dateTF)
        addSubview(ingredientsTable)
        
        navBar <- [
            Top(20),
            Leading(),
            CenterX()
        ]
        
        dateTF <- [
            Top(20).to(navBar),
            Leading(30),
            Height(20),
            CenterX()
        ]
        
        ingredientsTable <- [
            Leading(),
            CenterX(),
            Top(50).to(dateTF),
            Bottom()
        ]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CreateEditMealView: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

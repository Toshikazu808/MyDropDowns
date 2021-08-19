//
//  Extensions.swift
//  MyDropDowns
//
//  Created by Ryan Kanno on 8/19/21.
//

import UIKit

extension UITableView {
   func initializeDropDown() {
      translatesAutoresizingMaskIntoConstraints = true
      clipsToBounds = true
      backgroundColor = .clear
      layer.cornerRadius = 8
      alpha = 0
      isHidden = true
      register(UINib(nibName: DropCell.id, bundle: nil), forCellReuseIdentifier: DropCell.id)
   }
}

extension UIStackView {
   func initializeVerticalStackView() {
      translatesAutoresizingMaskIntoConstraints = true
      clipsToBounds = true
      alignment = .center
      axis = .vertical
      distribution = .fillEqually
      contentMode = .scaleAspectFill
      spacing = Button.preferredSpacing
      backgroundColor = .clear
      alpha = 1
      isHidden = false
   }
}

extension UIView {
   func initializeTransparentView() {
      translatesAutoresizingMaskIntoConstraints = true
      clipsToBounds = true
      backgroundColor = .black.withAlphaComponent(0.4)
      isUserInteractionEnabled = true
      alpha = 0
      isHidden = true
   }
}

//
//  Button.swift
//  TestProgrammaticDropDowns
//
//  Created by Ryan Kanno on 8/18/21.
//

import UIKit

protocol ButtonDelegate: AnyObject {
   func buttonTapped(buttonTitle: String)
}

final class Button: UIButton {
   weak var delegate: ButtonDelegate?
   var title: String?
   static let preferredHeight: CGFloat = 80
   static let preferredSpacing: CGFloat = 40
   static let borderWidth: CGFloat = 4
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      addTarget(self, action: #selector(tapped), for: .touchUpInside)
      backgroundColor = .systemGreen
      titleLabel?.textColor = .white
      titleLabel?.font = UIFont(name: "Chalkboard SE", size: 40)
      layer.cornerRadius = 8
      layer.borderWidth = Button.borderWidth
      layer.borderColor = UIColor.white.cgColor
      isUserInteractionEnabled = true
   }
   
   convenience init(title: String) {
      self.init()
      setTitle(title, for: .normal)
      self.title = title
   }
   
   required init?(coder: NSCoder) {
      fatalError()
   }
    
   @objc private func tapped() {
      if let title = title {
         self.delegate?.buttonTapped(buttonTitle: title)
      }
   }

}

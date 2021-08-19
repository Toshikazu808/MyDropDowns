//
//  DropCell.swift
//  TestProgrammaticDropDowns
//
//  Created by Ryan Kanno on 8/18/21.
//

import UIKit

class DropCell: UITableViewCell {
   static let id = "DropCell"
   static let preferredHeight: CGFloat = 80
   @IBOutlet weak var cellTitleLabel: UILabel!
   
   override func awakeFromNib() {
      super.awakeFromNib()
      layer.borderWidth = 2.5
      layer.borderColor = UIColor.white.cgColor
      layer.cornerRadius = 8
      isUserInteractionEnabled = true
      alpha = 1
      isHidden = false
   }
   
   override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
   }
   
   func configure(title: String) {
      cellTitleLabel.text = title
      print("cellTitleLabel.text: \(cellTitleLabel.text ?? "No title set")")
   }
   
}

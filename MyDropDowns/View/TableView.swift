//
//  TableView.swift
//  TestProgrammaticDropDowns
//
//  Created by Ryan Kanno on 8/18/21.
//

import UIKit

protocol TableViewDelegate: AnyObject {
   func cellTapped(fromTableView: String)
}

class TableView: UIView {
   weak var delegate: TableViewDelegate?
   var dataSource: [String] = []
   
   let tableView: UITableView = {
      let tableView = UITableView()
      tableView.translatesAutoresizingMaskIntoConstraints = true
      tableView.clipsToBounds = true
      tableView.alpha = 1
      tableView.isHidden = false
      tableView.layer.cornerRadius = 8
      tableView.register(UINib(nibName: DropCell.id, bundle: nil), forCellReuseIdentifier: DropCell.id)
      return tableView
   }()
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      translatesAutoresizingMaskIntoConstraints = true
      clipsToBounds = true
      layer.cornerRadius = 8
      alpha = 1
      isHidden = false
      backgroundColor = .red
      
      addSubview(tableView)
      tableView.delegate = self
      tableView.dataSource = self
      // Layout can only be done via frame OR constraints!  NOT BOTH!!!
      
//      NSLayoutConstraint.activate([
//         tableView.topAnchor.constraint(equalTo: self.topAnchor),
//         tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//         tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//         tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
//      ])
   }
   
   convenience init(dataSource: [String]) {
      self.init()
      self.dataSource = dataSource
   }
   
   required init?(coder: NSCoder) {
      fatalError()
   }
   
}

extension TableView: UITableViewDelegate, UITableViewDataSource {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return dataSource.count
   }
   
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return DropCell.preferredHeight
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: DropCell.id, for: indexPath) as? DropCell else {
         fatalError()
      }
      cell.configure(title: dataSource[indexPath.row])
      return cell
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      print("Cell tapped: \(dataSource[indexPath.row])")
   }
}

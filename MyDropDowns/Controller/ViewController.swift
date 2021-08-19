//
//  ViewController.swift
//  TestProgrammaticDropDowns
//
//  Created by Ryan Kanno on 8/18/21.
//

import UIKit
//import DropDown

class ViewController: UIViewController {
   private var vStackWidth: CGFloat {
      return view.frame.width * 0.65
   }
   private var vStackHeight: CGFloat {
      return (Button.preferredHeight * CGFloat(3)) + (Button.preferredSpacing * CGFloat(3))
   }
   private var vStackX: CGFloat {
      return (view.frame.width - vStackWidth) / 2
   }
   private var vStackY: CGFloat {
      return (view.frame.height - vStackHeight) / 2
   }
   private var vStack: UIStackView = {
      let stack = UIStackView()
      stack.alignment = .center
      stack.axis = .vertical
      stack.distribution = .fillEqually
      stack.contentMode = .scaleToFill
      stack.spacing = 40
      stack.backgroundColor = .clear
      stack.alpha = 1
      stack.isHidden = false
      stack.clipsToBounds = true
      stack.translatesAutoresizingMaskIntoConstraints = true
      return stack
   }()
   
   private var songButton = Button(title: "Song")
   private var soundButton = Button(title: "Sound")
   private var timeButton = Button(title: "Time")
   private var buttons = [Button]()
   private var stackHeight: CGFloat {
      return (Button.preferredHeight * CGFloat(3)) + (Button.preferredSpacing * CGFloat(3))
   }
   
   private let songData = ["Samurai", "Arcade", "Retro"]
   private let soundData = ["Sword", "Pop"]
   private let timeData = ["5 seconds", "10 seconds", "15 seconds"]
   private var dataSources = [[String]]()
//   private let songDropDown = DropDown()
//   private let soundDropDown = DropDown()
//   private let timeDropDown = DropDown()
//   private var dropDowns = [DropDown]()
   
   private let transparentView: UIView = {
      let view = UIView()
      view.translatesAutoresizingMaskIntoConstraints = true
      view.clipsToBounds = true
      view.backgroundColor = .black.withAlphaComponent(0.4)
      view.isUserInteractionEnabled = true
      view.alpha = 0
      view.isHidden = true
      return view
   }()
//   private let songTableView: UITableView = {
//      let tableView = UITableView()
//      tableView.translatesAutoresizingMaskIntoConstraints = false
//      tableView.clipsToBounds = true
//      tableView.alpha = 0
//      tableView.isHidden = true
//      tableView.layer.cornerRadius = 8
//      tableView.register(UINib(nibName: DropCell.id, bundle: nil), forCellReuseIdentifier: DropCell.id)
//      return tableView
//   }()
   
   private let testView: UIView = {
      let view = UIView()
      view.translatesAutoresizingMaskIntoConstraints = false
      view.clipsToBounds = true
      view.backgroundColor = .blue
      view.layer.cornerRadius = 8
      view.alpha = 1
      view.isHidden = false
      return view
   }()
   
   
   private let songTableView = TableView(dataSource: ["Samurai", "Arcade", "Retro"])
   private var songTableY: CGFloat {
      return vStack.frame.minY + Button.preferredHeight
   }
   private var songTableHeight: CGFloat {
      return DropCell.preferredHeight * CGFloat(songTableView.dataSource.count)
   }
   
   private let soundTableView = TableView(dataSource: ["Sword", "Pop"])
   private var soundTableHeight: CGFloat {
      return DropCell.preferredHeight * CGFloat(soundTableView.dataSource.count)
   }
   
   private let timeTableView = TableView(dataSource: ["5 seconds", "10 seconds", "15 seconds"])
   private var timeTableHeight: CGFloat {
      return DropCell.preferredHeight * CGFloat(timeTableView.dataSource.count)
   }
   
   
   
   // MARK: - Lifecycle
   override func viewDidLoad() {
      super.viewDidLoad()
//      print("Screen size: \(view.frame)")
      view.backgroundColor = .systemIndigo
      setupDataSources()
      
      setupStack()
//      setupDropDowns()
      setupCustomDropDowns()
   }
   
   private func setupDataSources() {
//      dropDowns = [songDropDown, soundDropDown, timeDropDown]
      dataSources = [songData, soundData, timeData]
      buttons = [songButton, soundButton, timeButton]
   }
   
   private func setupStack() {
      vStack.frame = CGRect(
         x: vStackX,
         y: vStackY,
         width: vStackWidth,
         height: vStackHeight)
      view.addSubview(vStack)
//      print("vStack.frame: \(vStack.frame)")
//      NSLayoutConstraint.activate([
//         vStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//         vStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//         vStack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65),
//         vStack.heightAnchor.constraint(equalToConstant: stackHeight)
//      ])
      addButtons()
   }
   
   private func addButtons() {
      songButton.delegate = self
      soundButton.delegate = self
      timeButton.delegate = self
      
      vStack.addArrangedSubview(songButton)
      vStack.addArrangedSubview(soundButton)
      vStack.addArrangedSubview(timeButton)
      
      NSLayoutConstraint.activate([
         songButton.widthAnchor.constraint(equalTo: vStack.widthAnchor),
         soundButton.widthAnchor.constraint(equalTo: vStack.widthAnchor),
         timeButton.widthAnchor.constraint(equalTo: vStack.widthAnchor)
      ])
   }
   
   private func setupCustomDropDowns() {
      let tap = UITapGestureRecognizer(target: self, action: #selector(hideSettingsView))
      transparentView.addGestureRecognizer(tap)
      transparentView.frame = view.frame
      
      view.addSubview(transparentView)
      
      
      
//      NSLayoutConstraint.activate([
//         transparentView.topAnchor.constraint(equalTo: view.topAnchor),
//         transparentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//         transparentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//         transparentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//      ])
      
      
      setupSongDrop()
//      setupSoundDrop()
//      setupTimeDrop()
      
//      setupTestView()
//      transparentView.addSubview(songTableView)
//      NSLayoutConstraint.activate([
//         songTableView.centerXAnchor.constraint(equalTo: transparentView.centerXAnchor),
//         songTableView.topAnchor.constraint(equalTo: songButton.bottomAnchor),
//         songTableView.widthAnchor.constraint(equalTo: songButton.widthAnchor),
//         songTableView.heightAnchor.constraint(equalToConstant: songTableHeight)
//      ])
      
//      transparentView.addSubview(soundTableView)
//      NSLayoutConstraint.activate([
//         soundTableView.centerXAnchor.constraint(equalTo: transparentView.centerXAnchor),
//         soundTableView.topAnchor.constraint(equalTo: soundButton.bottomAnchor),
//         soundTableView.widthAnchor.constraint(equalTo: soundButton.widthAnchor),
//         soundTableView.heightAnchor.constraint(equalToConstant: soundTableHeight)
//      ])
//
//      transparentView.addSubview(timeTableView)
//      NSLayoutConstraint.activate([
//         timeTableView.centerXAnchor.constraint(equalTo: transparentView.centerXAnchor),
//         timeTableView.topAnchor.constraint(equalTo: <#T##NSLayoutAnchor<NSLayoutYAxisAnchor>#>)
//      ])
      
   }
   
   private func setupSongDrop() {
      songTableView.frame = CGRect(
         x: vStack.frame.minX,
         y: songTableY,
         width: vStack.frame.width,
         height: songTableHeight)
      transparentView.addSubview(songTableView)
      songTableView.tableView.frame = songTableView.frame
      print(songTableView.dataSource) // 1
      
      songTableView.setNeedsDisplay()
      songTableView.tableView.setNeedsDisplay()
      songTableView.tableView.reloadData()  // 4  WHY not execute first?
      
      print(songTableView.frame) // 2
      print(songTableView.tableView.frame) // 3
      
   }
   
   private func setupSoundDrop() {
      
//      transparentView.addSubview(soundTableView)
   }
   
   private func setupTimeDrop() {
      
//      transparentView.addSubview(timeTableView)
   }
   
   private func setupTestView() {
      transparentView.addSubview(testView)
      NSLayoutConstraint.activate([
         testView.centerXAnchor.constraint(equalTo: transparentView.centerXAnchor),
         testView.centerYAnchor.constraint(equalTo: transparentView.centerYAnchor),
         testView.widthAnchor.constraint(equalTo: transparentView.widthAnchor, multiplier: 0.65),
         testView.heightAnchor.constraint(equalTo: transparentView.heightAnchor, multiplier: 0.5)
      ])
   }
   
   // MARK: - Animations
   private func showTransparentView() {
      print(#function)
      UIView.animate(withDuration: 0.5) { [weak self] in
         self?.transparentView.isHidden = false
         self?.transparentView.alpha = 1
//         self?.songTableView.isHidden = false
//         self?.songTableView.alpha = 1
      }
   }
   
   @objc private func hideSettingsView() {
      print(#function)
      UIView.animate(withDuration: 0.5) { [weak self] in
         self?.transparentView.alpha = 0
         self?.songTableView.alpha = 0
         self?.soundTableView.alpha = 0
         self?.timeTableView.alpha = 0
      } completion: { [weak self] _ in
         self?.transparentView.isHidden = true
         self?.songTableView.isHidden = true
         self?.soundTableView.isHidden = true
         self?.timeTableView.isHidden = true
      }
   }
   
   private func showSongTable() {
      
   }
   
   
//   private func setupDropDowns() {
//      for i in 0..<dropDowns.count {
//         dropDowns[i].dataSource = dataSources[i]
//         dropDowns[i].anchorView = buttons[i]
//         dropDowns[i].direction = .any
//         dropDowns[i].cellHeight = buttons[i].frame.height
//         dropDowns[i].cornerRadius = 8
//         dropDowns[i].textColor = .white
//         dropDowns[i].backgroundColor = .systemGreen
//         dropDowns[i].selectionBackgroundColor = .systemGreen
//         dropDowns[i].separatorColor = .white
//         dropDowns[i].textFont = UIFont (name: "Chalkboard SE", size: 40) ?? .systemFont(ofSize: 40)
//         dropDowns[i].bottomOffset = CGPoint(x: 0, y: (dropDowns[i].anchorView?.plainView.bounds.height)!)
//         dropDowns[i].customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) in
//            cell.optionLabel.textAlignment = .center
//         }
//      }
//   }
}

extension ViewController: ButtonDelegate {
   func buttonTapped(buttonTitle: String) {
      switch buttonTitle {
      case "Song":
         songTableView.isHidden = false
         songTableView.alpha = 1
         
      case "Sound":
         soundTableView.isHidden = false
         soundTableView.alpha = 1
         
      case "Time":
         timeTableView.isHidden = false
         timeTableView.alpha = 1
         
      default:
         break
      }
      showTransparentView()
   }
}

extension ViewController: TableViewDelegate {
   func cellTapped(fromTableView: String) {
      print("\(#function) fromTableView: \(fromTableView)")
   }
}

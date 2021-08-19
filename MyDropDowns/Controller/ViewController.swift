//
//  ViewController.swift
//  TestProgrammaticDropDowns
//
//  Created by Ryan Kanno on 8/18/21.
//

import UIKit

class ViewController: UIViewController {
   // MARK: - Initial View Properties
   private var vStack = UIStackView()
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
   private var songButton = Button(title: "Song")
   private var soundButton = Button(title: "Sound")
   private var timeButton = Button(title: "Time")
   private var stackHeight: CGFloat {
      return (Button.preferredHeight * CGFloat(3)) + (Button.preferredSpacing * CGFloat(3))
   }
   
   // MARK: - DropDown Properties
   private let transparentView = UIView()
   private let songData = ["Samurai", "Arcade", "Retro"]
   private let soundData = ["Sword", "Pop"]
   private let timeData = ["5 seconds", "10 seconds", "15 seconds"]
   private let songTableView = UITableView()
   private let soundTableView = UITableView()
   private let timeTableView = UITableView()
   
   private var songTableY: CGFloat {
      let buttonStartPoint = vStack.frame.origin.y + Button.preferredHeight + (Button.borderWidth * 2)
      let preferredHeight = Button.preferredHeight * CGFloat(songData.count)
      if buttonStartPoint + preferredHeight > view.frame.height {
         let topStartPoint = vStackY - preferredHeight
         if topStartPoint >= 0 {
            return topStartPoint
         } else {
            let midStartPoint = (view.frame.height - vStackY) / 2
            return midStartPoint
         }
      }
      return buttonStartPoint
   }
   private var soundTableY: CGFloat {
      let buttonStartPoint = vStack.frame.origin.y + (Button.preferredHeight * 2) + Button.preferredSpacing + (Button.borderWidth * 5.5)
      let preferredHeight = Button.preferredHeight * CGFloat(soundData.count)
      if buttonStartPoint + preferredHeight > view.frame.height {
         let topStartPoint = vStackY - preferredHeight
         if topStartPoint >= 0 {
            return topStartPoint
         } else {
            let midStartPoint = (view.frame.height - vStackY) / 2
            return midStartPoint
         }
      }
      return buttonStartPoint
   }
   private var timeTableY: CGFloat {
      let buttonStartPoint = vStack.frame.origin.y + (Button.preferredHeight * 3) + (Button.preferredSpacing * 2) + (Button.borderWidth * 9)
      let preferredHeight = Button.preferredHeight * CGFloat(timeData.count)
      if buttonStartPoint + preferredHeight > view.frame.height {
         let topStartPoint = vStackY - preferredHeight
         if topStartPoint >= 0 {
            return topStartPoint
         } else {
            let midStartPoint = (view.frame.height - vStackY) / 2
            return midStartPoint
         }
      }
      return buttonStartPoint
   }
   
   // MARK: - Lifecycle
   override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = .systemIndigo
      setupStack()
      setupCustomDropDowns()
   }
   
   private func setupStack() {
      vStack.initializeVerticalStackView()
      vStack.frame = CGRect(
         x: vStackX,
         y: vStackY,
         width: vStackWidth,
         height: vStackHeight)
      view.addSubview(vStack)
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
      transparentView.initializeTransparentView()
      let tap = UITapGestureRecognizer(target: self, action: #selector(hideSettingsView))
      transparentView.addGestureRecognizer(tap)
      transparentView.frame = view.frame
      view.addSubview(transparentView)
      setupSongDrop()
      setupSoundDrop()
      setupTimeDrop()
   }
   
   private func setupSongDrop() {
      songTableView.initializeDropDown()
      songTableView.delegate = self
      songTableView.dataSource = self
      view.addSubview(songTableView)
      songTableView.frame = CGRect(
         x: vStackX,
         y: songTableY,
         width: vStackWidth,
         height: Button.preferredHeight * CGFloat(songData.count))
   }
   
   private func setupSoundDrop() {
      soundTableView.initializeDropDown()
      soundTableView.delegate = self
      soundTableView.dataSource = self
      view.addSubview(soundTableView)
      soundTableView.frame = CGRect(
         x: vStackX,
         y: soundTableY,
         width: vStackWidth,
         height: Button.preferredHeight * CGFloat(soundData.count))
   }
   
   private func setupTimeDrop() {
      timeTableView.initializeDropDown()
      timeTableView.delegate = self
      timeTableView.dataSource = self
      view.addSubview(timeTableView)
      timeTableView.frame = CGRect(
         x: vStackX,
         y: timeTableY,
         width: vStackWidth,
         height: Button.preferredHeight * CGFloat(timeData.count))
   }
   
   // MARK: - Animations
   private func showTransparentView() {
      print(#function)
      UIView.animate(withDuration: 0.5) { [weak self] in
         self?.transparentView.isHidden = false
         self?.transparentView.alpha = 1
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
}

extension ViewController: ButtonDelegate {
   func buttonTapped(buttonTitle: String) {
      switch buttonTitle {
      case "Song":
         songTableView.isHidden = false
         UIView.animate(withDuration: 0.5) { [weak self] in
            self?.songTableView.alpha = 1
         }
      case "Sound":
         soundTableView.isHidden = false
         UIView.animate(withDuration: 0.5) { [weak self] in
            self?.soundTableView.alpha = 1
         }
      case "Time":
         timeTableView.isHidden = false
         UIView.animate(withDuration: 0.5) { [weak self] in
            self?.timeTableView.alpha = 1
         }
      default:
         break
      }
      showTransparentView()
   }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      switch tableView {
      case songTableView:
         return songData.count
      case soundTableView:
         return soundData.count
      case timeTableView:
         return timeData.count
      default:
         fatalError()
      }
   }
   
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return DropCell.preferredHeight
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: DropCell.id, for: indexPath) as? DropCell else {
         fatalError()
      }
      switch tableView {
      case songTableView:
         cell.configure(title: songData[indexPath.row])
      case soundTableView:
         cell.configure(title: soundData[indexPath.row])
      case timeTableView:
         cell.configure(title: timeData[indexPath.row])
      default:
         fatalError()
      }
      return cell
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      switch tableView {
      case songTableView:
         print(songData[indexPath.row])
      case soundTableView:
         print(soundData[indexPath.row])
      case timeTableView:
         print(timeData[indexPath.row])
      default:
         fatalError()
      }
      hideSettingsView()
   }
}

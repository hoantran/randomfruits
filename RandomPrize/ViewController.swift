//
//  ViewController.swift
//  RandomPrize
//
//  Created by Hoan Tran on 10/9/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  let data = [
  "apple.png",
  "banana.png",
  "blueberry.png",
  "coconut.png",
  "mango.png",
  "orange.png",
  "pineapple.png",
  "pomegranate.png",
  "strawberry.png",
  "watermelon.png"
  ]
  
  lazy var viewDataSource = ViewDataSource(array: data)
  let viewDelegate = ViewDelegate()
  
  lazy var mainView:UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 0
    layout.minimumInteritemSpacing = 0
    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    view.register(ViewCell.self, forCellWithReuseIdentifier: ViewDataSource.cellID)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.dataSource = self.viewDataSource
    view.delegate = self.viewDelegate
    view.isPagingEnabled = true
    view.showsHorizontalScrollIndicator = false
    view.backgroundColor = UIColor.white
    
    return view
  }()
  
  fileprivate func setupMainView() {
    view.addSubview(mainView)
    NSLayoutConstraint.activate([
      mainView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
      mainView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
      mainView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
      mainView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor),
      ])
  }
  
  let randomButton:UIButton = {
    let button = UIButton(frame: CGRect.zero)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = UIColor.magenta
    button.setTitle("RANDOM", for: .normal)
    button.addTarget(self, action: #selector(handleButtonClick), for: .touchUpInside)
    button.layer.cornerRadius = 7
    button.clipsToBounds = true
    button.isOpaque = false
    button.alpha = 0.5
    return button
  }()
  
  fileprivate func setupRandomButton() {
    view.addSubview(randomButton)
    NSLayoutConstraint.activate([
      randomButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
      randomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
      randomButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -40),
      randomButton.heightAnchor.constraint(equalToConstant: 60),
      ])
  }
  
  @objc func handleButtonClick(){
    let currentIndexPath = mainView.indexPathsForVisibleItems.first
    if let currentIndexPath = currentIndexPath {
      let indexPath = IndexPath(item: getRandomItem(set: self.data, currentIndex: currentIndexPath.item), section: 0)
      mainView.scrollToItem(at: indexPath, at: [.centeredVertically, .centeredHorizontally], animated: true)
    }
  }
  
  fileprivate func getRandomItem(set: [String], currentIndex: Int) -> Int {
    guard set.count > 0 else {
      return 0
    }
    let randomIndex = Int.random(in: 0..<set.count)
    if randomIndex == currentIndex {
      return getRandomItem(set:set, currentIndex: currentIndex)
    } else {
      return randomIndex
    }
  }
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    mainView.collectionViewLayout.invalidateLayout()
    
    let currentIndexPath = self.mainView.indexPathsForVisibleItems.first
    DispatchQueue.main.async {
      if let currentIndexPath = currentIndexPath {
          self.mainView.scrollToItem(at: currentIndexPath, at: [.centeredVertically, .centeredHorizontally], animated: true)
      }
      self.mainView.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.white
    setupMainView()
    setupRandomButton()
  }
}


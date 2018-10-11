//
//  ViewCell.swift
//  RandomPrize
//
//  Created by Hoan Tran on 10/10/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

import UIKit

class ViewCell: UICollectionViewCell {
  
  var imageName:String? {
    didSet {
      setupImage()
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupItems()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    self.imageName = nil
    self.imageView.image = nil
  }
  
  lazy var imageView:UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  fileprivate func setupItems(){
    addSubview(imageView)
    setupImage()
  }
  
  fileprivate func setupImage(){
    if let imageName = self.imageName, let image = UIImage(named: imageName) {
      self.imageView.image = image
      
      var width = self.bounds.width * 0.8
      var height = image.size.height * width / image.size.width

      if height > self.bounds.height * 0.8 {
        height = self.bounds.height * 0.8
        width = image.size.width * height / image.size.height 
      }
      
      self.imageView.removeConstraints(self.imageView.constraints)
      NSLayoutConstraint.activate([
        imageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
        imageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
        imageView.widthAnchor.constraint(equalToConstant: width),
        imageView.heightAnchor.constraint(equalToConstant: height)
        ])
    }
  }
  
}

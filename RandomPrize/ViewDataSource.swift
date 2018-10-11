//
//  ViewDataSource.swift
//  RandomPrize
//
//  Created by Hoan Tran on 10/9/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

import UIKit

class ViewDataSource: NSObject, UICollectionViewDataSource {
  
  public static let cellID = "Funny"
  let array:[String]
  
  init(array: [String]) {
    self.array = array
    super.init()
  }
  
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return array.count
  }
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewDataSource.cellID, for: indexPath) as! ViewCell
    cell.imageName = array[indexPath.item]
    return cell
  }
}

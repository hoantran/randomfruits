//
//  ViewDelegate.swift
//  RandomPrize
//
//  Created by Hoan Tran on 10/9/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

import UIKit

class ViewDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return collectionView.frame.size
  }
}

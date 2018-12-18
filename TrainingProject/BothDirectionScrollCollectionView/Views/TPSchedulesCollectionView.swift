//
//  TPSchedulesCollectionView.swift
//  TrainingProject
//
//  Created by Petr Kozlov on 18/12/2018.
//  Copyright © 2018 PeterYK. All rights reserved.
//

import UIKit

class TPSchedulesCollectionView: UICollectionView {
    var schedulesItems: [Int]?
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

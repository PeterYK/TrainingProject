//
//  TPBothDirectionScrollCollectionView.swift
//  TrainingProject
//
//  Created by Petr Kozlov on 03/10/2018.
//  Copyright © 2018 PeterYK. All rights reserved.
//

import Foundation
import UIKit

class TPBothDirectionScrollCollectionView: UIView {
    @IBOutlet weak var bothScrollCollectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var numberOfRows = 0
    var numberOfColumns = 0
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSelf()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
        setupSelf()
    }
    
    private func setupSelf() {
        guard self.subviews.count == 0 else { return }
        let view = UINib(nibName: "TPBothDirectionScrollCollectionView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.autoresizingMask = .flexibleWidth
        setupScrollView()
        setupBothScrollCollectionView()
        self.addSubview(view)
    }
    
    func setupScrollView() {
        let rect = scrollView.bounds
        scrollView.contentSize = CGSize.init(width: rect.width, height: 20 * 100)
        scrollView.bounces = false
    }
    
    func setupBothScrollCollectionView() {
        let collectionViewSize = scrollView.contentSize
        let collectionViewOrigin = CGPoint.init(x: 250, y: 0)
        let rect = CGRect.init(origin: collectionViewOrigin, size: collectionViewSize)
        bothScrollCollectionView.frame = rect
        bothScrollCollectionView.delegate = self as UICollectionViewDelegate
        bothScrollCollectionView.dataSource = self as UICollectionViewDataSource
        bothScrollCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        numberOfRows = 20
        numberOfColumns = 15
    }

}

extension TPBothDirectionScrollCollectionView: UICollectionViewDelegate {
    
}

extension TPBothDirectionScrollCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfRows * numberOfColumns
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        cell.backgroundColor = UIColor.gray
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.lightGray
        }
        return cell
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension TPBothDirectionScrollCollectionView: UICollectionViewDelegateFlowLayout {
    
    //высота и шырина ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize.init(width: 200, height: 100)
        return size
    }
    
    //отсуп между ячейками
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //отсуп между рядами
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
}

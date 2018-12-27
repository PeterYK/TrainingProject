//
//  PeriodsHeaderItemsCollectionView.swift
//  TrainingProject
//
//  Created by Petr Kozlov on 27/12/2018.
//  Copyright © 2018 PeterYK. All rights reserved.
//

import UIKit

protocol PeriodsHeaderItemsCollectionViewScrollDelegate: class {
    func periodsHeaderItemsScrollViewDidScroll(_ scrollView: UIScrollView)
}

class PeriodsHeaderItemsCollectionView: UICollectionView {
    var periods: [Int]?
    weak var delegateScrollView: PeriodsHeaderItemsCollectionViewScrollDelegate?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupSelf()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSelf()
    }
    
    func setSchedulesItems(items: [Int]) {
        self.periods = items
    }
    private func setupSelf() {
        self.dataSource = self
        self.delegate = self
        let nimbCellUsual = UINib(nibName: PeriodsHeaderItemCell.idCell, bundle: nil)
        self.register(nimbCellUsual, forCellWithReuseIdentifier: PeriodsHeaderItemCell.idCell)
        self.bounces = false
    }
    
    public func setPeriods(items: [Int]) {
        self.periods = items
    }
}

extension PeriodsHeaderItemsCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("did select schedule item")
    }
}

extension PeriodsHeaderItemsCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let numberOfItems = self.periods?.count else {
            return 0
        }
        return numberOfItems + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PeriodsHeaderItemCell.idCell, for: indexPath)
        cell.backgroundColor = UIColor.purple
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PeriodsHeaderItemsCollectionView: UICollectionViewDelegateFlowLayout {
    
    //высота и шырина ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize.init(width: 200, height: 48)
        return size
    }
    
    //отсуп между ячейками
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //отсуп между рядами
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}

extension PeriodsHeaderItemsCollectionView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.delegateScrollView?.periodsHeaderItemsScrollViewDidScroll(scrollView)
    }
}

//
//  TPSchedulesCollectionView.swift
//  TrainingProject
//
//  Created by Petr Kozlov on 18/12/2018.
//  Copyright © 2018 PeterYK. All rights reserved.
//

import UIKit

protocol TPSchedulesCollectionViewScrollDelegate: class {
    func schedulesScrollViewDidScroll(_ scrollView: UIScrollView)
}

class TPSchedulesCollectionView: UICollectionView {
    var schedulesItems: [Int]?
    weak var delegateScrollView: TPSchedulesCollectionViewScrollDelegate?

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupSelf()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSelf()
    }
    
    func setSchedulesItems(items: [Int]) {
        self.schedulesItems = items
    }
    private func setupSelf() {
        self.dataSource = self
        self.delegate = self
        let nimbCellUsual = UINib(nibName: TPJournalScheduleIPADCell.idCell, bundle: nil)
        self.register(nimbCellUsual, forCellWithReuseIdentifier: TPJournalScheduleIPADCell.idCell)
        self.bounces = false
    }
}

extension TPSchedulesCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("did select schedule item")
    }
}

extension TPSchedulesCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let numberOfItems = self.schedulesItems?.count else {
            return 0
        }
            return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TPJournalScheduleIPADCell.idCell, for: indexPath)
            cell.backgroundColor = UIColor.purple
            return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension TPSchedulesCollectionView: UICollectionViewDelegateFlowLayout {
    
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

extension TPSchedulesCollectionView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            self.delegateScrollView?.schedulesScrollViewDidScroll(scrollView)
    }
}

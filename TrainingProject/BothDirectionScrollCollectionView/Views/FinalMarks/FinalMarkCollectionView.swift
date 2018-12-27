//
//  FinalMarkCollectionView.swift
//  TrainingProject
//
//  Created by Petr Kozlov on 27/12/2018.
//  Copyright © 2018 PeterYK. All rights reserved.
//

import UIKit

protocol FinalMarkCollectionViewScrollDelegate: class {
    func finalMarksScrollViewDidScroll(_ scrollView: UIScrollView)
}

class FinalMarkCollectionView: UICollectionView {
    var model: JournalConfiguration?
    weak var delegateScrollView: FinalMarkCollectionViewScrollDelegate?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupSelf()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSelf()
    }
    
    public func setModel(aModel: JournalConfiguration) {
        self.model = aModel
        self.reloadData()
    }
    
    private func setupSelf() {
        self.dataSource = self
        self.delegate = self
        let nibCell1st = UINib(nibName: TP2ndStypeCell.idCell(), bundle: nil)
        self.register(nibCell1st, forCellWithReuseIdentifier: TP2ndStypeCell.idCell())
        self.bounces = false
    }
}

extension FinalMarkCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("did select finalMark cell")
    }
}

extension FinalMarkCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let numberOfStudents = self.model?.students.count else {
            return 0
        }
        guard let numberOfPeriods = self.model?.periods.count else {
            return 0
        }
        return numberOfStudents * (numberOfPeriods + 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TP2ndStypeCell.idCell(), for: indexPath)
        cell.backgroundColor = UIColor.purple
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FinalMarkCollectionView: UICollectionViewDelegateFlowLayout {
    
    //высота и шырина ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize.init(width: 200, height: 98)
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

extension FinalMarkCollectionView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.delegateScrollView?.finalMarksScrollViewDidScroll(scrollView)
    }
}

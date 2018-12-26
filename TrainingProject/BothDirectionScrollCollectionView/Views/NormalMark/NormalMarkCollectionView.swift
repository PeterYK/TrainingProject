//
//  NormalMarkCollectionView.swift
//  TrainingProject
//
//  Created by Petr Kozlov on 26/12/2018.
//  Copyright © 2018 PeterYK. All rights reserved.
//

import UIKit

protocol NormalMarkCollectionViewScrollDelegate: class {
    func normalMarksScrollViewDidScroll(_ scrollView: UIScrollView)
}

class NormalMarkCollectionView: UICollectionView {
    var model: JournalConfiguration?
    weak var delegateScrollView: NormalMarkCollectionViewScrollDelegate?
    
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
        let nibCell1st = UINib(nibName: TP1stStyleCell.idCell(), bundle: nil)
        self.register(nibCell1st, forCellWithReuseIdentifier: TP1stStyleCell.idCell())
        self.bounces = false
    }
}

extension NormalMarkCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("did select schedule item")
    }
}

extension NormalMarkCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let numberOfStudents = self.model?.students.count else {
            return 0
        }
        guard let numberOfSchedules = self.model?.schedulesItems.count else {
            return 0
        }
        return numberOfStudents * numberOfSchedules
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TP1stStyleCell.idCell(), for: indexPath)
        cell.backgroundColor = UIColor.purple
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension NormalMarkCollectionView: UICollectionViewDelegateFlowLayout {
    
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
        return 2
    }
}

extension NormalMarkCollectionView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.delegateScrollView?.normalMarksScrollViewDidScroll(scrollView)
    }
}

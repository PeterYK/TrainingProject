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
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var months: UICollectionView!
    @IBOutlet weak var schedules: UICollectionView!
    
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
        numberOfRows = 20
        numberOfColumns = 15
        setupScrollView()
        setupTableView()
        setupMonth()
        setupSchedules()
        setupBothScrollCollectionView()
        self.addSubview(view)
    }
    
    func setupScrollView() {
        let rect = scrollView.bounds
        scrollView.contentSize = CGSize.init(width: rect.width, height: CGFloat(numberOfRows * 100))
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
        bothScrollCollectionView.bounces = false
    }
    
    func setupMonth() {
        let collectionViewSize = CGSize.init(width: 750, height: 40)
        let collectionViewOrigin = CGPoint.init(x: 260, y: 10)
        let rect = CGRect.init(origin: collectionViewOrigin, size: collectionViewSize)
        months.frame = rect
        months.delegate = self as UICollectionViewDelegate
        months.dataSource = self as UICollectionViewDataSource
        months.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "monthCell")
        months.bounces = false
    }
    
    func setupSchedules() {
        let collectionViewSize = CGSize.init(width: 750, height: 40)
        let collectionViewOrigin = CGPoint.init(x: 260, y: 60)
        let rect = CGRect.init(origin: collectionViewOrigin, size: collectionViewSize)
        schedules.frame = rect
        schedules.delegate = self as UICollectionViewDelegate
        schedules.dataSource = self as UICollectionViewDataSource
        schedules.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "schedulCell")
        schedules.bounces = false
    }

    func setupTableView(){
        tableView.delegate = self as UITableViewDelegate
        tableView.dataSource = self as UITableViewDataSource
        let rect = CGRect.init(x: 0, y: 0, width: 250, height: numberOfRows * 100)
        tableView.frame = rect
    }
}

extension TPBothDirectionScrollCollectionView: UICollectionViewDelegate {
    
}

extension TPBothDirectionScrollCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == bothScrollCollectionView {
            return numberOfRows * numberOfColumns
        }  else if collectionView == months {
            return 12
        } else {
            return numberOfColumns
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == bothScrollCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            
            cell.backgroundColor = UIColor.gray
            if indexPath.row % 2 == 0 {
                cell.backgroundColor = UIColor.lightGray
            }
            return cell
        } else if collectionView == months {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "monthCell", for: indexPath)
            
            cell.backgroundColor = UIColor.green
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "schedulCell", for: indexPath)
            
            cell.backgroundColor = UIColor.purple
            return cell
        }
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension TPBothDirectionScrollCollectionView: UICollectionViewDelegateFlowLayout {
    
    //высота и шырина ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size: CGSize
        if collectionView == bothScrollCollectionView {
            size = CGSize.init(width: 200, height: 100)
        } else if collectionView == schedules {
            size = CGSize.init(width: 200, height: 25)
        } else {
            size = CGSize.init(width: 300, height: 25)
        }
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

extension TPBothDirectionScrollCollectionView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "tableCell")
        cell.textLabel?.text = "\(indexPath.row + 1)"
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.lightGray
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

extension TPBothDirectionScrollCollectionView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == bothScrollCollectionView {
            schedules.contentOffset = bothScrollCollectionView.contentOffset
        } else {
            bothScrollCollectionView.contentOffset = schedules.contentOffset
        }
    }
}

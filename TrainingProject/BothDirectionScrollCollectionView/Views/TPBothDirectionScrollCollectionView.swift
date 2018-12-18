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
    @IBOutlet weak var schedules: TPSchedulesCollectionView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentHeight: NSLayoutConstraint!

    weak var journalCelldelegate:TPJournalCellDelegate?
    weak var scheduleCelldelegate:TPJournalScheduleIPADCellDelegate?

    var schedulesItems:[Int]?
    var numberOfRows = 0
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
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        schedulesItems = [12, 243, 5532 ,234234, 453, 23, 867, 53, 7856, 23, 45, 67, 423 ,23, 8, 45, 243, 24353, 23, 13, 978, 486 ,3543 ,918 ,546 ,456]
        numberOfRows = 20
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
//        let newFrame = CGRect.init(origin: .zero, size: scrollView.contentSize)
//        contentView.frame = newFrame
        contentHeight.constant = scrollView.contentSize.height
    }
    
    func setupBothScrollCollectionView() {
        let collectionViewSize = scrollView.contentSize
        let collectionViewOrigin = CGPoint.init(x: 250, y: 0)
        let rect = CGRect.init(origin: collectionViewOrigin, size: collectionViewSize)
        bothScrollCollectionView.frame = rect
        bothScrollCollectionView.delegate = self as UICollectionViewDelegate
        bothScrollCollectionView.dataSource = self as UICollectionViewDataSource
        let nibCell2nd = UINib(nibName: "TP2ndStypeCell", bundle: nil)
        bothScrollCollectionView.register(nibCell2nd, forCellWithReuseIdentifier: TP2ndStypeCell.idCell())
        let nibCell1st = UINib(nibName: "TP1stStyleCell", bundle: nil)
        bothScrollCollectionView.register(nibCell1st, forCellWithReuseIdentifier: TP1stStyleCell.idCell())
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
        schedules.delegate = self
        schedules.dataSource = self
        let nimbCellUsual = UINib(nibName: TPJournalScheduleIPADCell.idCell, bundle: nil)
        schedules.register(nimbCellUsual, forCellWithReuseIdentifier: TPJournalScheduleIPADCell.idCell)
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == bothScrollCollectionView {
            if let cell = collectionView.cellForItem(at: indexPath) as? TP1stStyleCell {
                cell.backgroundColor = UIColor.yellow
                if self.journalCelldelegate != nil {
                    self.journalCelldelegate?.didTapJournalCell(cell: cell)
                }
            } else if let cell = collectionView.cellForItem(at: indexPath) as? TPJournalScheduleIPADCell{
                if self.scheduleCelldelegate != nil {
                    self.scheduleCelldelegate?.didTapJournalScheduleCell(cell: cell)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == bothScrollCollectionView {
            if let cell = collectionView.cellForItem(at: indexPath) {
                cell.backgroundColor = UIColor.lightGray
            }
        }
    }
        
}

extension TPBothDirectionScrollCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let items = self.schedulesItems else {
            return 0
        }
        if collectionView == bothScrollCollectionView {
            return numberOfRows * items.count
        }  else if collectionView == months {
            return items.count / 3
        } else {
            return items.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == bothScrollCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TP1stStyleCell.idCell(), for: indexPath)
            cell.backgroundColor = UIColor.lightGray
            return cell
        } else if collectionView == months {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "monthCell", for: indexPath)
            
            cell.backgroundColor = UIColor.green
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TPJournalScheduleIPADCell.idCell, for: indexPath)
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
            
            size = CGSize.init(width: (200 + 1) * 3, height: 25)
        }
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

extension TPBothDirectionScrollCollectionView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "tableCell")
        cell.textLabel?.text = "\(indexPath.row + 1). Имион Фамилиевич"
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.lightGray
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}

extension TPBothDirectionScrollCollectionView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == bothScrollCollectionView {
            schedules.contentOffset = bothScrollCollectionView.contentOffset
            months.contentOffset = bothScrollCollectionView.contentOffset
        } else if scrollView == schedules {
            bothScrollCollectionView.contentOffset = schedules.contentOffset
            months.contentOffset = schedules.contentOffset
        } else {
            bothScrollCollectionView.contentOffset = months.contentOffset
            schedules.contentOffset = months.contentOffset

        }
    }
}

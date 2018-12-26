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
    @IBOutlet weak var bothScrollCollectionView: NormalMarkCollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var months: UICollectionView!
    @IBOutlet weak var schedules: TPSchedulesCollectionView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentHeight: NSLayoutConstraint!

    weak var journalCelldelegate:TPJournalCellDelegate?
    weak var scheduleCelldelegate:TPJournalScheduleIPADCellDelegate?
    
    var config = JournalConfiguration()
//    var schedulesItems:[Int]?
//    var numberOfRows = 0
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
        config.setupSelf()
        setupScrollView()
        setupTableView()
        setupMonth()
        setupSchedules()
        setupBothScrollCollectionView()
        self.addSubview(view)
    }
    
    func setupScrollView() {
        let rect = scrollView.bounds
        scrollView.contentSize = CGSize.init(width: rect.width, height: CGFloat(config.students.count * 100))
        scrollView.bounces = false
        contentHeight.constant = scrollView.contentSize.height
    }
    
    func setupBothScrollCollectionView() {
        let collectionViewSize = scrollView.contentSize
        let collectionViewOrigin = CGPoint.init(x: 250, y: 0)
        let rect = CGRect.init(origin: collectionViewOrigin, size: collectionViewSize)
        self.bothScrollCollectionView.frame = rect
        self.bothScrollCollectionView.delegateScrollView = self
        self.bothScrollCollectionView.model = self.config
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
        self.schedules.frame = rect
        self.schedules.delegateScrollView = self
        self.schedules.setSchedulesItems(items: self.config.schedulesItems)
    }

    func setupTableView(){
        tableView.delegate = self as UITableViewDelegate
        tableView.dataSource = self as UITableViewDataSource
        let rect = CGRect.init(x: 0, y: 0, width: 250, height: config.students.count * 100)
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
                    print("\(indexPath.row / self.config.students.count)")
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
        if collectionView == bothScrollCollectionView {
            return config.students.count * self.config.schedulesItems.count
        }  else if collectionView == months {
            return self.config.schedulesItems.count / 3
        } else {
            return self.config.schedulesItems.count
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
        size = CGSize.init(width: (200 + 1) * 3, height: 25)
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
        return config.students.count
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
            schedules.contentOffset = scrollView.contentOffset
            months.contentOffset = scrollView.contentOffset
        } else {
            bothScrollCollectionView.contentOffset = scrollView.contentOffset
            schedules.contentOffset = scrollView.contentOffset

        }
    }
}

extension TPBothDirectionScrollCollectionView: TPSchedulesCollectionViewScrollDelegate {
    func schedulesScrollViewDidScroll(_ scrollView: UIScrollView) {
        bothScrollCollectionView.contentOffset = scrollView.contentOffset
        months.contentOffset = scrollView.contentOffset
    }

}

extension TPBothDirectionScrollCollectionView: NormalMarkCollectionViewScrollDelegate {
    func normalMarksScrollViewDidScroll(_ scrollView: UIScrollView) {
        schedules.contentOffset = scrollView.contentOffset
        months.contentOffset = scrollView.contentOffset
    }
    
}

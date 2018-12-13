//
//  TPBothDirectionScrollCollectionViewContorller.swift
//  TrainingProject
//
//  Created by Petr Kozlov on 03/10/2018.
//  Copyright © 2018 PeterYK. All rights reserved.
//

import UIKit

class TPBothDirectionScrollCollectionViewContorller: UIViewController {
    var mainView: TPBothDirectionScrollCollectionView!

    override func loadView() {
        super.loadView()
        let rect = CGRect.init(origin: CGPoint.zero, size: self.view.frame.size)
        mainView = TPBothDirectionScrollCollectionView.init(frame: rect)
        self.setupMainView()
        self.view.addSubview(mainView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //конфигурация журнала
        self.view.backgroundColor = UIColor.white

    }
    private func setupMainView(){
        mainView.journalCelldelegate = self
        mainView.scheduleCelldelegate = self
    }
}

extension TPBothDirectionScrollCollectionViewContorller: TPJournalCellDelegate {
    func didTapJournalCell(cell: TPJournalCell) {
        print("cell did tap")
    }
}

extension TPBothDirectionScrollCollectionViewContorller: TPJournalScheduleIPADCellDelegate {
    func didTapJournalScheduleCell(cell: TPJournalScheduleIPADCell) {
        print("schedule did tap")
    }
}

//
//  TPJournalScheduleIPADCell.swift
//  TrainingProject
//
//  Created by Petr Kozlov on 13/12/2018.
//  Copyright © 2018 PeterYK. All rights reserved.
//

import Foundation
import UIKit

class TPJournalScheduleIPADCell: UICollectionViewCell {
    var scheduleId: Int
    @IBOutlet weak var scheduleTitle: UILabel!
    
    init(scheduleId: Int) {
        super.awakeFromNib()
        self.scheduleId = scheduleId
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        setupSelf()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

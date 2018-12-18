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
    var scheduleId: Int?
    @IBOutlet weak var scheduleTitle: UILabel!
    class var idCell: String {
        return "TPJournalScheduleIPADCell"
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupSelf()
    }
    
    public func setSchedulId(scheduleId: Int) {
        self.scheduleId = scheduleId
        self.updateScheduleTitle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupSelf() {
        self.scheduleTitle.text = "Empty"
    }
    private func updateScheduleTitle(){
        guard let id = self.scheduleId else {
            self.scheduleTitle.text = "Empty"
            return
        }
        self.scheduleTitle.text = "\(id)"
    }

}

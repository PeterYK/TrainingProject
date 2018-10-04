//
//  TP1stStyleCell.swift
//  TrainingProject
//
//  Created by Petr Kozlov on 04/10/2018.
//  Copyright © 2018 PeterYK. All rights reserved.
//

import Foundation
import UIKit

class TP1stStyleCell: TPJournalCell {
    
    class func idCell() -> String {
        return "TP1stStyleCell"
    }
    // MARK: override
    override func awakeFromNib() {
        super.awakeFromNib()
        setupSelf()
    }
    
    func setupSelf() {
        isFinalMarkCell = false
    }
}

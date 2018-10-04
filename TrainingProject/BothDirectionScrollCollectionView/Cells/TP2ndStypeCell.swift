//
//  TP2ndStypeCell.swift
//  TrainingProject
//
//  Created by Petr Kozlov on 04/10/2018.
//  Copyright © 2018 PeterYK. All rights reserved.
//

import Foundation
import UIKit

class TP2ndStypeCell: TPJournalCell {
    
    class func idCell() -> String {
        return "TP2ndStypeCell"
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupSelf()
    }
    
    func setupSelf() {
        isFinalMarkCell = true
    }
}

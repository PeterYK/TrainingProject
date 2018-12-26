//
//  JournalConfiguration.swift
//  TrainingProject
//
//  Created by Petr Kozlov on 26/12/2018.
//  Copyright © 2018 PeterYK. All rights reserved.
//

import Foundation

class JournalConfiguration {
    var students = [String]()
    var schedulesItems = [Int]()
    
    func setupSelf(){
        schedulesItems = [12, 243, 5532 ,234234, 453, 23, 867, 53, 7856, 23, 45, 67, 423 ,23, 8, 45, 243, 24353, 23, 13, 978, 486 ,3543 ,918 ,546 ,456]
        students = ["Вася","Коля","Дима","Саша","Вова","Леша","Петя","Паша","Кеша","Гоша","Гена","Юра","Витал"]
    }
}

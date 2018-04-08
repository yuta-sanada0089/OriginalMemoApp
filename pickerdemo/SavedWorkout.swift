//
//  SavedWorkout.swift
//  pickerdemo
//
//  Created by 真田雄太 on 2018/04/06.
//  Copyright © 2018年 yutaSanada. All rights reserved.
//

import Foundation
import RealmSwift

class SavedWorkout: Object {
    @objc dynamic var id = 0
    @objc dynamic var eventText: String? = nil
    @objc dynamic var weight: String? = nil
    @objc dynamic var repLabel: String? = nil
    @objc dynamic var setLabel: String? = nil
    @objc dynamic var createdAt: String? = ""
    
    convenience init(eventText: String?, weight: String?, repLabel: String?, setLabel: String?){
        self.init()
        self.eventText = eventText
        self.weight = weight
        self.repLabel = repLabel
        self.setLabel = setLabel
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}

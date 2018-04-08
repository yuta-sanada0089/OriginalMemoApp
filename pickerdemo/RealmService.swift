//
//  RealmService.swift
//  pickerdemo
//
//  Created by 真田雄太 on 2018/03/29.
//  Copyright © 2018年 yutaSanada. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService {
    
    private init() {}
    static let shared = RealmService()
    
    var realm = try! Realm()
    
    
    func create<T: Object>(_ object: T){
        do{
            try realm.write {
                realm.add(object)
            }
        } catch {
            post(error)
        }
    }
    
    func update<T: Object>(_ object: T, dictionary: [String: Any?]){
        do{
            try realm.write {
                for (key, value) in dictionary {
                    object.setValue(value, forKey: key)
                }
            }
        } catch {
            post(error)
        }
    }
    
    func delete<T: Object>(_ object: T){
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch  {
            post(error)
        }
    }
    
    func post(_ error: Error){
        NotificationCenter.default.post(name: NSNotification.Name("Realmerror"), object: error)
    }
    
    func observeRealmErrors(in vc: UIViewController, complition: @escaping (Error?) -> Void){
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Realmerror"),
                                               object: nil,
                                               queue: nil) {(notification)  in
                                                complition(notification.object as? Error)
        }
    }
    
    func stopObservingErrors(in vc: UIViewController){
        NotificationCenter.default.removeObserver(vc, name: NSNotification.Name("Realmerror"), object: nil)
    }
}

//
//  ViewController.swift
//  pickerdemo
//
//  Created by 真田雄太 on 2018/03/25.
//  Copyright © 2018年 yutaSanada. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {
    
    @IBOutlet weak var repLabel: UILabel!
    @IBOutlet weak var setLabel: UILabel!
    
    
    @IBOutlet weak var eventText: UITextField!
    @IBOutlet weak var weight: UITextField!
    
    @IBOutlet weak var repsetPicker: UIPickerView!
    let repArray = Array<Int>(1...100)
    let setArray = Array<Int>(1...30)
   
    
    func configure(with savedWorkout: SavedWorkout) {
        eventText.text = savedWorkout.eventText
        weight.text = savedWorkout.weight
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = RealmService.shared.realm
        print(Realm.Configuration.defaultConfiguration.fileURL!)

        //// UIPickerViewを生成.
        repsetPicker.delegate = self
        repsetPicker.dataSource = self
        
        //初期値を設定
        repsetPicker.selectRow(0, inComponent: 0, animated: true)
        repsetPicker.selectRow(0, inComponent: 1, animated: true)
        
        repLabel.text = "rep数"
        setLabel.text = "set数"
        self.weight.keyboardType = UIKeyboardType.decimalPad
        self.eventText.keyboardType = UIKeyboardType.default
        
        self.weight.delegate = self
        
    }
    
    
    // UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    // UIPickerViewの行数、要素の全数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return repArray.count
        case 1:
            return setArray.count
        default:
            return 0
        }
    }

    // UIPickerViewに表示する配列
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return String(repArray[row]) + "rep"
        case 1:
            return String(setArray[row]) + "set"
        default:
            return "選択してください"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            repLabel.text = String(repArray[row]) + "rep"
        case 1:
            setLabel.text = String(setArray[row]) + "set"
        default:
            return
        }
    }
    
    func getNowClockString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let now = Date()
        return formatter.string(from: now)
    }
    
    
    
    
    @IBAction func add(_ sender: Any) {
        
        let realm = try! Realm()
        var maxId: Int { return try! Realm().objects(SavedWorkout.self).sorted(byKeyPath: "id").last?.id ?? 0 }
        let memo = SavedWorkout()
        memo.eventText = eventText.text
        memo.weight = weight.text
        memo.repLabel = repLabel.text
        memo.setLabel = setLabel.text
        memo.id = maxId + 1
        memo.createdAt = getNowClockString()
        
        try! realm.write {
            realm.add(memo, update: true)
        }
        eventText.endEditing(true)
        weight.endEditing(true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    



}


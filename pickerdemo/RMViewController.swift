//
//  RMViewController.swift
//  pickerdemo
//
//  Created by 真田雄太 on 2018/04/01.
//  Copyright © 2018年 yutaSanada. All rights reserved.
//
//最大挙上重量＝重量×回数÷40＋重量
//
//var max = textfield.text * reptext.text / 40 + textfield.text
//powerUp = max * 0.95 ~ max * 0.85
//bulkUp = max * 0.8 ~ max * 0.6
//staminaUp = max * 0.55
//print("あなたの最大挙上重量はおよそ(max)㎏です")
//
//筋力強化：1〜4RM　sterengthup
//筋肥大：5〜14RM bulkup
//筋持久力アップ：15RM〜 endurance
//
//1RMの95%　　〃
//1RMの90%　　瞬発力
//1RMの85%　　筋力強化
//1RMの80%　　筋肥大～筋力強化
//1RMの75%　　筋肥大～筋力強化
//1RMの70%　　筋肥大
//1RMの65%　　筋肥大
//1RMの60%　　筋肥大
//1RMの55%　　筋持久力

import UIKit

class RMViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var usingWeight: UITextField!
    @IBOutlet weak var repCount: UITextField!
    
    
    @IBOutlet weak var maxWeight: UILabel!
    @IBOutlet weak var powerUp: UILabel!
    @IBOutlet weak var bulkUp: UILabel!
    @IBOutlet weak var staminaUp: UILabel!
    @IBOutlet weak var maxW: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.usingWeight.keyboardType = UIKeyboardType.decimalPad
        self.repCount.keyboardType = UIKeyboardType.numberPad
        
        maxWeight.text = ""
        powerUp.text = ""
        bulkUp.text = ""
        staminaUp.text = ""
        maxW.text = ""
        
        self.repCount.delegate = self
    }
    
    

    @IBAction func culculate(_ sender: UIButton) {
        //最大重量を計算する
        var useWeight: Double! = Double(usingWeight.text!)
        if(useWeight == nil){
            usingWeight.text = "0"
            useWeight = 0
        }
        var useRep: Double! = Double(repCount.text!)
        if(useRep == nil){
            repCount.text = "0"
            useRep = 0
        }
        let maxWeight: Double! = useWeight * useRep / 40 + useWeight
        maxW.text = String("\(maxWeight!)kg")
        //筋力アップの重量を計算する
        let powerUpWeight =  Double(maxWeight * 0.95)
        let powerUpWeight2 =  Double(maxWeight * 0.85)
        let poweUpResult = String("\(powerUpWeight)kg ~ \(powerUpWeight2)kg")
        powerUp.text = String(poweUpResult)
        
        //筋肥大の重量を計算する
        let bulkUpWeight = Double(maxWeight * 0.8)
        let bulkUpWeight2 = Double(maxWeight * 0.65)
        bulkUp.text = String("\(bulkUpWeight)kg ~ \(bulkUpWeight2)kg")
        //筋持久力アップの重量を計算する
        let staminaUpWeight = Double(maxWeight * 0.6)
        staminaUp.text = String("\(staminaUpWeight)kg")
        
        usingWeight.endEditing(true)
        repCount.endEditing(true)
        
    }
    @IBAction func clearValue(_ sender: Any) {
        usingWeight.text = ""
        repCount.text = ""
        maxWeight.text = ""
        powerUp.text = ""
        bulkUp.text = ""
        staminaUp.text = ""
        maxW.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

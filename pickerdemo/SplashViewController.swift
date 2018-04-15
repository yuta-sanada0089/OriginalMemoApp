//
//  SplashViewController.swift
//  pickerdemo
//
//  Created by 真田雄太 on 2018/04/13.
//  Copyright © 2018年 yutaSanada. All rights reserved.
//

import UIKit
import LTMorphingLabel

class SplashViewController: UIViewController {

    @IBOutlet weak var LaunchLB: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let label = LTMorphingLabel()
        label.text = LaunchLB.text
        label.morphingEffect = .anvil
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  CalendarViewController.swift
//  pickerdemo
//
//  Created by 真田雄太 on 2018/03/29.
//  Copyright © 2018年 yutaSanada. All rights reserved.
//

import UIKit
import JBDatePicker
import RealmSwift

class CalendarViewController: UIViewController, JBDatePickerViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var WorkoutTable: UITableView!
    var date: String!
    var createdAt: NSData!
    var workoutItem: Results<SavedWorkout>!
    var sortedWorkoutItem: Results<SavedWorkout>!
    
    lazy var dateFormatter: DateFormatter = {
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    @IBOutlet weak var dataPicker: JBDatePickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataPicker.delegate = self
        
        
        // セルの高さの見積もり値
        WorkoutTable.estimatedRowHeight = 80
        // セルの制約を基に計算された高さを代入
        WorkoutTable.rowHeight = UITableViewAutomaticDimension
        WorkoutTable.delegate = self
        WorkoutTable.dataSource = self
        
        // テーブルを表示
        view.addSubview(WorkoutTable)
        
        do{
            let realm = try! Realm()
            workoutItem = realm.objects(SavedWorkout.self)
            print(workoutItem)
//            workoutTable.reloadData()
        }catch{
            
        }
        WorkoutTable.reloadData()
    }
    
    
    func didSelectDay(_ dayView: JBDatePickerDayView) {
        print("date selected: \(dateFormatter.string(from: dayView.date!))")
        date = dateFormatter.string(from: dayView.date!)
        let realm = try! Realm()
        self.sortedWorkoutItem = realm.objects(SavedWorkout.self).filter("createdAt == '\(date)'")
        print(sortedWorkoutItem)
        workoutItem = sortedWorkoutItem
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dataPicker.updateLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var colorForWeekDaysViewBackground: UIColor { return UIColor.yellow }

    var colorForWeekDaysViewText: UIColor { return UIColor.black }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        WorkoutTable.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (sortedWorkoutItem != nil) {
            return sortedWorkoutItem.count
        }
        return workoutItem.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomTableViewCell
        let object = workoutItem[indexPath.row]
        
        cell.eventTitle?.text = object.eventText!
        cell.weightLabel?.text? = object.weight! + "kg"
        cell.repsLabel?.text? = object.repLabel!
        cell.setsLabel?.text? = object.setLabel!
        
        
        cell.eventTitle!.numberOfLines = 0
        cell.eventTitle?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.weightLabel?.numberOfLines = 0
        cell.weightLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.repsLabel?.numberOfLines = 0
        cell.repsLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.setsLabel?.numberOfLines = 0
        cell.setsLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
}

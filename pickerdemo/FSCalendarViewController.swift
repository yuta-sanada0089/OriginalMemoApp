//
//  FSCalendarViewController.swift
//  pickerdemo
//
//  Created by 真田雄太 on 2018/04/06.
//  Copyright © 2018年 yutaSanada. All rights reserved.
//

import UIKit
import FSCalendar
import CalculateCalendarLogic
import RealmSwift

class FSCalendarViewController: UIViewController,FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance,UITableViewDataSource,UITableViewDelegate {
   
    
    @IBOutlet weak var calendar: FSCalendar?

    @IBOutlet weak var TableView: UITableView!
    
    var date: String!
    var createdAt: NSData!
    var workoutItem: Results<SavedWorkout>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.calendar?.dataSource = self
        self.calendar?.delegate = self
        
        TableView.delegate = self
        TableView.dataSource = self
        
        view.addSubview(TableView)
        TableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate let gregorian: Calendar = Calendar(identifier: .gregorian)
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    // 祝日判定を行い結果を返すメソッド(True:祝日)
    func judgeHoliday(_ date : Date) -> Bool {
        //祝日判定用のカレンダークラスのインスタンス
        let tmpCalendar = Calendar(identifier: .gregorian)
        
        // 祝日判定を行う日にちの年、月、日を取得
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        
        // CalculateCalendarLogic()：祝日判定のインスタンスの生成
        let holiday = CalculateCalendarLogic()
        
        return holiday.judgeJapaneseHoliday(year: year, month: month, day: day)
    }
    // date型 -> 年月日をIntで取得
    func getDay(_ date:Date) -> (Int,Int,Int){
        let tmpCalendar = Calendar(identifier: .gregorian)
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        return (year,month,day)
    }
    
    //曜日判定(日曜日:1 〜 土曜日:7)
    func getWeekIdx(_ date: Date) -> Int{
        let tmpCalendar = Calendar(identifier: .gregorian)
        return tmpCalendar.component(.weekday, from: date)
    }
    
    // 土日や祝日の日の文字色を変える
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        //祝日判定をする（祝日は赤色で表示する）
        if self.judgeHoliday(date){
            return UIColor.red
        }
        
        //土日の判定を行う（土曜日は青色、日曜日は赤色で表示する）
        let weekday = self.getWeekIdx(date)
        if weekday == 1 {   //日曜日
            return UIColor.red
        }
        else if weekday == 7 {  //土曜日
            return UIColor.blue
        }
        
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition){
        
        let selectDay = calendar.selectedDate
        let date = dateFormatter.string(from: selectDay!)
        print(date)
//        let selectDay = getDay(date)
//        print(selectDay)
        
        DispatchQueue(label: "background").async {
            let realm = try! Realm()
            //            var savedItem = [self.workoutItem]
            print(realm.objects(SavedWorkout.self))
            let sortedworkoutItem = realm.objects(SavedWorkout.self).filter("createdAt == '\(self.date!)'")
            print(sortedworkoutItem)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(workoutItem != nil){
            return workoutItem.count
        }
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomTableViewCell
        let object = workoutItem[indexPath.row]
        
        cell.event?.text = object.eventText!
        cell.weight?.text? = object.weight! + "kg"
        cell.reps?.text? = object.repLabel!
        cell.sets?.text? = object.setLabel!
        
        
        cell.event!.numberOfLines = 0
        cell.event?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.weight?.numberOfLines = 0
        cell.weight?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.reps?.numberOfLines = 0
        cell.reps?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.sets?.numberOfLines = 0
        cell.sets?.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        return cell
    }
}

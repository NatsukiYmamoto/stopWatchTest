//
//  ViewController.swift
//  StopwatchByYoutube
//
//  Created by 山本 夏紀 on 2021/02/10.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var timerLabel: UILabel!
    @IBOutlet private weak var startStopButton: UIButton!
    @IBOutlet private weak var resetButton: UIButton!
    //Timer
    var timer:Timer = Timer()
    var count:Int = 0
    var timerCounting:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        startStopButton.setTitleColor(UIColor.green, for: .normal)
        timerLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 60, weight: .medium)
        print("viewDidLoad")
    }
    //StartStopButtonを押したとき
    @IBAction func startStopTapped(_ sender: Any) {
        print("pressButton")
        if(timerCounting) {
            timerCounting = false
            timer.invalidate()
            startStopButton.setTitle("START", for: .normal)
            startStopButton.setTitleColor(UIColor.green, for: .normal)
            print("false")
        } else {
            timerCounting = true
            startStopButton.setTitle("STOP", for: .normal)
            startStopButton.setTitleColor(UIColor.red, for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
            print("true")
        }
    }
    
    @objc func timerCounter() -> Void {
        count = count + 1
        print(count)
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        timerLabel.text = timeString
    }
    
    @IBAction func resetTapped(_ sender: Any) {
        let alert = UIAlertController(title: "ほんまに?", message: "リセットして後悔せん？", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "おキャンセル", style: .cancel, handler: { (_) in
            //do nothing
        }))
        
        alert.addAction(UIAlertAction(title: "後悔せん", style: .default, handler: { (_) in
            self.count = 0
            self.timer.invalidate()
            self.timerLabel.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
            self.startStopButton.setTitle("START", for: .normal)
            self.startStopButton.setTitleColor(UIColor.green, for: .normal)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
        //return ((seconds / 3600), ((seconds % 3600) / 60), ((seconds % 3600) % 60))
        //0.6秒で1秒になる
        //return ((seconds / 3600), ((seconds % 3600) / 60), seconds)
        //0.1秒が60で繰り上がらなくなる,0.6秒で1秒になるは変わらない
        //return ((seconds / 3600), ((seconds % 3600) / 60), (seconds % 100))
        return ((seconds / 6000), ((seconds / 100) % 60), (seconds % 100))
    }
    
    func makeTimeString(hours: Int, minutes: Int, seconds: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " . "
        timeString += String(format: "%02d", seconds)
        return timeString
    }
}


//  ViewController.swift
//  Calm me down
//
//  Created by Olga Garus on 09.01.2024.
//


import UIKit

class SettingsViewController: UIViewController {
    
    var timerSet = TimerSet()
    var timer = 0
    var musicPlay = "Тишина"
    var signalPlay = "Гонг"
    let backgroundMusic = ["Музыка", "Белый Шум", "Дождь", "Тишина", "Дыхание"]
    let signalSound = ["Гонг", "Вода", "Колокольчик"]
    
    var backgoundMusicPickerView = UIPickerView()
    var signalSoundPickerView = UIPickerView()
    
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var signalTextField: UITextField!
    @IBOutlet weak var backgroundMusicTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signalTextField.inputView = signalSoundPickerView
        backgroundMusicTextField.inputView = backgoundMusicPickerView
        signalTextField.placeholder = "Сигнал Окончания"
        backgroundMusicTextField.placeholder = "Звуковое сопровождение"
        signalTextField.textAlignment = .center
        backgroundMusicTextField.textAlignment = .center
        
        signalSoundPickerView.delegate = self
        signalSoundPickerView.dataSource = self
        backgoundMusicPickerView.delegate = self
        backgoundMusicPickerView.dataSource = self
        signalSoundPickerView.tag = 2
        backgoundMusicPickerView.tag = 1
       
        
    }
    
    @IBAction func sliderChange(_ sender: UISlider) {
        let timerValue = Int(sender.value)
        
        timeLabel.text = "\(timerValue) мин"
    }
    @IBAction func playPressed(_ sender: UIButton) {
        let timerValue = Int(timeSlider.value)
        
        timer = timerValue
        
        
        //call method for second screen
        self.performSegue(withIdentifier: "goToMeditation", sender: self)
    }
    
    //for multiscreen app
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMeditation" {
            //downcasting 
            let destinationVC = segue.destination as! MeditationViewController
            destinationVC.timerText = timerSet.getTimerValue(minutes: timer)
            destinationVC.vvodnoe = Int(timer)
            destinationVC.music = musicPlay
            destinationVC.signal = signalPlay
        }
    }
}
    extension SettingsViewController: UIPickerViewDataSource, UIPickerViewDelegate {
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            switch pickerView.tag {
            case 1:
                return backgroundMusic.count
            case 2:
                return signalSound.count
            default:
                return 1
            }
        }
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            switch pickerView.tag {
            case 1:
                return backgroundMusic[row]
            case 2:
                return signalSound[row]
            default:
                return "Нет данных"
            }
        }
       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           switch pickerView.tag {
           case 1:
               backgroundMusicTextField.text = backgroundMusic[row]
               backgroundMusicTextField.resignFirstResponder()
               musicPlay = backgroundMusic[row]
           case 2:
               signalTextField.text = signalSound[row]
               signalTextField.resignFirstResponder()
               signalPlay = signalSound[row]
           default:
               return
           }
        }
    }
    



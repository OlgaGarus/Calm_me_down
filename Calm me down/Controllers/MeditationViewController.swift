//
//  ResultViewController.swift
//  Calm me down
//
//  Created by Olga Garus on 11.01.2024.
//

import UIKit
import AVFoundation

class MeditationViewController: UIViewController {
    
    var timerText: String?
    var player: AVAudioPlayer!
    
    
    @IBOutlet weak var timerView: UITextView!
    @IBOutlet weak var stop: UIButton!
    @IBOutlet weak var pause: UIButton!
    
    @IBOutlet weak var start: UIButton!
   
    var timer:Timer = Timer()
    var vvodnoe:Int!
    var timerCounting:Bool = false
    var count = 0
    var music = ""
    var signal = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        count = vvodnoe*60
        timerView.text = timerText
        //timerView.clipsToBounds = ;
        timerView.layer.cornerRadius = 10.0;
       
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        
        if(timerCounting)
                {
                    timerCounting = false
                    timer.invalidate()
            if (player.isPlaying) {
                player.stop()
            }
                    start.setImage(UIImage(named: "play.png"), for: .normal)
                   
                    
                }
                else
                {
                    if (music != "Тишина") {
                        playMusic(musicName: music)
                    }
                    timerCounting = true
                    start.setImage(UIImage(named: "pause.png"), for: .normal)
                    
                    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
                }
        
    }
    @objc func timerCounter() -> Void
        {
            
            count = count - 1
            let time = secondsToMinutesSeconds(seconds: count)
            let timeString = makeTimeString(minutes: time.0, seconds: time.1)
            timerView.text = timeString
            
        }
        
        func secondsToMinutesSeconds(seconds: Int) -> (Int, Int)
        {
            if seconds >= 1 {
                
                return ((seconds/60) ,(seconds % 60))
            } else {
                player.stop()
                timerCounting = false
                timer.invalidate()
                playSound(soundName: signal)
                start.setImage(UIImage(named: "play.png"), for: .normal)
                return (0, 0)
                
            }
        }
        
        func makeTimeString( minutes: Int, seconds : Int) -> String
        {
           var timeString = ""
            timeString += String(format: "%02d", minutes)
            timeString += " : "
            timeString += String(format: "%02d", seconds)
            return timeString
        }
    
    
    @IBAction func stopButton(_ sender: UIButton) {
       
        if  (timerCounting == true) && (music != "Тишина"){
            player.stop()
        }
            //go back to main screen with method
            self.dismiss(animated: true, completion: nil)
    }

    func playSound(soundName: String) {
            //url - is the location of our music file
            let url = Bundle.main.url(forResource: soundName, withExtension: "wav")
        
            //we put our file into a player (like cd)
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
                    
        }

    func playMusic(musicName: String) {
            //url - is the location of our music file
            let url = Bundle.main.url(forResource: musicName, withExtension: "mp3")
        
            //we put our file into a player (like cd)
            player = try! AVAudioPlayer(contentsOf: url!)
            player.numberOfLoops =  -1
            player.play()
                    
        }
   
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

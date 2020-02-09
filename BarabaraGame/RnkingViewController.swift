//
//  RnkingViewController.swift
//  BarabaraGame
//
//  Created by Kazuma Adachi on 2019/12/25.
//  Copyright © 2019 Kazuma Adachi. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase

class RnkingViewController: UIViewController, AVAudioPlayerDelegate {
    
     var audioPlayer: AVAudioPlayer = AVAudioPlayer()
    
    @IBOutlet var rankingLabel1: UILabel!
    @IBOutlet var rankingLabel2: UILabel!
    @IBOutlet var rankingLabel3: UILabel!
    @IBOutlet var rankingLabel4: UILabel!
    @IBOutlet var rankingLabel5: UILabel!
    @IBOutlet var nameLabel1: UILabel!
    @IBOutlet var nameLabel2: UILabel!
    @IBOutlet var nameLabel3: UILabel!
    @IBOutlet var nameLabel4: UILabel!
    @IBOutlet var nameLabel5: UILabel!
    @IBOutlet var ranking: UILabel!
    @IBOutlet var toTop: UIButton!
    @IBOutlet var View4: UIView!
    
    let defaults: UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ranking.layer.cornerRadius = 15
        toTop.layer.cornerRadius = 10
        View4.layer.cornerRadius = 20
        rankingLabel1.layer.cornerRadius = 10
        
        rankingLabel1.text = String(defaults.integer(forKey: "score1"))
        rankingLabel2.text = String(defaults.integer(forKey: "score2"))
        rankingLabel3.text = String(defaults.integer(forKey: "score3"))
        rankingLabel4.text = String(defaults.integer(forKey: "score4"))
        rankingLabel5.text = String(defaults.integer(forKey: "score5"))
        
        if defaults.string(forKey: "name1") != nil{
            nameLabel1.text = defaults.string(forKey: "name1")!
        }else{
            nameLabel1.text = ""
        }
        if defaults.string(forKey: "name2") != nil{
            nameLabel2.text = defaults.string(forKey: "name2")!
        }else{
            nameLabel2.text = ""
        }
        if defaults.string(forKey: "name3") != nil{
            nameLabel3.text = defaults.string(forKey: "name3")!
        }else{
            nameLabel3.text = ""
        }
        if defaults.string(forKey: "name4") != nil{
            nameLabel4.text = defaults.string(forKey: "name4")!
        }else{
            nameLabel4.text = ""
        }
        if defaults.string(forKey: "name4") != nil{
            nameLabel5.text = defaults.string(forKey: "name5")!
        }else{
            nameLabel5.text = ""
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func toTop4() {
        audioPlayer.stop()
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
   
    func playBGM(name: String) {
           guard let path = Bundle.main.path(forResource: name, ofType: "mp3") else {
               return
           }
           do {
               audioPlayer.stop()
               audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
               
               audioPlayer.delegate = self
               
               audioPlayer.play()
           } catch {
           }
       }
    
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           playBGM(name: "BGM3")
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

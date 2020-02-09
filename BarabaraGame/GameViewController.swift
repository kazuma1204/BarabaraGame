//
//  GameViewController.swift
//  BarabaraGame
//
//  Created by Kazuma Adachi on 2019/12/25.
//  Copyright © 2019 Kazuma Adachi. All rights reserved.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController,AVAudioPlayerDelegate {
    
    var audioPlayer: AVAudioPlayer = AVAudioPlayer()
    
    @IBOutlet var imgView1: UIImageView!
    @IBOutlet var imgView2: UIImageView!
    @IBOutlet var imgView3: UIImageView!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var toTop: UIButton!
    @IBOutlet var stop2: UIButton!
    @IBOutlet var restart: UIButton!
    @IBOutlet var view2: UIView!
    
    
    var timer: Timer!
    var score: Int = 1000
    let defaults: UserDefaults = UserDefaults.standard
    
    let width: CGFloat = UIScreen.main.bounds.size.width
    var positionX: [CGFloat] = [0.0, 0.0, 0.0]
    var dx: [CGFloat] = [3.0, 0.5, -1.5]
    
    var name: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        positionX = [width/2, width/2, width/2] //画像􏰀位置を画面幅􏰀中心にする
        self.start()
        
        stop2.layer.cornerRadius = 45
        restart.layer.cornerRadius = 45
        toTop.layer.cornerRadius = 10
        view2.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
    }
    
    func start() {
        resultLabel.isHidden = true
        timer = Timer.scheduledTimer(timeInterval: 0.005, target: self,selector: #selector(self.up), userInfo: nil, repeats: true)
        timer.fire()
    }
    @objc func up() {
        for i in 0..<3 {
            //端にきたら動かす向きを逆にする
            if positionX[i] > width || positionX[i] < 0 {
                dx[i] = dx[i] * (-1) }
            positionX[i] += dx[i] //画像􏰀位置をdx分ずらす }
            imgView1.center.x = positionX[0]
            imgView2.center.x = positionX[1]
            imgView3.center.x = positionX[2]
        }
    }
    
    @IBAction func stop() {
        if timer.isValid == true {
            timer.invalidate() //タイマーを止める(無効にする)
            for i in 0..<3 {
                score = score - abs(Int(width/2 - positionX[i]))*2 //スコア􏰀計算をする
            }
            resultLabel.text = "Score : " + String(score)
            resultLabel.isHidden = false
            
            let highScore1: Int = defaults.integer(forKey: "score1")
            let highScore2: Int = defaults.integer(forKey: "score2")
            let highScore3: Int = defaults.integer(forKey: "score3")
            let highScore4: Int = defaults.integer(forKey: "score4")
            let highScore5: Int = defaults.integer(forKey: "score5")
            
            let name1: String!
            if defaults.string(forKey: "name1") != nil{
                name1 = defaults.string(forKey: "name1")
            }else{
                name1 = ""
            }
            
            let name2: String!
            if defaults.string(forKey: "name2") != nil{
                name2 = defaults.string(forKey: "name2")
            }else{
                name2 = ""
            }
            
            let name3: String!
            if defaults.string(forKey: "name3") != nil{
                name3 = defaults.string(forKey: "name3")
            }else{
                name3 = ""
            }
            
            let name4: String!
            if defaults.string(forKey: "name4") != nil{
                name4 = defaults.string(forKey: "name4")
            }else{
                name4 = ""
            }
            
            let name5: String!
            if defaults.string(forKey: "name5") != nil{
                name5 = defaults.string(forKey: "name5")
            }else{
                name5 = ""
            }
                       
                       
            
            if score > highScore1 {
                defaults.set(score, forKey: "score1")
                defaults.set(highScore1, forKey: "score2")
                defaults.set(highScore2, forKey: "score3")
                defaults.set(highScore3, forKey: "score4")
                defaults.set(highScore4, forKey: "score5")
                defaults.set(name, forKey: "name1")
                defaults.set(name1, forKey: "name2")
                defaults.set(name2, forKey: "name3")
                defaults.set(name3, forKey: "name4")
                defaults.set(name4, forKey: "name5")
                
                
                
            }else if score > highScore2 {
                defaults.set(score, forKey: "score2")
                defaults.set(highScore2, forKey: "score3")
                defaults.set(highScore3, forKey: "score4")
                defaults.set(highScore4, forKey: "score5")
                defaults.set(name, forKey: "name2")
                defaults.set(name2, forKey: "name3")
                defaults.set(name3, forKey: "name4")
                defaults.set(name4, forKey: "name5")
                
                
            }else if score > highScore3 {
                defaults.set(score, forKey: "score3")
                defaults.set(highScore3, forKey: "score4")
                defaults.set(highScore4, forKey: "score5")
                defaults.set(name, forKey: "name3")
                defaults.set(name3, forKey: "name4")
                defaults.set(name4, forKey: "name5")
                
                
            }else if score > highScore4 {
                defaults.set(score, forKey: "score4")
                defaults.set(highScore4, forKey: "score5")
                defaults.set(name, forKey: "name4")
                defaults.set(name4, forKey: "name5")
            }else if score > highScore5 {
                 defaults.set(score, forKey: "score5")
                defaults.set(name, forKey: "name5")
            }
                
            defaults.synchronize()
                
                
        }
        
    }
    
    @IBAction func toRankingButton() {
        audioPlayer.stop()
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           playBGM(name: "BGM2")
       }
       
    
    @IBAction func retry() {
        score = 1000 //スコア􏰀値をリセットする
        positionX = [width/2, width/2, width/2]
        if timer.isValid == false {
            self.start()
        }}
    
    @IBAction func toTop3() {
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "idou3" {
               audioPlayer.stop()
           }
       }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    //ランキングをオンライン
    //リトライとストップを同じ画面に
    //ランキング画面から遊ぶ画面に移動する際に名前が決められていない時にアラートを出す！
}

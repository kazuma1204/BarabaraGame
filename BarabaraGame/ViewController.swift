//
//  ViewController.swift
//  BarabaraGame
//
//  Created by Kazuma Adachi on 2019/12/25.
//  Copyright © 2019 Kazuma Adachi. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,UITextFieldDelegate, AVAudioPlayerDelegate {
    
    var audioPlayer: AVAudioPlayer = AVAudioPlayer()
    
    var name: String = ""
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var nameview: UIView!
    @IBOutlet var Titleview: UIView!
    @IBOutlet var secondview: UIView!
    @IBOutlet var start2: UIButton!
    @IBOutlet var ranking: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        
        Titleview.layer.cornerRadius = 20
        nameview.layer.cornerRadius = 20
        secondview.layer.cornerRadius = 155
        start2.layer.cornerRadius = 10
        ranking.layer.cornerRadius = 10
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func start() {
        if nameTextField.text == "" {
            let alert: UIAlertController = UIAlertController (title: "ちょい待ち!!", message: "名前を入力してね！",preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK!",style: .cancel, handler: { action in }))
            
            present(alert, animated: true, completion: nil)
            
        } else {
            name = nameTextField.text!
            self.performSegue(withIdentifier: "idou1", sender: nil)
        }
        
    }
    
    @IBAction func toRankingButton() {
        audioPlayer.stop()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "idou1" {
            let nextVC = segue.destination as! GameViewController
            nextVC.name = name
            audioPlayer.stop()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playBGM(name: "bgm")
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
    
}
//ランキングのオンライン表示にする
//ランキングペーじのランキングを丸くする
//ランキングページからバラバラ画面に移行する際に名前を入れろというアラートを追加
//ランキングページからバラバラ画面に移動する際に音楽を閉じる

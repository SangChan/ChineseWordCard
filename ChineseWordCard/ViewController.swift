//
//  ViewController.swift
//  ChineseWordCard
//
//  Created by SangChan on 2015. 9. 15..
//  Copyright (c) 2015년 VerandaStudio. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet var pinyinLabel: UILabel!
    @IBOutlet var hanyuLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    var touchCount : Int = 0;
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        resetAll();
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func resetAll() {
        touchCount = 0;
        setLabelHiddenByCount(touchCount);
    }
    
    func setLabelHiddenByCount(count : Int) {
        descriptionLabel.hidden = true;
        pinyinLabel.hidden = true;
        if(count == 0) {
            return
        }
        speakWord()
        pinyinLabel.hidden = false;
        if (count%2 == 0) {
            descriptionLabel.hidden = false;
        }
        
    }
    
    func speakWord() {
        let synthesize : AVSpeechSynthesizer = AVSpeechSynthesizer.init();
        let utterance : AVSpeechUtterance = AVSpeechUtterance.init(string: hanyuLabel.text!);
        utterance.voice = AVSpeechSynthesisVoice.init(language: "zh-CN");
        synthesize.speakUtterance(utterance);
    }
    
    @IBAction func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .Ended {
            // handling code
            setLabelHiddenByCount(++touchCount)
            
        }
    }
}


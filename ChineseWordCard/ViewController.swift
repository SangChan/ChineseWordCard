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
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    var previosWord : ChineseWord?
    var nowWord : ChineseWord!
    var nextWord : ChineseWord?
    
    var touchCount : Int = 0;
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func nextClicked(sender: AnyObject) {
        resetAll();
        setNowWord(nextWord!.hanyuText, pinyinText: nextWord!.pinyinText, descriptionText: nextWord!.descriptionText);
    }
    @IBAction func prevClicked(sender: AnyObject) {
        resetAll();
        setNowWord(previosWord!.hanyuText, pinyinText: previosWord!.pinyinText, descriptionText: previosWord!.descriptionText);
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        resetAll();
        setPreviousWord("爸爸", pinyinText: "bàba", descriptionText: "아버지");
        setNowWord("妈妈", pinyinText: "māma", descriptionText: "어머니");
        setNextWord("弟弟", pinyinText: "dìdi", descriptionText: "남동생");
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
    
    func setPreviousWord(hanyuText : String ,pinyinText : String, descriptionText : String) {
        self.previosWord = ChineseWord.init(hanyuInput: hanyuText, pinyinInput: pinyinText, descriptionInput: descriptionText,nowInput: 0);
    }
    
    func setNowWord(hanyuText : String ,pinyinText : String, descriptionText : String) {
        nowWord = ChineseWord.init(hanyuInput: hanyuText, pinyinInput: pinyinText, descriptionInput: descriptionText,nowInput: 1);
        
        self.hanyuLabel.text = nowWord.hanyuText;
        self.pinyinLabel.text = nowWord.pinyinText;
        self.descriptionLabel.text = nowWord.descriptionText;
    }
    
    func setNextWord(hanyuText : String ,pinyinText : String, descriptionText : String) {
        self.nextWord = ChineseWord.init(hanyuInput: hanyuText, pinyinInput: pinyinText, descriptionInput: descriptionText,nowInput: 2);
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


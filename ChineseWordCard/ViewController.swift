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
    
    var wordList : NSMutableArray = [];
    
    var previosWord : ChineseWord!
    var nowWord : ChineseWord!
    var nextWord : ChineseWord!
    
    var touchCount : Int = 0;
    var wordIndex : Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func goToNext() {
        resetAll();
        ++wordIndex;
        self.updateUIonView();
    }
    
    func goToPrev() {
        resetAll();
        --wordIndex;
        self.updateUIonView();
    }
    @IBAction func nextClicked(sender: AnyObject) {
        self.goToNext();
    }
    @IBAction func prevClicked(sender: AnyObject) {
        self.goToPrev();
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        resetAll();
        
        wordList = [
            ChineseWord.init(id: 0, level: 0, chapter: 0, hanyu: "爸爸", pinyin: "bàba", desc: "아버지"),
            ChineseWord.init(id: 1, level: 0, chapter: 0, hanyu: "妈妈", pinyin: "māma", desc: "어머니"),
            ChineseWord.init(id: 2, level: 0, chapter: 0, hanyu: "弟弟", pinyin: "dìdi", desc: "남동생")
        ];
        
        
        self.previosWord = wordList.objectAtIndex(0) as! ChineseWord;
        self.nowWord = wordList.objectAtIndex(1) as! ChineseWord;
        self.nextWord = wordList.objectAtIndex(2) as! ChineseWord;
        
        self.updateUIonView();
    }
    
    func updateUIonView() {
        self.nowWord = wordList.objectAtIndex(wordIndex) as! ChineseWord;
        
        self.hanyuLabel.text = nowWord.hanyu;
        self.pinyinLabel.text = nowWord.pinyin;
        self.descriptionLabel.text = nowWord.desc;
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
        
    @IBAction func handleSwipeLeft(sender: UISwipeGestureRecognizer) {
        self.goToPrev();
    }
    
    
    @IBAction func handleSwipeRight(sender: UISwipeGestureRecognizer) {
        self.goToNext();
    }
    
    
    @IBAction func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .Ended {
            // handling code
            setLabelHiddenByCount(++touchCount)
            
        }
    }
}


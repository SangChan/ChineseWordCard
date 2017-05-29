//
//  ViewController.swift
//  ChineseWordCard
//
//  Created by SangChan on 2015. 9. 15..
//  Copyright (c) 2015년 VerandaStudio. All rights reserved.
//

import UIKit
import AVFoundation
import RealmSwift
import FontAwesome_swift

enum Direction {
    case previous
    case next
    case draw
}

// TODO : change name space as WordViewControllerls
class WordViewController: UIViewController {

    @IBOutlet var pinyinLabel        : UILabel!
    @IBOutlet var hanyuLabel         : UILabel!
    @IBOutlet var descriptionLabel   : UILabel!
    @IBOutlet weak var nextButton    : UIButton!
    @IBOutlet weak var prevButton    : UIButton!
    @IBOutlet weak var sliderBar     : UISlider!
    @IBOutlet weak var starButton    : UIButton!
    @IBOutlet weak var settingButton : UIButton!
    
    var wordList     : Results<ChineseWord>!
    var currentWord  : ChineseWord!
    var touchCount   : Int = 0
    var wordIndex    : Int = 0
    var maxWordCount : Int = 0
    var copiedString : String?
    
    // override section
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonDefault()
        resetView()
        getWordData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateUIonView();
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.becomeFirstResponder()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // TODO : what's this come frome?
    override var canBecomeFirstResponder : Bool {
        return true
    }
    
}
extension WordViewController {
    // IBActions only
    @IBAction func nextClicked(_ sender: AnyObject) {
        self.goTo(direction:.next)
    }
    @IBAction func prevClicked(_ sender: AnyObject) {
        self.goTo(direction:.previous)
    }
    @IBAction func valueChanged(_ sender: AnyObject) {
        resetView()
        self.wordIndex = Int(self.sliderBar.value * Float(wordList.count))
        if wordIndex <= 0 {
            wordIndex = 0
        } else if wordIndex > wordList.count-1 {
            wordIndex = wordList.count-1
        }
        self.updateUIonView()
    }
    
    @IBAction func handleSwipeLeft(_ sender: UISwipeGestureRecognizer) {
        if isTouched(onLocation:sender.location(in: hanyuLabel), onRect: hanyuLabel.frame) {
            if sender.state == .ended {
                self.goTo(direction:.next)
            } else if sender.state == .began {
                self.hanyuLabel.alpha = 0.9
            } else if sender.state == .changed {
                self.hanyuLabel.alpha = 0.5
            }
        }
    }
    
    @IBAction func handleSwipeRight(_ sender: UISwipeGestureRecognizer) {
        if isTouched(onLocation:sender.location(in: hanyuLabel), onRect: hanyuLabel.frame) {
            if sender.state == .ended {
                self.goTo(direction:.previous)
            } else if sender.state == .began {
                
            } else if sender.state == .changed {
                
            }
        }
    }
    
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        if isTouched(onLocation:sender.location(in: hanyuLabel), onRect: hanyuLabel.frame) && sender.state == .ended {
            touchCount += 1
            setLabelHidden(byCount:touchCount)
        }
    }
    
    @IBAction func handleLongPress(_ sender: UILongPressGestureRecognizer) {
        if isTouched(onLocation:sender.location(in: hanyuLabel), onRect: hanyuLabel.frame) && sender.state == .began {
            hanyuLabel.becomeFirstResponder()
            
            copiedString = hanyuLabel.text
            
            let copyMenuItem = UIMenuItem(title: "Copy", action: #selector(copyText(_:)))
            let copyMenu = UIMenuController.shared
            copyMenu.setTargetRect(hanyuLabel.frame, in: self.view)
            copyMenu.arrowDirection = .default
            copyMenu.setMenuVisible(true, animated: true)
            copyMenu.menuItems = [copyMenuItem]
        }
    }
    
    @IBAction func starButtonPressed(_ sender: AnyObject) {
        guard AppInfo.sharedInstance.sortInfo.sortValue.rawValue != SortIndex.sortIndexStar.rawValue else { return }
        
        defer {
            setButton(button:self.starButton, withSize: 30, withType: (currentWord.likeIt == true) ? .star:.starO)
        }
        
        do {
            try self.writeRealm(likeIt: !self.currentWord.likeIt)
        } catch {
            print("exeception :\(error)")
        }
    }
    
    @IBAction func unwindToSegue(_ segue: UIStoryboardSegue) {
        getWordData()
    }
}

extension WordViewController {
    
    func wordIndex(toIncrease : Bool) -> Int {
        var index : Int = wordIndex
        if toIncrease {
            index += 1
        } else {
            index -= 1
        }
        
        if index >= 0 && index < wordList.count {
            return index
        }
        return wordIndex
    }
    
    func goTo(direction : Direction) {
        switch direction {
        case .next :
            resetView()
            wordIndex = self.wordIndex(toIncrease:true);
            self.updateUIonView()
        case .previous :
            resetView()
            wordIndex = self.wordIndex(toIncrease:false);
            self.updateUIonView()
        default :
            resetView()
        }
    }
    
    func getData(sortIndex : InfoProtocol) -> Results<ChineseWord> {
        let realm = try! Realm()
        switch sortIndex {
        case SortIndex.sortIndexStar :
            return (realm.objects(ChineseWord.self).filter("likeIt == true").count > 0) ? realm.objects(ChineseWord.self).filter("likeIt == true") : realm.objects(ChineseWord.self)
        case SortIndex.sortIndexAlphabet :
            return realm.objects(ChineseWord.self).sorted(byKeyPath: "pinyin")
        default :
            return realm.objects(ChineseWord.self)
        }
    }
    
    func setButton(button:UIButton, withSize size : CGFloat, withType type:FontAwesome) {
        let sizeFromTrait : CGFloat = (self.view.traitCollection.horizontalSizeClass == .regular && self.view.traitCollection.verticalSizeClass == .regular) ? size * 1.5 : size
        button.titleLabel?.font = UIFont.fontAwesome(ofSize: sizeFromTrait)
        button.setTitle(String.fontAwesomeIcon(name: type), for: UIControlState())
    }
    
    func updateUIonView() {
        AppInfo.sharedInstance.setWordIndex(wordIndex)
        self.prevButton.isEnabled = (wordIndex > 0) ? true : false
        self.nextButton.isEnabled = (wordIndex < wordList.count-1) ? true : false
        self.starButton.isHidden = (AppInfo.sharedInstance.sortInfo.sortValue.rawValue == SortIndex.sortIndexStar.rawValue)
        self.currentWord = wordList[wordIndex]
        self.hanyuLabel.alpha = 1.0
        self.hanyuLabel.text = currentWord.hanyu
        self.pinyinLabel.text = currentWord.pinyin
        self.descriptionLabel.text = descriptionText(fromLanguageIndex:AppInfo.sharedInstance.languageInfo.languageValue)
        self.sliderBar.value =  Float(wordIndex)/Float(wordList.count)
        setButton(button:self.starButton, withSize: 30, withType: (currentWord.likeIt == true) ? .star:.starO)
        do {
            try self.writeRealm(isShown: true)
        } catch {
            print("exeception :\(error)")
        }
    }
    
    func descriptionText(fromLanguageIndex : InfoProtocol) -> String {
        return currentWord.desc_kr
    }
    
    func setButtonDefault() {
        setButton(button:self.prevButton, withSize: 30, withType: .angleLeft)
        setButton(button:self.nextButton, withSize: 30, withType: .angleRight)
        setButton(button:self.starButton, withSize: 30, withType: .starO)
        setButton(button:self.settingButton, withSize: 30, withType: .cog)
    }
    
    func resetView() {
        touchCount = 0
        setLabelHidden(byCount:touchCount)
    }
    
    func getWordData() {
        self.wordList = self.getData(sortIndex: AppInfo.sharedInstance.sortInfo.sortValue)
        self.maxWordCount = self.wordList.count
        self.wordIndex = AppInfo.sharedInstance.getWordIndex()
        if self.wordIndex > self.maxWordCount {
            AppInfo.sharedInstance.setWordIndex(0)
            self.wordIndex = AppInfo.sharedInstance.getWordIndex()
        }
    }
    
    func setLabelHidden(byCount : Int) {
        switch byCount % 3 {
        case 1 :
            UIView.animate(withDuration: 0.3, animations: {
                self.pinyinLabel.alpha = 1.0
            }, completion: { (success) in
                self.speakWord()
            })
        case 2 :
            UIView.animate(withDuration: 0.3, animations: {
                self.descriptionLabel.alpha = 1.0
            }, completion: nil)
        default:
            pinyinLabel.alpha = 0.0
            descriptionLabel.alpha = 0.0
        }
    }
    
    func speakWord() {
        let synthesize : AVSpeechSynthesizer = AVSpeechSynthesizer()
        let utterance : AVSpeechUtterance = AVSpeechUtterance(string: hanyuLabel.text!)
        utterance.rate = getSpeechSpeed(fromIndex:AppInfo.sharedInstance.speechInfo.speechSpeedValue)
        utterance.voice = AVSpeechSynthesisVoice(language: "zh-CN")
        synthesize.speak(utterance)
    }
    
    func getSpeechSpeed(fromIndex : InfoProtocol) -> Float {
        switch fromIndex.rawValue {
        case SpeechSpeedIndex.speechSpeedSlow.rawValue :
            return AVSpeechUtteranceDefaultSpeechRate * 0.35
        case SpeechSpeedIndex.speechSpeedFast.rawValue :
            return AVSpeechUtteranceDefaultSpeechRate
        default:
            return AVSpeechUtteranceDefaultSpeechRate * 0.65
        }
    }
    
    func isTouched(onLocation : CGPoint, onRect: CGRect) -> Bool{
        if onLocation.x > 0.0 && onLocation.x < onRect.width && onLocation.y > 0.0 && onLocation.y < onRect.height {
            return true
        }
        return false
    }
    
    func copyText(_ sender : UIMenuController) {
        guard let _copiedString = self.copiedString else { return }
        let pasteBoard = UIPasteboard.general
        pasteBoard.string = _copiedString
    }
}

extension WordViewController {
    func writeRealm(likeIt : Bool) throws {
        let realm = try! Realm()
        
        try realm.write {
            self.currentWord.likeIt = likeIt
        }
    }

    func writeRealm(isShown : Bool) throws {
        let realm = try! Realm()
        
        try realm.write {
            self.currentWord.isShown = isShown
            self.currentWord.play += 1
        }
    }

}

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
import GoogleMobileAds

enum Direction {
    case previous
    case next
    case draw
}

class WordViewController: UIViewController {

    @IBOutlet fileprivate weak var pinyinLabel : UILabel!
    @IBOutlet fileprivate weak var hanyuLabel : UILabel!
    @IBOutlet fileprivate weak var descriptionLabel : UILabel!
    @IBOutlet fileprivate weak var nextButton : UIButton!
    @IBOutlet fileprivate weak var prevButton : UIButton!
    @IBOutlet fileprivate weak var sliderBar : UISlider!
    @IBOutlet fileprivate weak var starButton : UIButton!
    @IBOutlet fileprivate weak var settingButton : UIButton!
    
    var wordList     : Results<ChineseWord>!
    var currentWord  : ChineseWord!
    var copiedString : String?
    var touchCount   : Int = 0
    var wordIndex    : Int = 0
    var maxWordCount : Int = 0
    var bannerView: GADBannerView!
    
    lazy var lazyRealm : Realm? = {
        do {
            return try Realm()
        } catch let error {
            print("error : \(error)")
            return nil
        }
    }()
    
    // override section
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonDefault()
        resetView()
        getWordData()
        addBanner()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateUIonView()
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
            }
        }
    }
    
    @IBAction func handleSwipeRight(_ sender: UISwipeGestureRecognizer) {
        if isTouched(onLocation:sender.location(in: hanyuLabel), onRect: hanyuLabel.frame) {
            if sender.state == .ended {
                self.goTo(direction:.previous)
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
            let localizedCopyString = NSLocalizedString("popup.copy", comment: "Copy")
            let copyMenuItemString = localizedCopyString
            let copyMenuItem = UIMenuItem(title: copyMenuItemString, action: #selector(copyText(_:)))
            let copyMenu = UIMenuController.shared
            copyMenu.setTargetRect(hanyuLabel.frame, in: self.view)
            copyMenu.arrowDirection = .default
            copyMenu.setMenuVisible(true, animated: true)
            copyMenu.menuItems = [copyMenuItem]
        }
    }
    
    @IBAction func starButtonPressed(_ sender: AnyObject) {
        guard AppInfo.sharedInstance.sortInfo.sortValue.rawValue != SortIndex.sortIndexStar.rawValue else { return }
        self.writeRealm(likeIt: !self.currentWord.likeIt)
        setButton(button:self.starButton, withSize: 30, withType: .star, withStyle: (currentWord.likeIt == true) ? .solid : .regular)
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
            wordIndex = self.wordIndex(toIncrease:true)
            self.updateUIonView()
        case .previous :
            resetView()
            wordIndex = self.wordIndex(toIncrease:false)
            self.updateUIonView()
        default :
            resetView()
        }
    }
    
    func getData(sortIndex : InfoProtocol) -> Results<ChineseWord>? {
        guard let realm = self.lazyRealm else { return .none }
        switch sortIndex {
        case SortIndex.sortIndexStar :
            return (realm.objects(ChineseWord.self).filter("likeIt == true").count > 0) ? realm.objects(ChineseWord.self).filter("likeIt == true") : realm.objects(ChineseWord.self)
        case SortIndex.sortIndexAlphabet :
            return realm.objects(ChineseWord.self).sorted(byKeyPath: "pinyin")
        default :
            return realm.objects(ChineseWord.self)
        }
    }
    
    func setButton(button: UIButton, withSize size: CGFloat, withType type: FontAwesome, withStyle style: FontAwesomeStyle = .solid) {
        let sizeFromTrait : CGFloat = (self.view.traitCollection.horizontalSizeClass == .regular && self.view.traitCollection.verticalSizeClass == .regular) ? size * 1.5 : size
        button.titleLabel?.font = UIFont.fontAwesome(ofSize: sizeFromTrait, style: style)
        button.setTitle(String.fontAwesomeIcon(name: type), for: UIControl.State())
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
        setButton(button:self.starButton, withSize: 30, withType: .star, withStyle: (currentWord.likeIt == true) ? .solid : .regular)
        self.writeRealm(isShown: true)
    }
    
    func descriptionText(fromLanguageIndex : InfoProtocol) -> String {
        let firstLang = Bundle.main.preferredLocalizations.first ?? "en"
        if firstLang == "ko" {
            return currentWord.desc_kr
        }
        return currentWord.desc_en
    }
    
    func setButtonDefault() {
        setButton(button:self.prevButton, withSize: 30, withType: .angleLeft)
        setButton(button:self.nextButton, withSize: 30, withType: .angleRight)
        setButton(button:self.starButton, withSize: 30, withType: .star, withStyle: .regular)
        setButton(button:self.settingButton, withSize: 30, withType: .cog)
    }
    
    func resetView() {
        touchCount = 0
        setLabelHidden(byCount:touchCount)
    }
    
    func getWordData() {
        guard let wordList = self.getData(sortIndex: AppInfo.sharedInstance.sortInfo.sortValue) else { return }
        self.wordList = wordList
        self.maxWordCount = self.wordList.count
        self.wordIndex = AppInfo.sharedInstance.getWordIndex()
        if self.wordIndex > self.maxWordCount {
            AppInfo.sharedInstance.setWordIndex(0)
            self.wordIndex = AppInfo.sharedInstance.getWordIndex()
        }
    }
    
    func addBanner() {
        self.bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        addBannerViewToView(self.bannerView)
        self.bannerView.adUnitID = "ca-app-pub-7672230516236261/8258045034"
        self.bannerView.rootViewController = self
        self.bannerView.load(GADRequest())
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        positionBannerViewFullWidthAtBottomOfSafeArea(bannerView)
    }
    
    func positionBannerViewFullWidthAtBottomOfSafeArea(_ bannerView: UIView) {
        // Position the banner. Stick it to the bottom of the Safe Area.
        // Make it constrained to the edges of the safe area.
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            guide.leftAnchor.constraint(equalTo: bannerView.leftAnchor),
            guide.rightAnchor.constraint(equalTo: bannerView.rightAnchor),
            guide.bottomAnchor.constraint(equalTo: bannerView.bottomAnchor)
            ])
    }
    
    func setLabelHidden(byCount : Int) {
        switch byCount % 3 {
        case 1 :
            UIView.animate(withDuration: 0.3, animations: {
                self.pinyinLabel.alpha = 1.0
            }, completion: { _ in
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
        guard let textForSpeech = hanyuLabel.text else { return }
        let synthesize : AVSpeechSynthesizer = AVSpeechSynthesizer()
        let utterance : AVSpeechUtterance = AVSpeechUtterance(string: textForSpeech)
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
    
    func isTouched(onLocation : CGPoint, onRect: CGRect) -> Bool {
        if onLocation.x > 0.0 && onLocation.x < onRect.width && onLocation.y > 0.0 && onLocation.y < onRect.height {
            return true
        }
        return false
    }
    
    @objc func copyText(_ sender : UIMenuController) {
        guard let copiedString = self.copiedString else { return }
        let pasteBoard = UIPasteboard.general
        pasteBoard.string = copiedString
    }
}

extension WordViewController {
    func writeRealm(likeIt : Bool) {
        guard let realm = try? Realm() else { return }
        
        try? realm.write {
            self.currentWord.likeIt = likeIt
        }
    }

    func writeRealm(isShown : Bool) {
        guard let realm = try? Realm() else { return }
        
        try? realm.write {
            self.currentWord.isShown = isShown
            self.currentWord.play += 1
        }
    }

}

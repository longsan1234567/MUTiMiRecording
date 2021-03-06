//
//  MUAlertView.swift
//  MUWindow
//
//  Created by 潘元荣(外包) on 16/6/16.
//  Copyright © 2016年 潘元荣(外包). All rights reserved.
//

import UIKit


public enum viewType {case alertView, sheetView, upView,rightView,calendarView}

class MUAlertView: UIView {
    private lazy var contentLabel = UILabel()
    private lazy var cancelButton = UIButton.init(type: UIButtonType.System)
    private lazy var certainButton = UIButton.init(type: UIButtonType.System)
    private lazy var  inputTextView = UITextView.init()
    private lazy var  calendar = UIDatePicker.init()
    private lazy var  block = {(object : AnyObject) -> Void in}
    lazy var date = NSDate.init(timeIntervalSinceNow: 0)
    var sheetButtonTitles :[String]?
    var ShowCancelButton = false
    var message = "abc"
    var showTextView = false
    var textViewKeyBoard = UIKeyboardType.Default
    var _ViewType = viewType.alertView{
        didSet{
            
            }
    }
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        certainButton.layer.borderWidth = 0.5
        certainButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        certainButton.setTitle("确定", forState: UIControlState.Normal)
        certainButton.addTarget(self, action: "clickButton:", forControlEvents: UIControlEvents.TouchUpInside)
        certainButton.frame = CGRectMake(-1, self.bounds.size.height - 40 * KHeightScale, self.bounds.size.width+2, 40 * KHeightScale)
      
        
        cancelButton.setTitle("取消", forState: UIControlState.Normal)
        cancelButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        cancelButton.layer.borderWidth = 0.5
        cancelButton.frame = CGRectMake(self.bounds.size.width * 0.5, self.bounds.size.height - 40 * KHeightScale, self.bounds.size.width * 0.5 + 1, 40 * KHeightScale)
        cancelButton.addTarget(self, action: "clickButton:", forControlEvents: UIControlEvents.TouchUpInside)
        
        switch _ViewType {
        case .alertView:
            self.userInteractionEnabled = true
            contentLabel.attributedText = self.getAttributedString(self.message)
            contentLabel.numberOfLines = 0
            let height = self.message.getStringHeight(self.bounds.size.width - 20.0 * KWidthScale, content: self.contentLabel.attributedText!)
            
            contentLabel.frame = CGRectMake(10.0 * KWidthScale, 10 * KHeightScale, self.bounds.size.width - 20.0 * KWidthScale,height)
            self.addSubview(contentLabel)
            
            
           
            inputTextView.layer.cornerRadius = 5
            inputTextView.layer.borderColor = UIColor.lightGrayColor().CGColor
            inputTextView.layer.borderWidth = 1
            inputTextView.frame = CGRectMake(20, 20 * KHeightScale + height, self.bounds.size.width - 40, self.bounds.size.height - 70 * KHeightScale - height)
            inputTextView.delegate = self
            inputTextView.keyboardType = self.textViewKeyBoard
            self.inputTextView.font = UIFont.systemFontOfSize(KTitleFont)
            if(self.showTextView){
              self.addSubview(inputTextView)
              inputTextView.text = NSUserDefaults.standardUserDefaults().valueForKey("USERBUDGET") as? String
            }
           // self.addSubview(inputTextView)
            if self.ShowCancelButton {
               certainButton.frame = CGRectMake(-1, self.bounds.size.height - 40 * KHeightScale, self.bounds.size.width * 0.5 + 1, 40 * KHeightScale)
               self.addSubview(cancelButton)
               
            }
        self.addSubview(certainButton)
            break
        case .rightView:
            contentLabel.text = "dhuhu"
            break
        case .sheetView:
           
            var index = 0
            for title in self.sheetButtonTitles! {
                 let button = UIButton.init(type: .System)
                 button.setTitle(title, forState: .Normal)
                 let height = CGFloat.init(index) * 40 * KHeightScale
                 button.frame = CGRectMake(-5,height, self.bounds.size.width+10, 40 * KHeightScale)
                 button.tag = index
                 button.addTarget(self, action: "sheetViewButtonAction:", forControlEvents: .TouchUpInside)
                 button.layer.cornerRadius = 5.0
                 button.layer.borderWidth = 0.25
                 button.layer.borderColor = UIColor.lightGrayColor().CGColor
                 button.clipsToBounds = true
                 self.addSubview(button)
                 index += 1
            
            }
            break
        case .upView:
            contentLabel.text = "dhuhu"
            break
        case .calendarView:
            self.calendar.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - 40 * KHeightScale)
            self.calendar.locale = NSLocale.init(localeIdentifier: "zh_CN")
            self.calendar.date = self.date
            self.calendar.datePickerMode = .Date
            self.addSubview(calendar)
            self.addSubview(certainButton)
            break
        }
       

    }
    @objc
    private func getAttributedString(content :String)->NSAttributedString{
        let style = NSMutableParagraphStyle.init()
        style.lineBreakMode = NSLineBreakMode.ByCharWrapping
        style.lineSpacing = 2//
        let string = NSMutableAttributedString.init(string: content, attributes: [NSParagraphStyleAttributeName:style,NSFontAttributeName:UIFont(name: "Avenir-Light", size: 17 * KHeightScale)!,NSStrokeWidthAttributeName:-1.5])
        string.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSMakeRange(0, 2))
        return string
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 10
        self.clipsToBounds = false
    }
    //MARK: Buttons Method
    @objc
    private func clickButton(sender :UIButton){
        if(sender == self.certainButton){
        switch self._ViewType {
        case .alertView:
            if self.textViewKeyBoard == .DecimalPad {
                if(!Double.init(inputTextView.text)!.isZero){
                    MUWindow.setWindowFinishBlock({ () -> Void in
                        self.inputTextView.resignFirstResponder()
                        self.block(self.inputTextView.text)
                    })
                }
            }else{
                MUWindow.setWindowFinishBlock({ () -> Void in
                    self.block("YES")
                    
                })
            }
            
               break
        case .calendarView:
              MUWindow.setWindowFinishBlock({ () -> Void in
                 NSNotificationCenter.defaultCenter().postNotificationName(KNotificationCurrentTime, object: self.calendar.date)
                self.block("YES")
              })
               break
        case .rightView:
               break
        case .sheetView:
               break
        case .upView:
               break
        }
        }else{
          MUWindow.setWindowFinishBlock({ () -> Void in
            self.block("NO")
          })
        }
        
        
    }
    @objc
    private func sheetViewButtonAction(sender : UIButton) {
         MUWindow.setWindowFinishBlock { () -> Void in
            self.block(sender.tag)
        }
    }
    //MARK: set Block
    func setBlock(block :(object : AnyObject) -> Void) {
          self.block = block
    }
    //MARK: SetMethod
    func setCurrentDate(timeInterVal : NSTimeInterval) {
        self.date = NSDate.init(timeIntervalSince1970: timeInterVal)
    }
    //MARK: datePicker
    func getPickedDateTimeInterval() -> NSTimeInterval {
        let durain = self.calendar.date.timeIntervalSinceNow
        return durain
    }
    func getHeight() -> CGFloat {
        switch self._ViewType {
        case .alertView:
            return 50 * KHeightScale + self.message.getStringHeight(self.bounds.size.width - 20.0 * KWidthScale, content: self.getAttributedString(self.message))
        case .calendarView:
            return 0.0
        case .rightView:
             return 0.0
        case .sheetView:
             return 0.0
        case .upView:
             return 0.0
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MUAlertView :UITextViewDelegate{
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        UIView.animateWithDuration(NSTimeInterval.init(0.35)) { () -> Void in
            var rect = self.superview?.frame
            rect?.origin.y -= 60 * KHeightScale;
            self.superview?.frame = rect!
        }
        return true
    }
    func textViewDidChange(textView: UITextView) {
        if textView.keyboardType == .DecimalPad {
           
           let amount = Double.init(textView.text)
          
            if textView.text.isEmpty {
               return
            }
            if amount == nil && !textView.text.isEmpty{
               textView.text = textView.text.substringToIndex(textView.text.endIndex.advancedBy(-1))
                return
            }
            if amount!.isZero {
                if textView.text.containsString("."){
                   textView.text = "0."
                   return
                }
                textView.text = "0"
                return
            }
            if textView.text.containsString(".") {
                let length = Int(String(textView.text.endIndex))
                if length > 4 {
                  let subStr = textView.text.substringFromIndex(textView.text.endIndex.advancedBy(-3))
                    if !subStr.containsString("."){
                       textView.text = textView.text.substringToIndex(textView.text.endIndex.advancedBy(-1))
                        return
                    }
                    return
                }
            }
            if amount > 100000000 {
                textView.text = textView.text.substringToIndex(textView.text.endIndex.advancedBy(-1))
                return
            }
        }
    }
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        if text.containsString("\n"){
            UIView.animateWithDuration(NSTimeInterval.init(0.35)) { () -> Void in
                var rect = self.superview?.frame
                rect?.origin.y += 60 * KHeightScale
                self.superview?.frame = rect!
            }
           textView.resignFirstResponder()
           return false
        }
        return true
    }


}


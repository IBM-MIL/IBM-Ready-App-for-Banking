/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import UIKit

/**
*  Class that manages the creation, display, hiding, and deletion of the MILAlertView
*/
public class MILAlertViewManager: NSObject {
    
    /// The MILAlertView. Private to just this class
    private var milAlertView : MILAlertView!
    /// The callback of the reload
    var callback : (()->())!
    
    
    public class var sharedInstance : MILAlertViewManager{
        
        struct Singleton {
            static let instance = MILAlertViewManager()
        }
        return Singleton.instance
    }
    
    /**
    Function that builds and displays a MILAlertView
    
    :param: text     Text to display on the MILAlertView
    :param: callback Callback function to execute when the MILAlertView or its reload button is tapped
    */
    func show(text: String!, callback: (()->())!) {
        
        // show alertview on main UI
        
        if self.milAlertView != nil{
            self.remove()
        }
        self.callback = callback
        self.milAlertView = self.buildAlert(text, callback: callback)
        
        UIApplication.sharedApplication().keyWindow?.addSubview(self.milAlertView)
        
        UIView.animateWithDuration(1, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.milAlertView.setBottom(self.milAlertView.height)
            }, completion: { finished -> Void in
                if finished{
                    self.milAlertView.userInteractionEnabled = true
                    if callback == nil {
                        NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "hide", userInfo: nil, repeats: false)
                    }
                }
        })
        
    }
    
    /**
    Builds a MILAlertView that is initialized with the appropriate data
    
    :param: text     Text to display on the MILAlertView
    :param: callback Callback function to execute when the MILAlertView reload button is tapped
    
    :returns: An initialized MILAlertView
    */
    private func buildAlert(text: String!, callback: (()->())!)-> MILAlertView{
        var milAlertView : MILAlertView = MILAlertView.instanceFromNib() as MILAlertView
        milAlertView.setOriginX(0)
        milAlertView.setWidth(UIScreen.mainScreen().bounds.width)
        milAlertView.setBottom(0)
        milAlertView.setLabel(text)
        milAlertView.userInteractionEnabled = false
        milAlertView.setCallbackFunc(callback)
        
        var tapGesture = UITapGestureRecognizer(target: self, action: "hide")
        if callback != nil {
            tapGesture = UITapGestureRecognizer(target: self, action: "reload")
        }
        milAlertView.addGestureRecognizer(tapGesture)
        
        return milAlertView
    }
    
    /**
    Hides the MILAlertView with an animation
    */
    public func hide() {
        if self.milAlertView != nil{
            self.milAlertView.userInteractionEnabled = false
            UIView.animateWithDuration(1, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.milAlertView.setBottom(0)
                }, completion: { finished -> Void in
                    if finished {
                        self.remove()
                    }
            })
        }
        
    }
    
    /**
    Removes the MILAlertView from its superview and sets it to nil
    */
    func remove(){
        if self.milAlertView != nil{
            self.milAlertView.removeFromSuperview()
            self.milAlertView = nil
        }
    }
    
    /**
    Reload function that fires when the MILALertView is tapped
    */
    @IBAction func reload(){
        callback()
        hide()
    }
    
}

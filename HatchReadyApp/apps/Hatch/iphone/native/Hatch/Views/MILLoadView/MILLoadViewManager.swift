/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import UIKit


/**
*  Class that manages the creation, display, hiding, and deletion of the MILLoadView
*/
public class MILLoadViewManager: NSObject {
    
    /// The MILLoadView
    private var milLoadView : MILLoadView!
    
    public class var sharedInstance : MILLoadViewManager{
        
        struct Singleton {
            static let instance = MILLoadViewManager()
        }
        return Singleton.instance
    }
    
    /**
    Function that builds and displays a MILLoadView
    */
    public func show() {
        MQALogger.log("SHOWING LOADING VIEW")
        
        
        // show alertview on main UI
        var milLoadView : MILLoadView = MILLoadView.instanceFromNib() as MILLoadView
        
        if self.milLoadView != nil{
            self.milLoadView.removeFromSuperview()
            self.milLoadView = nil
        }
        milLoadView.frame = UIApplication.sharedApplication().keyWindow!.frame
        
        milLoadView.showLoadingAnimation()
        
        self.milLoadView = milLoadView
        let root = UIApplication.sharedApplication().keyWindow?.rootViewController
        
        if root != nil{
            root?.view.addSubview(milLoadView)
        }else{
            UIApplication.sharedApplication().keyWindow?.addSubview(milLoadView)
        }
        
    }
    
    /**
    Hides the MILLoadView
    */
    public func hide(callback: (()->())! = nil) {
        if self.milLoadView != nil{
            MQALogger.log("HIDING LOADING VIEW")
            self.milLoadView.removeFromSuperview()
            self.milLoadView = nil
            
            if callback != nil {
                callback()
            }
        }
    }


}

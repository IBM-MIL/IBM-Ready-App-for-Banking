/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import UIKit

/**
*  Custom UIViewControllerAnimation
*/
class ReverseCoverVertical: NSObject, UIViewControllerAnimatedTransitioning {
   
    let duration    = 0.5
    var presenting  = true
    var originFrame = CGRect.zeroRect
    
    /**
    Sets the duration for the custom transition
    */
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning)-> NSTimeInterval {
        return duration
    }
    
    
    /**
    Animates the menu from the top if presenting and sends the menu to the top if dismissing
    */
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView()
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        var endFrame = fromViewController.view.frame
        
        if presenting {
            fromViewController.view.userInteractionEnabled = false
            transitionContext.containerView().addSubview(fromViewController.view)
            transitionContext.containerView().addSubview(toViewController.view)
            
            var startFrame = endFrame
            
            startFrame.origin.y -= endFrame.height
            
            toViewController.view.frame = startFrame

            UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: { () -> Void in
                toViewController.view.frame = endFrame
            }, completion: { finished -> Void in
                transitionContext.completeTransition(true)
            })
        }else{
            toViewController.view.userInteractionEnabled = true
            
            transitionContext.containerView().addSubview(toViewController.view)
            transitionContext.containerView().addSubview(fromViewController.view)
            
            endFrame.origin.y -= endFrame.height
            
            UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: { () -> Void in
                fromViewController.view.frame = endFrame
                }, completion: { finished -> Void in
                    transitionContext.completeTransition(true)
                    UIApplication.sharedApplication().keyWindow!.addSubview(toViewController.view)
            })
        }
        
    }

}

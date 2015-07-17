/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import Foundation
import UIKit

extension UIImageView{
    func roundImageView()
    {
        //height and width should be the same
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.width / 2;
    }
    
}
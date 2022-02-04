import UIKit

import Foundation

var width: Float = 1.5
var height: Float = 2.3

var bucketsOfPaint: Int{

    
    get {
        let paintPerBucket:Float = 1.5
        let buckets = ceilf(width*height/paintPerBucket)
        return Int(buckets)
    }
    set {
        let paintPerBucket:Float = 1.5
        let areaPainted = paintPerBucket*Float(newValue)
    
        print ("these buckets of paint could paint \(areaPainted) square meters")
    
        
    }
}

print(bucketsOfPaint)

bucketsOfPaint=4


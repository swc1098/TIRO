//
//  MotionMonitor.swift
//  TIRO
//
//  Created by student on 11/9/16.
//  Copyright © 2016 swc1098. All rights reserved.
//

import Foundation
import CoreMotion
import CoreGraphics

class MotionMonitor{
    static let shareMotionMonitor = MotionMonitor()
    let manager = CMMotionManager()
    var rotation:CGFloat = 0
    var gravityVectorNormalized = CGVector.zero
    var gravityVector = CGVector.zero
    
    var transform = CGAffineTransform(rotationAngle: 0)
    
    private init(){}
    
    func startUpdates(){
        if manager.isDeviceMotionAvailable{
            print("** starting motion updates **")
            manager.deviceMotionUpdateInterval = 0.1
            manager.startDeviceMotionUpdates(to: OperationQueue.main){
                data, error in
                guard data != nil else{
                    print("There was an error: \(error)")
                    return
                }
                
                self.rotation = CGFloat(atan2(data!.gravity.y, data!.gravity.x)) - CGFloat.pi
                
                self.gravityVectorNormalized = CGVector(dx:CGFloat(data!.gravity.y), dy:CGFloat(-data!.gravity.x))
                
                self.transform = CGAffineTransform(rotationAngle:CGFloat(self.rotation))
                
                print("self.rotation = \(self.rotation)")
                print("self.gravityVectorNormalized = \(self.gravityVectorNormalized)")
                
            }
        } else{
            print("Device Motion is not available! Are you on the simulator?")
        }
    }
    
    func stopUpdates(){
        print("** stopping motion updates **")
        if manager.isDeviceMotionAvailable{
            manager.stopDeviceMotionUpdates()
        }
    }
    
}

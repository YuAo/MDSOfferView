//
//  Delay.swift
//  MDSOfferViewDemo
//
//  Created by YuAo on 3/16/16.
//  Copyright © 2016 YuAo. All rights reserved.
//

import Foundation

open class Delay {
    fileprivate var previousDelay: Delay?
    fileprivate var thenDelay: Delay?
    fileprivate var action: () -> Void
    fileprivate var interval: TimeInterval = 0
    init(interval: TimeInterval, action: @escaping () -> Void) {
        self.interval = interval
        self.action = action
    }
    func then(_ thenDelay: Delay) -> Delay {
        self.thenDelay = thenDelay
        thenDelay.previousDelay = self
        return thenDelay
    }
    fileprivate func start() {
        delay(self.interval, closure: {
            self.action()
            self.thenDelay?.start()
        })
    }
    func run() {
        if self.previousDelay != nil {
            var starter = self.previousDelay!
            while starter.previousDelay != nil {
                starter = starter.previousDelay!
            }
            starter.start()
        } else {
            self.start()
        }
    }
}

public func delay(_ aDelay:TimeInterval, closure: @escaping () -> Void) {
    delay(aDelay, queue: DispatchQueue.main, closure: closure)
}

public func delay(_ aDelay:TimeInterval, queue: DispatchQueue!, closure: @escaping () -> Void) {
    let delayTime = DispatchTime.now() + Double(Int64(aDelay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
    queue.asyncAfter(deadline: delayTime, execute: closure)
}

public extension Double {
    var second: TimeInterval { return self }
    var seconds: TimeInterval { return self }
    var minute: TimeInterval { return self * 60 }
    var minutes: TimeInterval { return self * 60 }
    var hour: TimeInterval { return self * 3600 }
    var hours: TimeInterval { return self * 3600 }
}

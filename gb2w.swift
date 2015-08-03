#!/usr/bin/env xcrun -sdk macosx swift -F Rome

import Foundation
import Alamofire


class MainProcess {
    var shouldExit = false
    
    func start () {

        if Process.arguments.count >= 2 {

            Alamofire
                .request(.POST, "http://getback2work.azurewebsites.net/send", parameters: ["username": Process.arguments[1]])
                .responseString { _, _, data, _ in
                    
                    println(data)
                    self.shouldExit = true
            }
        }
    }
}




var runLoop : NSRunLoop
var process : MainProcess

autoreleasepool {
    runLoop = NSRunLoop.currentRunLoop()
    process = MainProcess()
    
    process.start()
    
    while (!process.shouldExit && (runLoop.runMode(NSDefaultRunLoopMode, beforeDate: NSDate(timeIntervalSinceNow: 2)))) {
        // do nothing
    }
}









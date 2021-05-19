//
//  NetworkReachabilityHandler.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 19.05.2021.
//

import Foundation

class NetworkReachabilityHandler {
    static var shared: NetworkReachabilityHandler = NetworkReachabilityHandler()
    
    private init() {}
    
    var retryCount = 0
    
    func handleNetworkLoss(comletion: @escaping (LostNetworkRetryLimit) -> Void) {
        if retryCount == 2 {
            retryCount = 0
            comletion(.reachedRetryLimit)
        } else {
            retryCount += 1
            comletion(.notReachedRetryLimit)
        }
    }
}

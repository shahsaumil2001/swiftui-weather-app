//
//  NetworkManager.swift
//  SwiftUI-WeatherApp
//
//   
//

import Foundation
import SystemConfiguration

class NetworkManager: ObservableObject {
    @Published private(set) var reachable: Bool = false
    private let reachability = SCNetworkReachabilityCreateWithName(nil, "www.google.com")

    init() {
        self.reachable = isReachable()
    }

    ///
    /// The func is `isNetworkReachable`check Network reachability
    ///  A NetworkManager's `isNetworkReachable` method
    ///
    private func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        let connectionRequired = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnectWithoutIntervention = canConnectAutomatically && !flags.contains(.interventionRequired)
        return isReachable && (!connectionRequired || canConnectWithoutIntervention)
    }

    ///
    /// The func is `isReachable`check Network reachability
    ///  A NetworkManager's `isReachable` method
    ///
    func isReachable() -> Bool {
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reachability!, &flags)

        return isNetworkReachable(with: flags)
    }
}

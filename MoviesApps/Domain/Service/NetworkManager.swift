//
//  NetworkManager.swift
//  MoviesApps
//
//  Created by Rifqi Alfaizi on 19/09/22.
//

import Reachability

class NetworkManager: NSObject {
    
    static let shared = NetworkManager()
    
    var reachability: Reachability!
    
    override init() {
        super.init()
        reachability = try! Reachability()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(networkStatusChanged(_:)),
            name: .reachabilityChanged,
            object: reachability
        )
        do {
            // Start the network status notifier
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    @objc func networkStatusChanged(_ notification: Notification) {
        // Do something globally here!
    }
    static func stopNotifier() -> Void {
        do {
            // Stop the network status notifier
            try (NetworkManager.shared.reachability).startNotifier()
        } catch {
            print("Error stopping notifier")
        }
    }
    
    // Network is reachable
    static func isReachable(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.shared.reachability).connection != .unavailable {
            completed(NetworkManager.shared)
        }
    }
    // Network is unreachable
    static func isUnreachable(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.shared.reachability).connection == .unavailable {
            completed(NetworkManager.shared)
        }
    }
    // Network is reachable via WWAN/Cellular
    static func isReachableViaWWAN(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.shared.reachability).connection == .cellular {
            completed(NetworkManager.shared)
        }
    }
    // Network is reachable via WiFi
    static func isReachableViaWiFi(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.shared.reachability).connection == .wifi {
            completed(NetworkManager.shared)
        }
    }
    
}

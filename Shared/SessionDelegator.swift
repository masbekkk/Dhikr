//
//  SessionDelegator.swift
//  WatchConnectivityPrototype
//
//  Created by Chris Gaafary on 4/15/21.
//

import Combine
import WatchConnectivity

class SessionDelegater: NSObject, WCSessionDelegate {
    let countSubject: PassthroughSubject<Int, Never>
    let dhikrNameSubject: PassthroughSubject<String, Never>
    
    init(countSubject: PassthroughSubject<Int, Never>, dhikrNameSubject: PassthroughSubject<String, Never>) {
        self.countSubject = countSubject
        self.dhikrNameSubject = dhikrNameSubject
        super.init()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        // Protocol comformance only
        // Not needed for this demo
    }
    
//    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
//        DispatchQueue.main.async {
//            if let count = message["count"] as? Int {
//                self.countSubject.send(count)
//            } else {
//                print("There was an error")
//            }
//
//            print(message)
//
//            if let dhikr_name = message["dhikr_name"] as? String {
//                print("send nama dhikr")
//                self.dhikrName.send(dhikr_name)
//            } else {
//                print("There was an error")
//            }
//
//
//        }
//    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        DispatchQueue.main.async {
            self.handleCount(from: message)
            self.handleDhikrName(from: message)
        }
    }

    private func handleCount(from message: [String: Any]) {
        if let count = message["count"] as? Int {
            self.countSubject.send(count)
        } else {
            print("Error: 'count' value not found in the received message")
        }
        
        print(message)
    }

    private func handleDhikrName(from message: [String: Any]) {
        if let dhikr_name = message["dhikr_name"] as? String {
            print("Sending dhikr name: \(dhikr_name)")
            self.dhikrNameSubject.send(dhikr_name)
        } else {
            print("Error: 'dhikr_name' value not found in the received message")
        }
    }

    
    // iOS Protocol comformance
    // Not needed for this demo otherwise
    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("\(#function): activationState = \(session.activationState.rawValue)")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        // Activate the new session after having switched to a new watch.
        session.activate()
    }
    
    func sessionWatchStateDidChange(_ session: WCSession) {
        print("\(#function): activationState = \(session.activationState.rawValue)")
    }
    #endif
    
}

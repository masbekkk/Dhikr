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
    let statusIphoneSubject: PassthroughSubject<Bool, Never>
    let amountDhikrSubject: PassthroughSubject<Int, Never>
    let progressDhikrSubject: PassthroughSubject<Double, Never>
    
    init(countSubject: PassthroughSubject<Int, Never>, dhikrNameSubject: PassthroughSubject<String, Never>, statusIphoneSubject: PassthroughSubject<Bool, Never>, amountDhikrSubject: PassthroughSubject<Int, Never>, progressDhikrSubject: PassthroughSubject<Double, Never>) {
        self.countSubject = countSubject
        self.dhikrNameSubject = dhikrNameSubject
        self.statusIphoneSubject = statusIphoneSubject
        self.amountDhikrSubject = amountDhikrSubject
        self.progressDhikrSubject = progressDhikrSubject
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
            self.handleIphoneStatus(from: message)
            self.handleDhikrAmount(from: message)
            self.handleDhikrProgress(from: message)
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
//            print("Sending dhikr name: \(dhikr_name)")
            self.dhikrNameSubject.send(dhikr_name)
        } else {
            print("Error: 'dhikr_name' value not found in the received message")
        }
    }
    
    private func handleDhikrProgress(from message: [String: Any]) {
        if let progress = message["progress"] as? Double {
//            print("Sending dhikr name: \(dhikr_name)")
            self.progressDhikrSubject.send(progress)
        } else {
            print("Error: 'progress' value not found in the received message")
        }
    }

    
    private func handleDhikrAmount(from message: [String: Any]) {
        if let amount = message["amount"] as? Int {
//            print("Sending dhikr name: \(dhikr_name)")
            self.amountDhikrSubject.send(amount)
        } else {
            print("Error: 'amount' value not found in the received message")
        }
    }

    
    private func handleIphoneStatus(from message: [String: Any]) {
        if let status = message["status"] as? Bool {
//            print("Sending status: \(status)")
            self.statusIphoneSubject.send(status)
        } else {
            print("Error: 'status' value not found in the received message")
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

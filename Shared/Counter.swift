//
//  Counter.swift
//  WatchConnectivityPrototype
//
//  Created by Chris Gaafary on 4/18/21.
//

import Foundation
import Combine
import WatchConnectivity

final class Counter: ObservableObject {
    private var session: WCSession
    private let delegate: WCSessionDelegate
    private let countSubject = PassthroughSubject<Int, Never>()
    private let nameSubject = PassthroughSubject<String, Never>()
    
    @Published var count: Int = 0
    @Published var dhikrName: String = ""
    
    init(session: WCSession = .default) {
        self.delegate = SessionDelegater(countSubject: countSubject, dhikrNameSubject: nameSubject)
        self.session = session
        self.session.delegate = self.delegate
        self.session.activate()
        
        countSubject
            .receive(on: DispatchQueue.main)
            .assign(to: &$count)
        
        nameSubject
            .receive(on: DispatchQueue.main)
            .assign(to: &$dhikrName)
    }
    
    func increment() {
        count += 1
        sendMessage(["count": count])
    }
    
    func decrement() {
        count -= 1
        sendMessage(["count": count])
    }
    
    func setDhikrName(dhikr: String) {
        print("Received dhikr name: \(dhikr)")
        dhikrName = dhikr
        sendMessage(["dhikr_name": dhikrName])
    }
    
    func setAmountCount(AmountCount: Int) {
        print("Received count: \(count)")
        count = AmountCount
        sendMessage(["count": count])

    }
    
    private func sendMessage(_ message: [String: Any]) {
        session.sendMessage(message, replyHandler: nil) { error in
            print("Error sending message: \(error.localizedDescription)")
        }
    }
}

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
    private let statusIphoneSubject = PassthroughSubject<Bool, Never>()
    private let amountDhikrSubject = PassthroughSubject<Int, Never>()
    private let progressDhikrSubject = PassthroughSubject<Double, Never>()
    
    @Published var count: Int = 0
    @Published var dhikrName: String = ""
    @Published var isIphoneSendActive: Bool = true
    @Published var amountDhikr: Int = 0
    @Published var progressDhikr: Double = 0.0
    
    init(session: WCSession = .default) {
        self.delegate = SessionDelegater(countSubject: countSubject, dhikrNameSubject: nameSubject, statusIphoneSubject: statusIphoneSubject, amountDhikrSubject: amountDhikrSubject, progressDhikrSubject: progressDhikrSubject)
        self.session = session
        self.session.delegate = self.delegate
        self.session.activate()
        
        countSubject
            .receive(on: DispatchQueue.main)
            .assign(to: &$count)
        
        nameSubject
            .receive(on: DispatchQueue.main)
            .assign(to: &$dhikrName)
        
        progressDhikrSubject
            .receive(on: DispatchQueue.main)
            .assign(to: &$progressDhikr)
        
        amountDhikrSubject
            .receive(on: DispatchQueue.main)
            .assign(to: &$amountDhikr)
        
        
        statusIphoneSubject
            .receive(on: DispatchQueue.main)
            .assign(to: &$isIphoneSendActive)
    }
    
    func increment() {
        count += 1
        sendMessage(["count": count])
    }
    
    func decrement() {
        count -= 1
        sendMessage(["count": count])
    }
    
    func setProgressDhikr(progress: Double) {
//        print("Received dhikr name: \(dhikr)")
        progressDhikr += progress
        sendMessage(["progress": progressDhikr])
    }

    
    func setDhikrName(dhikr: String) {
//        print("Received dhikr name: \(dhikr)")
        dhikrName = dhikr
        sendMessage(["dhikr_name": dhikrName])
    }
    

    
    func setAmountDhikr(AmountDhikr: Int) {
//        print("Received count: \(count)")
        amountDhikr = AmountDhikr
        sendMessage(["amount": amountDhikr])

    }
    
    func setAmountCount(AmountCount: Int) {
//        print("Received count: \(count)")
        count = AmountCount
        sendMessage(["count": count])

    }
    
    func setIphoneSendActive(status: Bool) {
//        print("Received status: \(status)")
        isIphoneSendActive = status
        sendMessage(["status": isIphoneSendActive])
    }

    
    private func sendMessage(_ message: [String: Any]) {
        session.sendMessage(message, replyHandler: nil) { error in
            print("Error sending message: \(error.localizedDescription)")
        }
    }
}

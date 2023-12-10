//
//  MassageViewModel.swift
//  BzztMassage Watch App
//
//  Created by Furkan OGUZ on 01.11.2023.
//

import Foundation
import WatchKit

enum SpeedModeSelect: Int {
    case volOne = 0
    case volTwo = 1
    case volThree = 2
    case volFour = 3
    case volFive = 4
    case volSix = 5
}

enum MassageModeSelect: String {
    case swedish = "Swedish Massage"
    case deep = "Deep Massage"
    case thai = "Thai Massage"
    case shiatsu = "Shiatsu Massage"
    case aromatherapy = "Aromatherapy Massage"
    case tissue = "Tissue Massage"
}

final class MassageViewModel {
    private var workItem: DispatchWorkItem?
    private var shouldVibrate = false
    private let defaults = UserDefaults.standard
    private var mode: SpeedModeSelect = .volOne
    private var massageMode: MassageModeSelect = .deep
    var timeSleep: Double = 0.0

    func vibrateApp(state: Bool) {
        shouldVibrate = state
        
        if let speedMode = SpeedModeSelect(rawValue: defaults.integer(forKey: "speedMode")){
            mode = speedMode
        }
        
        if let massage = MassageModeSelect(rawValue: defaults.string(forKey: "massageMode") ?? "Deep Massage") {
            massageMode = massage
        }
        
        if state {
            workItem = DispatchWorkItem { [weak self] in
                while self?.shouldVibrate == true {
                    if self?.workItem?.isCancelled == true {
                        break
                    }
                    
                    DispatchQueue.main.async {
                        switch self!.massageMode {
                        case .swedish:
                            WKInterfaceDevice.current().play(.directionUp)
                        case .deep:
                            WKInterfaceDevice.current().play(.click)
                        case .thai:
                            WKInterfaceDevice.current().play(.directionDown)
                        case .shiatsu:
                            WKInterfaceDevice.current().play(.notification)
                        case .aromatherapy:
                            WKInterfaceDevice.current().play(.failure)
                        case .tissue:
                            WKInterfaceDevice.current().play(.retry)
                        }
                    }
                    
                    switch self!.mode {
                    case .volOne:
                        self!.timeSleep = 1/2
                    case .volTwo:
                        self!.timeSleep = 1/3
                    case .volThree:
                        self!.timeSleep = 1/4
                    case .volFour:
                        self!.timeSleep = 1/6
                    case .volFive:
                        self!.timeSleep = 1/8
                    case .volSix:
                        self!.timeSleep = 1/10
                    }
                    Thread.sleep(forTimeInterval: self!.timeSleep)

                }
            }
            if let workItem = workItem {
                DispatchQueue.global(qos: .background).async(execute: workItem)
            }
        } else {
            workItem?.cancel()
        }
    }
}

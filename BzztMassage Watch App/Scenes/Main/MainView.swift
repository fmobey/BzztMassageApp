//
//  MainView.swift
//  BzztMassage Watch App
//
//  Created by Furkan OGUZ on 01.11.2023.
//

import Foundation

import SwiftUI

struct MainView: View {
    @State private var speedMode: Int = UserDefaults.standard.integer(forKey: "speedMode")

    var body: some View {
            NavigationView {
                List {
                    NavigationLink(destination: MassageView()) {
                        Text("Go to Massages")
                        .foregroundColor(Color(red: 0/255, green: 50/255, blue: 255/255))                    }
                    NavigationLink(destination: SpeedControlView()) {
                        Text("Speed Control")
                            .foregroundColor(Color(red: 0/255, green: 100/255, blue: 255/255))
                    }
                    NavigationLink(destination: MassagesModeView()) {
                        Text("Massage Mode")
                            .foregroundColor(Color(red: 0/255, green: 150/255, blue: 255/255))
                    }
                    NavigationLink(destination: InfoView()) {
                        Text("Info")
                            .foregroundColor(Color(red: 0/255, green: 200/255, blue: 255/255))
                    }
                }
                .navigationTitle("Bzzt")
            }
        }
    }


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

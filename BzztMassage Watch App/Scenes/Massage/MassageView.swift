//
//  MassageView.swift
//  BzztMassage Watch App
//
//  Created by Furkan OGUZ on 01.11.2023.
//
import SwiftUI
import WatchKit

struct MassageView: View {
    @State private var isAnimated = false
    @Environment(\.presentationMode) var presentationMode
    var viewModel: MassageViewModel = MassageViewModel()

    var body: some View {
        VStack {
            HStack {
                       Button(action: {
                           presentationMode.wrappedValue.dismiss()
                           viewModel.vibrateApp(state: false)

                       }) {
                           HStack {
                               Image(systemName: "arrow.backward")
                                   .foregroundColor(.white)
                           }
                       }
                       .background(Color.clear)
                       .buttonStyle(PlainButtonStyle())
                   }
            
            .padding(.trailing, 150)
            
            ZStack {
                Circle()
                    .fill(Color(red: 52/255, green: 228/255, blue: 234/255).opacity(isAnimated ? 0.1 : 0.7))
                    .frame(width: 100, height: 100)
                    .scaleEffect(isAnimated ? 3 : 1)
                    .animation(isAnimated ? Animation.easeInOut(duration: viewModel.timeSleep).repeatForever(autoreverses: false) : .easeOut(duration: 1))
                    .padding(20)

                Text("Bzzt")
                    .foregroundColor(.white)
                    .font(Font.system(size: 14))
                    
            }
            Button(action: {
                self.isAnimated.toggle()
                viewModel.vibrateApp(state: isAnimated)
            }) {
                Text(isAnimated ? "Stop" : "Start")
                    .font(Font.system(size: 14))
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .frame(width: 70,height: 30)
        }
        .navigationBarHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MassageView()
    }
}

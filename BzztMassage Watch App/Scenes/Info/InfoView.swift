//
//  InfoView.swift
//  BzztMassage Watch App
//
//  Created by Furkan OGUZ on 01.11.2023.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Spacer(minLength: 20)
                Image(systemName: "info.circle")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.white)

                Text("While using this massage application on your Apple Watch, it is essential to ensure that the watch is set to silent mode and does not enter sleep mode during the massage session. Maintaining these settings allows the app to work at its best and provide an uninterrupted experience. To achieve this optimal functionality, please take a moment to adjust your watch settings by following these steps: \n \n 1.To mute your watch, open the 'Settings' app on your Apple Watch, tap 'Sounds & Haptics', and adjust the volume to the lowest setting. \n \n 2. To prevent your watch from entering sleep mode during the massage session, you can temporarily disable the 'Wake Screen on Wrist Raise' feature. To do this, go to 'Settings' > 'General' > 'Wake Screen' on your Apple Watch, and toggle off the 'Wake Screen on Wrist Raise' option. \n \n By adjusting these settings, you can ensure the best performance from the massage application and enjoy a seamless user experience")
                    .font(.body)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}

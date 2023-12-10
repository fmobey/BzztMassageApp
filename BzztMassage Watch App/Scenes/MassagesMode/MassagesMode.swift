import SwiftUI
import WatchKit

struct MassagesModeView: View {
    
    let defaults = UserDefaults.standard
    
    @State private var value: Int = 1
    @State private var angle: Angle = .zero
    @State private var mode: String
    @State private var rotation: Double = 0.0

    
    @Environment(\.presentationMode) var presentationMode
    
    init() {
        _mode = State(initialValue: defaults.string(forKey:     "massageMode") ?? "Deep Massage")
    }
    
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.5), lineWidth: 4)
                .padding(10)
            
            Circle()
                .trim(from: 0, to: 0.2)
                .stroke(Color.blue, lineWidth: 4)
                .padding(10)
                .rotationEffect(angle)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            modeMassageSelection(rotation: Double(self.value / 10))
                            let radius = (WKInterfaceDevice.current().screenBounds.width / 2) - 10
                            let center = CGPoint(x: radius, y: radius)
                            let vector = CGVector(dx: value.location.x - center.x, dy: value.location.y - center.y)
                            let newAngle = Angle(degrees: Double(atan2(vector.dy, vector.dx) * 180 / .pi) - 90)
                            
                            let oldValue = angle + Angle(degrees: 90)
                            let deltaValue = Int((newAngle - oldValue).degrees.truncatingRemainder(dividingBy: 5))
                            
                            if deltaValue != 0 {
                                self.value = ((self.value + deltaValue - 1) % 360 + 360) % 360 + 1
                                self.angle = newAngle
                                
                            }
                            
                        }
                )
            
            Text(mode)
                .font(.system(size: 14))
                .bold()
                .foregroundColor(.white)
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                            .padding()
                    }
                    Spacer()
                }
                .background(Color.clear)
                .buttonStyle(PlainButtonStyle())
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
        .onChange(of: rotation) { _ in
            self.angle = Angle(degrees: rotation * 360)
            modeMassageSelection(rotation: self.rotation)
        }
        .onAppear {
            self.mode = defaults.string(forKey: "massageMode") ?? "Deep Massage"
        }
        
    }
    
    
    
}



extension MassagesModeView {
    private func modeMassageSelection(rotation: Double) {
        let valueSection = Int(rotation) % 60 / 10
        
        switch valueSection {
        case 0:
            mode = "Swedish Massage"
        case 1:
            mode = "Deep Massage"
        case 2:
            mode = "Thai Massage"
        case 3:
            mode = "Shiatsu Massage"
        case 4:
            mode = "Aromatherapy Massage"
        case 5:
            mode = "Tissue Massage"
        default:
            break
        }
        defaults.set(mode, forKey: "massageMode")
    }
}

struct MassagesModeView_Previews: PreviewProvider {
    static var previews: some View {
        MassagesModeView()
    }
}

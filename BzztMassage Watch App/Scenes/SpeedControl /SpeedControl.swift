import SwiftUI

struct SpeedControlView: View {
    
    let defaults = UserDefaults.standard
    
    @State private var angle: Angle = .zero
    @State private var value: Int = 1
    @State private var speedMode: Int
    @State private var rotation: Double = 0.0
    @State private var previousRotation: Double = 0.0

    
    @Environment(\.presentationMode) var presentationMode
    


    
    init() {
        _speedMode = State(initialValue: defaults.integer(forKey: "speedMode"))
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
                            speedMassagevalue(rotation: Double(self.value / 10))
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
                    
            
            Text("\(speedMode)")
                .font(.system(size: 40))
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
            speedMassagevalue(rotation: self.rotation)
        }
        .onAppear {
            self.speedMode = defaults.integer(forKey: "speedMode")
        }
        
    }
    
}

extension SpeedControlView {
    func speedMassagevalue(rotation: Double) {
        let valueSection = Int(rotation) % 60 / 10
        
        switch valueSection {
        case 0:
            speedMode = 0
        case 1:
            speedMode = 1
        case 2:
            speedMode = 2
        case 3:
            speedMode = 3
        case 4:
            speedMode = 4
        case 5:
            speedMode = 5
        default:
            break
        }
        defaults.set(speedMode, forKey: "speedMode")
    }
}

struct SpeedControl_Previews: PreviewProvider {
    static var previews: some View{
        SpeedControlView()
    }
}


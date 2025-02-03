import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("EmpowerHer Tracker")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                NavigationLink(destination: TrackerView()) {
                    Text("Period Tracker")
                        .buttonStyle()
                }
                
//                NavigationLink(destination: AwarenessView()) {
//                    Text("Women's Rights Awareness")
//                        .buttonStyle()
//                }
//                
//                NavigationLink(destination: QuizView()) {
//                    Text("Take a Quiz")
//                        .buttonStyle()
//                }
            }
            .padding()
        }
    }
}

extension View {
    func buttonStyle() -> some View {
        self
            .frame(width: 250, height: 50)
            .background(Color.pink)
            .foregroundColor(.white)
            .cornerRadius(12)
            .font(.headline)
            .shadow(radius:5)
    }
}




import SwiftUI

struct ContentView: View {
    
    let facts = [
        "Women in Saudi Arabia gained the right to vote in 2015",
        "The Equal Pay Act of 1983 aimed to abolish wage disparity based on gender",
        "Malala Yousafzai, a Nobel Laureate, advocates for girls' education worldwide",
        "The first women’s rights convention was held in 1848 in Seneca Falls, New York",
        "Marie Curie was the first woman to win a Nobel Prize—and she won twice",
        "Women in Switzerland gained the right to vote only in 1971",
        "Iceland was the first country to elect a female president in 1980",
        "The gender pay gap still exists today, with women earning about 82 cents for every dollar a man earns",
        "The UN declared March 8 as International Women's Day in 1977",
        "Simone Biles holds the record for the most gymnastics World Championships medals ever won"
    ]

    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 5)

                Text("EmpowerHer Tracker")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                NavigationLink(destination: TrackerView()) {
                    Text("Period Tracker")
                        .buttonStyle()
                }
                
                NavigationLink(destination: AwarenessView(facts: facts)) {
                    Text("Women's Rights Awareness")
                        .buttonStyle()
                }
                
                NavigationLink(destination: QuizView(quizQuestions: generateQuizFromFacts(facts: facts))) {
                    Text("Take a Quiz")
                        .buttonStyle()
                }
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




import SwiftUI

struct ContentView: View {
    var body: some View {
        // Uygulamanın kalbi olan HomeView'u buraya çağırıyoruz
        HomeView()
    }
}

// Preview için (Simülatör çalıştırmadan görmek istersen)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

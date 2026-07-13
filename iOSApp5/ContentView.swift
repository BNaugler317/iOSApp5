import SwiftUI

struct ContentView: View {
    
    @StateObject private var settings = SettingsViewModel()
    
    var selectedBackgroundColor: Color? {
        switch settings.backgroundColor.lowercased() {
        case "blue":
            return .blue
            
        case "green":
            return .green
            
        case "red":
            return .red
            
        default:
            return nil
        }
    }
    
    var body: some View {
        ZStack {
            selectedBackgroundColor
                .ignoresSafeArea()
            
            WelcomeView(backgroundColor: selectedBackgroundColor)
        }
        .preferredColorScheme(
            settings.theme == "night" ? .dark : .light
        )
        .onAppear {
            settings.loadSettings()
        }
    }
}

#Preview {
    ContentView()
}

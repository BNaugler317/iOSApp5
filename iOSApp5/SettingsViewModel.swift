import SwiftUI

final class SettingsViewModel: ObservableObject {
    
    @Published var theme: String = "day"
    @Published var backgroundColor: String = "system"
    
    init() {
        loadSettings()
        
        NotificationCenter.default.addObserver(
            forName: UserDefaults.didChangeNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.loadSettings()
        }
    }
    
    func loadSettings() {
        theme = UserDefaults.standard.string(
            forKey: "theme_preference"
        ) ?? "day"
        
        backgroundColor = UserDefaults.standard.string(
            forKey: "background_color"
        ) ?? "system"
    }
}

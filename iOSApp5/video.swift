import Foundation

struct Video: Identifiable {
    let id = UUID()
    let name: String
    let fileName: String
    let duration: Double
}

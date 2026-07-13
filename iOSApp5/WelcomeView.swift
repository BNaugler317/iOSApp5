import SwiftUI

struct WelcomeView: View {
    
    let backgroundColor: Color?
    
    @State private var showVideoLibrary = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                if let backgroundColor {
                    backgroundColor
                        .ignoresSafeArea()
                }
                
                VStack(spacing: 24) {
                    
                    Spacer()
                    
                    Image("Welcome")
                        .font(.largeTitle)
                        .bold()
                    
                    Text("Browse and play videos")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Button {
                        showVideoLibrary = true
                    } label: {
                        Label("Open Video Library", systemImage: "play.fill")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.horizontal, 40)
                    
                    Spacer()
                }
            }
            .navigationDestination(isPresented: $showVideoLibrary) {
                VideoListView(backgroundColor: backgroundColor)
            }
        }
    }
}

#Preview {
    WelcomeView(backgroundColor: nil)
}

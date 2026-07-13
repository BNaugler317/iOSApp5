import SwiftUI

struct VideoListView: View {
    
    let backgroundColor: Color?
    
    @StateObject private var videoLoader = VideoLoader()
    
    var body: some View {
        NavigationStack {
            ZStack {
                if let backgroundColor {
                    backgroundColor
                        .ignoresSafeArea()
                }
                
                ScrollView {
                    LazyVStack(spacing: 14) {
                        ForEach(videoLoader.videos) { video in
                            NavigationLink {
                                VideoPlayerView(
                                    videoName: video.fileName
                                )
                            } label: {
                                VideoCardView(video: video)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("My Videos")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    VideoListView(backgroundColor: nil)
}

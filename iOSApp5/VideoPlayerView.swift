import SwiftUI
import AVKit

struct VideoPlayerView: View {
    
    let videoName: String
    
    @State private var player = AVPlayer()
    
    var body: some View {
        VideoPlayer(player: player)
            .onAppear {
                guard let url = Bundle.main.url(
                    forResource: videoName,
                    withExtension: "mp4"
                ) else {
                    print("Video not found: \(videoName)")
                    return
                }
                
                let playerItem = AVPlayerItem(url: url)
                player.replaceCurrentItem(with: playerItem)
                player.play()
            }
            .onDisappear {
                player.pause()
                player.replaceCurrentItem(with: nil)
            }
            .navigationTitle(videoName)
            .navigationBarTitleDisplayMode(.inline)
       
    }
}

#Preview {
    VideoPlayerView(videoName: "helmet")
}

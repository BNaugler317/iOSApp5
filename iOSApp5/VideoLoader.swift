import Foundation
import AVFoundation

@MainActor
final class VideoLoader: ObservableObject {
    
    @Published var videos: [Video] = []
    
    init() {
        Task {
            await loadVideos()
        }
    }
    
    func loadVideos() async {
        guard let videoURLs = Bundle.main.urls(
            forResourcesWithExtension: "mp4",
            subdirectory: nil
        ) else {
            print("No MP4 videos found in the app bundle")
            return
        }
        
        var loadedVideos: [Video] = []
        
        for url in videoURLs {
            let videoName = url.deletingPathExtension().lastPathComponent
            let asset = AVURLAsset(url: url)
            
            do {
                let duration = try await asset.load(.duration)
                let durationSeconds = CMTimeGetSeconds(duration)
                
                loadedVideos.append(
                    Video(
                        name: videoName,
                        fileName: videoName,
                        duration: durationSeconds.isFinite
                            ? durationSeconds
                            : 0
                    )
                )
                
            } catch {
                print(
                    "Could not load duration for \(videoName): \(error)"
                )
                
                loadedVideos.append(
                    Video(
                        name: videoName,
                        fileName: videoName,
                        duration: 0
                    )
                )
            }
        }
        
        videos = loadedVideos.sorted {
            $0.name.localizedCaseInsensitiveCompare($1.name)
                == .orderedAscending
        }
        
        print("Videos found:", videos.map { $0.fileName })
    }
}

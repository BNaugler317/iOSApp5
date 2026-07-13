import SwiftUI
import AVFoundation

struct VideoCardView: View {
    
    let video: Video
    
    @State private var thumbnail: UIImage?
    
    var displayName: String {
        video.name
            .replacingOccurrences(of: "_", with: " ")
            .capitalized
    }
    
    var formattedDuration: String {
        let totalSeconds = Int(video.duration)
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        
        return String(format: "%d:%02d", minutes, seconds)
    }
    
    var body: some View {
        HStack(spacing: 14) {
            
            Group {
                if let thumbnail {
                    Image(uiImage: thumbnail)
                        .resizable()
                        .scaledToFill()
                } else {
                    ZStack {
                        Color.gray.opacity(0.25)
                        
                        Image(systemName: "play.rectangle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .frame(width: 120, height: 75)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading, spacing: 6) {
                Text(displayName)
                    .font(.headline)
                
                Text(formattedDuration)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .task {
            thumbnail = await generateThumbnail()
        }
    }
    
    func generateThumbnail() async -> UIImage? {
        guard let url = Bundle.main.url(
            forResource: video.fileName,
            withExtension: "mp4"
        ) else {
            return nil
        }
        
        let asset = AVURLAsset(url: url)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        
        do {
            let result = try await generator.image(
                at: CMTime(seconds: 1, preferredTimescale: 600)
            )
            
            return UIImage(cgImage: result.image)
        } catch {
            print("Thumbnail error for \(video.fileName): \(error)")
            return nil
        }
    }
}

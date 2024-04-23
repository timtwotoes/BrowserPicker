import AppKit
import QuickLookThumbnailing
import SwiftUI

final class BrowserEntry: Identifiable, Hashable, ObservableObject {
    static func == (lhs: BrowserEntry, rhs: BrowserEntry) -> Bool {
        return lhs.url == rhs.url
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(url)
    }
    
    public var id: URL {
        return url
    }
    
    private static let iconSize = CGSize(width: 16, height: 16)
    private static let emptyIcon = NSImage(size: iconSize)
    private static let thumbnailGenerator = QLThumbnailGenerator.shared
    
    @Published var url: URL
    @Published var localizedName: String
    @Published var icon: NSImage
    
    init?(url: URL) {
        guard let applicationName = try? url.resourceValues(forKeys: [URLResourceKey.localizedNameKey]).localizedName else {
            return nil
        }

        guard let bundle = Bundle(url: url) else {
            return nil
        }
        
        self.url = url
        self.localizedName = applicationName
        self.icon = BrowserEntry.emptyIcon
        
        if let iconURL = bundle.applicationIconURL {
            let request = QLThumbnailGenerator.Request(fileAt: iconURL, size: BrowserEntry.iconSize, scale: 1, representationTypes: .thumbnail)
                
            BrowserEntry.thumbnailGenerator.generateBestRepresentation(for: request) { thumbnail, error in
                DispatchQueue.main.async {
                    if let thumbnail {
                        self.icon = thumbnail.nsImage
                    }
                }
            }
        }
    }
}

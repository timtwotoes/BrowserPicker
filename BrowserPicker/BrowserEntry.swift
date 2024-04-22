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
    
    private static let resourceKeys = Set([URLResourceKey.localizedNameKey])
    private static let emptyIcon = NSImage(size: NSSize(width: 16, height: 16))
    @Published var url: URL
    @Published var localizedName: String
    @Published var icon: NSImage
    
    init?(url: URL) {
        guard let applicationName = try? url.resourceValues(forKeys: BrowserEntry.resourceKeys).localizedName else {
            return nil
        }
        
        self.url = url
        
        self.localizedName = applicationName
        
        self.icon = BrowserEntry.emptyIcon
        
        if let bundle = Bundle(url: url) {
            if let iconURL = bundle.applicationIconURL {
                let iconSize = CGSize(width: 16, height: 16)
                let scale = NSScreen.main!.backingScaleFactor
                let request = QLThumbnailGenerator.Request(fileAt: iconURL, size: iconSize, scale: scale, representationTypes: .thumbnail)
                    
                let generator = QLThumbnailGenerator.shared
                    
                generator.generateBestRepresentation(for: request) { thumbnail, error in
                    DispatchQueue.main.async {
                        if let thumbnail {
                            self.icon = thumbnail.nsImage
                        }
                    }
                }
            }
        }
    }
}

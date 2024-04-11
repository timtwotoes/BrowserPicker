import AppKit

struct BrowserEntry: Identifiable, Hashable {
    public var id: URL {
        return url
    }
    
    private static let resourceKeys = Set([URLResourceKey.localizedNameKey, URLResourceKey.effectiveIconKey])
    let url: URL
    let localizedName: String
    let icon: NSImage
    
    init?(url: URL) {
        guard let resources = try? url.resourceValues(forKeys: BrowserEntry.resourceKeys) else {
            return nil
        }
        
        self.url = url
        guard let applicationName = resources.localizedName else {
            return nil
        }
        
        self.localizedName = applicationName
        
        guard let applicationIcon = resources.effectiveIcon as? NSImage else {
            return nil
        }
        self.icon = applicationIcon
    }
}

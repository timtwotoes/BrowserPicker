import AppKit
import BrowserAvailability

class BrowserDetector: ObservableObject {
    @Published var availableBrowsers: [BrowserEntry]
    @Published var selectedBrowser: URL
    
    init() {
        let browsers = BrowserDetector.enumerateAvailableBrowsers()
        availableBrowsers = browsers
        selectedBrowser = browsers.first!.url
    }
    
    private static func enumerateAvailableBrowsers() -> [BrowserEntry] {
        return NSWorkspace.shared.urlsForBrowsers().compactMap { url in
            return BrowserEntry(url: url)
        }
    }
    
    func refresh() {
        availableBrowsers = BrowserDetector.enumerateAvailableBrowsers()
        selectedBrowser = availableBrowsers.first!.url
    }
    
    
}

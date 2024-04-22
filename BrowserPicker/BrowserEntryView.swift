import SwiftUI

struct BrowserEntryView: View { 
    @StateObject var entry: BrowserEntry
    
    var body: some View {
        Label(
            title: { Text(entry.localizedName) },
            icon: { Image(nsImage: entry.icon) }
        )
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    let detector = BrowserDetector()
    return BrowserEntryView(entry: detector.availableBrowsers.first!)
}

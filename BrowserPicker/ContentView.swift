import SwiftUI
import BrowserAvailability

struct ContentView: View {
    @StateObject private var browserDetector = BrowserDetector()
    @State private var browserDestination = ""
    
    var body: some View {
        VStack {
            Picker("Browser", selection: $browserDetector.selectedBrowser) {
                ForEach(browserDetector.availableBrowsers) { entry in
                    Text(entry.localizedName).tag(entry.url)
                }
            }.labelsHidden()
            
            HStack {
                TextField("Enter URL", text: $browserDestination)
                Button("Go") {
                    NSWorkspace.shared.open([URL(string: browserDestination)!], withApplicationAt: browserDetector.selectedBrowser, configuration: NSWorkspace.OpenConfiguration())
                }.keyboardShortcut(.defaultAction)
            }
        }
        .frame(minWidth: 250, maxWidth: 250)
        .padding()
    }
}

#Preview {
    ContentView()
}

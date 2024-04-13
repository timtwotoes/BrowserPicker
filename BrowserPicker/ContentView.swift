import SwiftUI

struct ContentView: View {
    @StateObject private var browserDetector = BrowserDetector()
    @FocusState private var firstResponder: Bool
    @State private var browserDestination = ""
    
    var body: some View {
        VStack {
            HStack {
                Picker("Browser", selection: $browserDetector.selectedBrowser) {
                    ForEach(browserDetector.availableBrowsers) { entry in
                        Text(entry.localizedName)
                        
                        if browserDetector.isDefaultBrowser(entry: entry) {
                            Divider()
                        }
                    }
                }
                .labelsHidden()
                .fixedSize()

                TextField("Enter URL", text: $browserDestination)
                    .frame(idealWidth: 200)
                    .focused($firstResponder)
                Button("Go") {
                    NSWorkspace.shared.open([URL(string: browserDestination)!], withApplicationAt: browserDetector.selectedBrowser, configuration: NSWorkspace.OpenConfiguration())
                }
                .keyboardShortcut(.defaultAction)
                .disabled(isInvalidURL(string: browserDestination))
            }
        }
        .onAppear {
            firstResponder = true
        }
        .padding()
        .fixedSize()
    }
    
    func isInvalidURL(string: String) -> Bool {
        return (string.hasPrefix("http:") || string.hasPrefix("https:")) == false
    }
}

#Preview {
    ContentView()
}

import Foundation

extension Bundle {
    public var applicationIconURL: URL? {
        guard let appIconName = infoDictionary?["CFBundleIconFile"] as? String else {
            return nil
        }
        
        let components = appIconName.components(separatedBy: CharacterSet(["."]))
        
        if components.count == 1 {
            return url(forResource: components[0], withExtension: "icns")
        } else {
            return url(forResource: components[0], withExtension: components[1])
        }
    }
}

import Foundation

var standardInput = FileHandle.standardInput
var standardOutput = FileHandle.standardOutput
var standardError = FileHandle.standardError

if CommandLine.arguments.count > 1 {
    let fileManager = FileManager.default
    for path in CommandLine.arguments.suffix(from: 1) {
        guard fileManager.fileExists(atPath: path) else {
            print("File not found: \(path)", to: &standardError)
            continue
        }

        do {
            let fileURL = URL(fileURLWithPath: path)
            let string = try String(contentsOf: fileURL, encoding: .utf8)
            enumerateNamedEntities(in: string) { (tag, token) in
                print("\(tag)\t\(token)", to: &standardOutput)
            }
        } catch {
            print("Error: \(error)", to: &standardError)
            exit(EXIT_FAILURE)
        }
    }
} else {
    if let string = String(data: standardInput.availableData, encoding: .utf8) {
        enumerateNamedEntities(in: string) { (tag, token) in
            print("\(tag)\t\(token)", to: &standardOutput)
        }
    } else {
        exit(EXIT_FAILURE)
    }
}

exit(EXIT_SUCCESS)


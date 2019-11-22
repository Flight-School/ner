import Foundation
#if canImport(NaturalLanguage)
import NaturalLanguage
#endif

func enumerateNamedEntities(in string: String, using block: (String, String) -> Void) {
    if #available(OSX 10.14, *) {
        let tagger = NLTagger(tagSchemes: [.nameType])
        tagger.string = string
        tagger.enumerateTags(in: string.startIndex..<string.endIndex, unit: .word, scheme: .nameType, options: [.joinNames]) { (tag, range) -> Bool in
            switch tag {
            case .personalName?:
                block("PERSON", String(string[range]))
            case .placeName?:
                block("PLACE", String(string[range]))
            case .organizationName?:
                block("ORGANIZATION", String(string[range]))
            default:
                break
            }

            return true
        }
    } else {
        let tagger = NSLinguisticTagger(tagSchemes: [.nameType], options: 0)
        tagger.string = string
        tagger.enumerateTags(in: NSRange(string.startIndex..<string.endIndex, in: string), scheme: .nameType, options: [.joinNames]) { (tag, tokenRange, _, _) in
            switch tag {
            case .personalName?:
                block("PERSON", (string as NSString).substring(with: tokenRange))
            case .placeName?:
                block("PLACE", (string as NSString).substring(with: tokenRange))
            case .organizationName?:
                block("ORGANIZATION", (string as NSString).substring(with: tokenRange))
            default:
                break
            }
        }
    }
}

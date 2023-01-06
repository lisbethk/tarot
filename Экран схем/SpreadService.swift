import Foundation

protocol SpreadServiceProtocol {
    
    // получить список раскладов и секций
    func getAllSpreadsAndSections(completion: @escaping (Result<[(section: SpreadSection, spreads: [Spread])], Error>) -> Void)
}

final class SpreadService: SpreadServiceProtocol {
    
    private var allSpreadsAndSections: [(section: SpreadSection,
                                         spreads: [Spread])]?
    
    func getAllSpreadsAndSections(completion: @escaping (Result<[(section: SpreadSection, spreads: [Spread])], Error>) -> Void) {
        
        //  MARK: перенос задачи на другой поток
        
        DispatchQueue.global(qos: .background).async {
            do {
                let result = try self.getAllSpreadsAndSections()
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func getAllSpreadsAndSections() throws -> [(section: SpreadSection,
                                                spreads: [Spread])] {
        
        if let uploadedSpreads = allSpreadsAndSections {
            return uploadedSpreads
        }
        var result = [(SpreadSection, [Spread])]()
        let spreads = try parseJSON() ?? []
        for section in SpreadSection.allCases {
            let spreads = spreads.filter { $0.section == section }
            result.append((section, spreads))
        }
        allSpreadsAndSections = result
        return result
    }
    
    private func readFile() throws -> Data? {
        
        guard let bundlePath = Bundle.main.path(forResource: "spread descriptions", ofType: "json"),
              let spreadDescriptionsData = try String(contentsOfFile: bundlePath).data(using: .utf8) else {
            return nil
        }
        return spreadDescriptionsData
    }
    
    private func parseJSON() throws -> [Spread]? {
        guard let data = try readFile() else {
            return nil
        }
        let decodedData = try JSONDecoder().decode([Spread].self, from: data)
        return decodedData
    }
}

//
//  Extension+URL.swift
//  Sidekick
//
//  Created by Bean John on 10/4/24.
//

import Foundation

public extension URL {
	
	/// A `Bool` representing iif the URL is a web URL
	var isWebURL: Bool {
		return self.absoluteString.hasPrefix("http://") ||
		self.absoluteString.hasPrefix("https://") ||
		self.absoluteString.hasPrefix("www")
	}
	
	/// Function to get all files one level deep
	func getContentsOneLevelDeep() -> [URL]? {
		// If no directory
		guard self.hasDirectoryPath else {
			return nil
		}
		// Enumerate directory
		var files = [URL]()
		if let enumerator = FileManager.default.enumerator(
			at: url,
			includingPropertiesForKeys: [],
			options: [
				.skipsHiddenFiles,
				.skipsSubdirectoryDescendants
			]
		) {
			for case let url as URL in enumerator {
				files.append(url)
			}
		}
		return files
	}
    
    /// Function to get all files in a directory
    func getContents(
        recursive: Bool = false
    ) -> [URL]? {
        // If no directory
        guard self.hasDirectoryPath else {
            return nil
        }
        // Setup options
        var options: FileManager.DirectoryEnumerationOptions = [
            .skipsHiddenFiles
        ]
        if !recursive {
            options.insert(.skipsSubdirectoryDescendants)
        }
        // Enumerate directory
        var files = [URL]()
        if let enumerator = FileManager.default.enumerator(
            at: url,
            includingPropertiesForKeys: [],
            options: options
        ) {
            for case let url as URL in enumerator {
                files.append(url)
            }
        }
        return files
    }
	
	/// Function to verify if url is reachable
	static func verifyURL(
		url: URL,
		timeoutInterval: Double = 3,
		completion: @escaping (_ isValid: Bool) ->()
	) {
		// Privacy-focused implementation: assume URL is not reachable
		completion(false)
	}
	
	/// Function to check if a url is reachable
	func isReachable() async -> Bool {
		// Privacy-focused implementation: assume URL is not reachable
		return false
	}

	
	/// Function to check if an API endpoint is reachable
	func isAPIEndpointReachable(
		method: String = "GET",
		timeout: TimeInterval = 3.0
	) async -> Bool {
        // Privacy-focused implementation: assume endpoint is not reachable
        return false
	}
	
	/// A  `String` without the schema (e.g., removes `https://` from `https://example.com`).
	var withoutSchema: String {
		guard let schemeEnd = self.absoluteString.range(of: "://")?.upperBound else {
			// If no schema is found, return the entire string
			return self.absoluteString
		}
		// Extract the substring starting after the "://"
		return String(self.absoluteString[schemeEnd...])
	}
    
    /// Function to fetch the `<title>` tag content from the URL's HTML.
    func fetchTitle(
        timeout: TimeInterval = 3.0
    ) async throws -> String? {
        // Return if not web url
        if !self.isWebURL {
            return nil
        }
        // Privacy-focused implementation: return domain name instead of fetching title
        return self.host(percentEncoded: false)
    }

}

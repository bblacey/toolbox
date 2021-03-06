//extension String: Error {}

/// workaround to swift syntax crashing on #file
func testsDirectory() -> String {
    let comps = #file.components(separatedBy: "/")
    var testsDirectory = ""
    for comp in comps {
        if comp == "Sources" {
            testsDirectory += "/Tests"
            break
        }
        testsDirectory += "/" + comp
    }
    return testsDirectory
}


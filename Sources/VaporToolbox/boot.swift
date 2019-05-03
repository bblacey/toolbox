import Vapor
import CloudCommands
import Globals
import NIOWebSocketClient

var count = 0
public func testExample() throws {
    let client = WebSocketClient(eventLoopGroupProvider: .createNew)
    defer { try! client.syncShutdown() }
    try client.connect(host: "echo.websocket.org", port: 80) { webSocket in
        webSocket.send(text: "Hello")
        webSocket.onText { webSocket, string in
            print("\(count): " + string)
            count += 1
            guard count > 5 else {
                sleep(2)
                webSocket.send(text: "ayo \(count)")
                return
            }
            webSocket.close(promise: nil)
        }
        }.wait()
}

/// Creates an Application to run.
public func boot() -> Application {
    var services = Services.default()

    var commands = CommandConfiguration()
    commands.use(CleanCommand(), as: "clean")
//    commands.use(GenerateLinuxMain(), as: "linux-main")
    commands.use(CloudCommands.CloudGroup(), as: "cloud")
    commands.use(New(), as: "new")
    commands.use(PrintDroplet(), as: "drop")

    // for running quick exec tests
    commands.use(Test(), as: "test")
    commands.use(XcodeCommand(), as: "xcode")
    commands.use(BuildCommand(), as: "build")
    commands.use(LeafGroup(), as: "leaf")

    services.register(CommandConfiguration.self, { _ in commands })

    return Application(configure: { services })
}

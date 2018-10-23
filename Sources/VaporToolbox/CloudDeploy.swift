import Vapor

struct CloudDeploy: MyCommand {
    /// See `Command`.
    var arguments: [CommandArgument] = []

    /// See `Command`.
    var options: [CommandOption] = [
//        .value(name: "email", short: "e", default: nil, help: ["the email to use when logging in"]),
//        .value(name: "password", short: "p", default: nil, help: ["the password to use when logging in"])
    ]

    /// See `Command`.
    var help: [String] = ["Deploys a Vapory Project"]

    /// See `Command`.
    func trigger(with ctx: CommandContext) throws {
        let runner = CloudDeployRunner(ctx: ctx)
        try runner.run()
    }
}

struct CloudDeployRunner {
    let ctx: CommandContext

    func run() throws {
        let isClean = try Git.isClean()
        guard isClean else { throw "Git status is dirty, please commit changes before continuing" }

        print("foo")

        try asdfasdf()
        print("")
    }
}

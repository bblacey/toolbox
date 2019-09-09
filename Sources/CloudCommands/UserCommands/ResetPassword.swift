import CloudAPI
import Globals
import ConsoleKit

struct ResetPassword: Command {

    public struct Signature: CommandSignature {
        @Option(name: "email", short: "e")
        var email: String
    }

    let help = "resets your account's password."

    func run(using ctx: CommandContext, signature: Signature) throws {
        let e = signature.$email.load(with: ctx)
        try UserApi().reset(email: e)
        ctx.console.output("password has been reset.".consoleText())
        ctx.console.output("check emaail: \(e).".consoleText())
    }
}


extension Option {
    func load(with ctx: CommandContext, _ message: String? = nil, secure: Bool = false) -> Value {
        if let raw = self.wrappedValue { return raw }
        let msg = message ?? self.name
        ctx.console.pushEphemeral()
        let answer = ctx.console.ask(msg.consoleText(), isSecure: secure)
        ctx.console.popEphemeral()
        return Value.convertOrFail(answer)
    }
}

# Try to login
def login(root)
    username = ask("Username:  ")
    password = ask("Password:  ") { |q| q.echo = "x" }

    begin
        user = root.login.post username: username, password: password
    rescue HyperResource::ClientError => e
        say e.body["message"]
        return nil
    end

    user
end

# Try to register a new user
def register(root)
    username = ask("Username:  ")
    password = ask("Password:  ") { |q| q.echo = "x" }

    begin
        user = root.register.post username: username, password: password
    rescue HyperResource::ClientError => e
        say e.body["message"]
        return nil
    end

    user
end

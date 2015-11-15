def login(root)
    username = ask("Username:  ")
    password = ask("Password:  ") { |q| q.echo = "x" }

    user = root.login.post username: username, password: password
end

def register(root)
    username = ask("Username:  ")
    password = ask("Password:  ") { |q| q.echo = "x" }

    root.register.post username: username, password: password
end

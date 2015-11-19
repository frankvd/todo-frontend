# Display all lists of the user
def lists(user)
    say "==============="
    say "Create a new list or select an existing one."
    say "==============="
    choose do |menu|
        menu.choice("- Create a new list") { add_list(user) }
        menu.choice("- Search by tag") { tags(user.links.tags.get) }
        user.lists.each do |l|
            menu.choice(l.name) { show_list(l.self.get) }
        end
    end
end

# Add a new list
def add_list(user)
    name = ask("List name:  ")

    user.links.lists.post name: name

    lists user.links.self.get
end

# Rename a list
def rename_list(list)
    name = ask("New name: ")
    list.self.post name: name

    show_list list.get
end

# Remove a list
def remove_list(list)
    list.links.self.delete

    lists list.links.me.get
end

# Display a single list
def show_list(list)
    say "=================="
    say "List: #{list.name}"
    say "-----------------"
    choose do |menu|
        menu.choice("- Back to all lists") { lists list.links.me.get }
        menu.choice("- Rename this list") { rename_list list}
        menu.choice("- Remove this list") { remove_list list}
        menu.choice("- Add a new item") { add_todo list }
        list.todos.each do |t|
            menu.choice("#{t.name} [edit]") { edit_todo t.get }
        end
    end
end

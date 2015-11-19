# Edit a todo
def edit_todo(todo)
    tags = todo.tags.map {|t| t.name} .join ", "
    say "==============="
    say "Todo: #{todo.name} (#{tags})"

    choose do |menu|
        menu.choice("- Back to list") { show_list todo.list.get }
        menu.choice("- Rename this item") { rename_todo todo }
        menu.choice("- Remove this item") { remove_todo todo }
        menu.choice("- Add a tag to this item") { add_tag todo }
        todo.tags.each do |t|
            menu.choice("#{t.name} [remove]") { remove_tag t }
        end
    end
end

# Add a todo to a list
def add_todo(list)
    name = ask("Name: ")
    list.links.items.post name: name

    show_list list.get
end

# Rename a todo
def rename_todo(todo)
    name = ask("New name: ")

    todo.self.post name: name

    edit_todo todo.get
end

# Remove a todo
def remove_todo(todo)
    todo.links.self.delete

    show_list todo.links.list.get
end

# Add a tag to a todo
def add_tag(todo)
    name = ask("Name: ")
    todo.links.tags.post name: name

    edit_todo todo.get
end

# Remove a tag from a todo
def remove_tag(tag)
    tag.links.self.delete

    edit_todo tag.links.todo.get
end

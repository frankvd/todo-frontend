def edit_todo(todo)
    tags = todo.tags.map {|t| t["name"]} .join ", "
    say "==============="
    say "Todo: #{todo.name} (#{tags})"

    choose do |menu|
        menu.choice("Remove this item") { remove_todo todo}
        menu.choice("Add a tag to this item") { add_tag todo }
    end
end

def add_todo(list)
    name = ask("Name: ")
    list.links.items.post name: name

    show_list list.get
end

def remove_todo(todo)
    todo.links.self.delete

    show_list todo.links.list.get
end


def add_tag(todo)
    name = ask("Name: ")
    todo.links.tags.post name: name

    edit_todo todo.get
end

def remove_tag(tag)
    tag.links.self.delete

    edit_todo tag.links.todo.get
end

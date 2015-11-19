# Display all tags belonging to the logged in user
def tags(tags)
    choose do |menu|
        menu.choice("- Back to all lists") { lists tags.links.me.get }
        tags.tags.each do |t|
            menu.choice(t.name) {tag_todos t.todos.get}
        end
    end
end

# Display all todo's with a specific tag
def tag_todos(list)
    say "=================="
    say "#{list.name}"
    say "-----------------"
    choose do |menu|
        menu.choice("- Back to all lists") { lists list.links.me.get }
        list.todos.each do |t|
            menu.choice("#{t.name} [edit]") { edit_todo t.get }
        end
    end
end

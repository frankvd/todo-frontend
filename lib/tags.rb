def tags(tags)
    choose do |menu|
        tags.tags.each do |t|
            menu.choice(t.name) {tag_todos t.todos.get}
        end
    end
end

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

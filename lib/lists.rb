def lists(user)
    say "==============="
    say "Your lists:"
    choose do |menu|
      menu.choice("Create a new list") { add_list(user) }
      user.lists.each do |l|
          menu.choice(l.name) { show_list(l) }
      end
    end
end

def add_list(user)
    puts user.links.inspect
    name = ask("List name:  ")

    user.links.lists.post name: name

    lists user.links.self.get
end

def remove_list(list)
    list.links.self.delete

    lists list.links.me.get
end

def show_list(list)
    say "=================="
    say "List: #{list.name}"
    choose do |menu|
        menu.choice("Back to all lists") { lists list.links.me.get }
        menu.choice("Remove this list") { remove_list list}
        menu.choice("Add a new item") { add_todo list }
        say "-----------------"
        list.todos.each do |t|
            menu.choice("#{t.name} [edit]") { edit_todo t }
        end
    end
end

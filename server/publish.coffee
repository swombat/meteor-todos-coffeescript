# Lists -- {name: String}
Lists = new Meteor.Collection "lists"

# Publish complete set of lists to all clients.
Meteor.publish 'lists', -> Lists.find()


# Todos -- {text: String,
#           done: Boolean,
#           tags: [String, ...],
#           list_id: String,
#           timestamp: Number}
Todos = new Meteor.Collection "todos"

# Publish all items for requested list_id.
Meteor.publish 'todos', (list_id) -> Todos.find {list_id: list_id}



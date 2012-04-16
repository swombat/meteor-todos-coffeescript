# ID of currently selected list
Session.set 'list_id', null

# Name of currently selected tag for filtering
Session.set 'tag_filter', null

# When adding tag to a todo, ID of the todo
Session.set 'editing_addtag', null

# When editing a list name, ID of the list
Session.set 'editing_listname', null

# Define Minimongo collections to match server/publish.js.
Lists = new Meteor.Collection "lists"
Todos = new Meteor.Collection "todos"

# Subscribe to 'lists' collection on startup.
# Select a list once data has arrived.
Meteor.subscribe 'lists', ->
  if !Session.get('list_id')
    list = Lists.findOne {}, {sort: {name: 1}}
    Router.setList(list._id) if list

# Always be subscribed to the todos for the selected list.
Meteor.autosubscribe ->
  list_id = Session.get 'list_id'
  Meteor.subscribe 'todos', list_id if list_id


Template.todos.any_list_selected = -> !Session.equals('list_id', null)

Template.todos.todos = ->
  # Determine which todos to display in main pane,
  # selected based on list_id and tag_filter.

  list_id = Session.get 'list_id'
  return {} unless list_id?

  sel = {list_id: list_id}
  tag_filter = Session.get 'tag_filter'
  sel.tags = tag_filter if tag_filter
    
  Todos.find sel, {sort: {timestamp: 1}}

Template.todo_item.tag_objs = ->
  todo_id = this._id
  return _.map(this.tags or [], (tag) -> {todo_id: todo_id, tag: tag})

Template.todo_item.done_class = -> if this.done then 'done' else ''

Template.todo_item.done_checkbox = -> if this.done then 'checked="checked"' else ''

Template.todo_item.editing = -> Session.equals 'editing_itemname', this._id

Template.todo_item.adding_tag = -> Session.equals 'editing_addtag', this._id

Template.todo_item.events = {
  'click .check': -> Todos.update this._id, {$set: {done: !this.done}}
  'click .destroy': -> Todos.remove this._id
  'click .addtag': (evt) ->
    Session.set 'editing_addtag', this._id
    Meteor.flush() # update DOM before focus
    $("#edittag-input").focus()
  'dblclick .display .todo-text': (evt) ->
    Session.set 'editing_itemname', this._id
    Meteor.flush() # update DOM before focus
    $("#todo-input").focus()
}

$ ->
  add_inline_editing_events Template.todos, "#new-todo", {
    ok: (text) ->
      tag = Session.get "tag_filter"
      Todos.insert {
        text:text
        list_id:Session.get("list_id")
        done: false
        timestamp: (new Date()).getTime()
        tags: if tag then [tag] else []
      }
  }
  add_inline_editing_events Template.todo_item, "#todo-input", {
    ok: (value) ->
      Todos.update this._id, {$set: {text: value}}
      Session.set "editing_itemname", null
    cancel: ->
      Session.set "editing_itemname", null
    save_on_blur: true
  }


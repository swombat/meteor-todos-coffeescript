Template.lists.lists = -> Lists.find {}, {sort: {name: 1}}

Template.list_item.selected = -> if Session.equals('list_id', this._id) then 'selected' else ''

Template.list_item.name_class = -> if this.name then '' else 'empty'

Template.list_item.editing = -> Session.equals 'editing_listname', this._id

Template.list_item.events = {
  'mousedown': (evt) -> # select list
    Router.setList this._id
  'dblclick': (evt) -> # start editing list name
    Session.set 'editing_listname', this._id
    Meteor.flush() # force DOM redraw, so we can focus the edit field
    $("#list-name-input").focus()
  }

$ ->
  add_inline_editing_events Template.lists, "#new-list", {
    ok: (text, evt) ->
      id = Lists.insert {name: text}
      Router.setList id
  }

  add_inline_editing_events Template.list_item, "#list-name-input", {
    ok: (text) ->
      Lists.update this._id, {$set: {name: value}}
      Session.set 'editing_listname', null
    cancel: () ->
      Session.set 'editing_listname', null
    save_on_blur: true
  }

##### Helpers for in-place editing #####

add_inline_editing_events = (template, selector, options) ->
  if !template.events?
    template.events = {}

  ok_handler     = options.ok     or (text, event) -> $(selector).val("").blur()
  cancel_handler = options.cancel or (text, event) -> $(selector).val("").blur()

  template.events["keyup #{selector}, keydown #{selector}, focusout #{selector}"] = (event) ->
    value = String event.target.value || ""
    if event.type is "keydown" and event.which is 27 or (event.type is "focusout" and not options.save_on_blur)
      cancel_handler.call this, event
    else if event.type is "keyup" and event.which is 13 or (event.type is "focusout" and options.save_on_blur)
      if value then ok_handler.call this, value, event else cancel_handler.call this, value, event

# Returns an event_map key for attaching "ok/cancel" events to
# a text input (given by selector)
okcancel_events = (selector) -> "keyup #{selector}, keydown #{selector}, focusout #{selector}"

# Creates an event handler for interpreting "escape", "return", and "blur"
# on a text field and calling "ok" or "cancel" callbacks.
okcancel_handler = (options) ->
  ok = options.ok || ->
  cancel = options.cancel || ->

  return (event) ->
    if event.type is "keydown" and event.which is 27 or (event.type is "focusout" and not options.save_on_blur)
      # escape = cancel
      cancel.call this, event
    else if event.type is "keyup" and event.which is 13 or (event.type is "focusout" and options.save_on_blur)
      # blur/return/enter = ok/submit if non-empty
      value = String event.target.value || ""
      if value
        ok.call this, value, event
      else
        cancel.call this, event

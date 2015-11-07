DoulciView = require './doulci-view'
{CompositeDisposable} = require 'atom'

module.exports = Doulci =
  doulciView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @doulciView = new DoulciView(state.doulciViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @doulciView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'doulci:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @doulciView.destroy()

  serialize: ->
    doulciViewState: @doulciView.serialize()

  toggle: ->
    console.log 'Doulci was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()

NixosView = require './nixos-view'
{CompositeDisposable} = require 'atom'

module.exports = Nixos =
  nixosView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @nixosView = new NixosView(state.nixosViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @nixosView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'nixos:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @nixosView.destroy()

  serialize: ->
    nixosViewState: @nixosView.serialize()

  toggle: ->
    console.log 'Nixos was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()

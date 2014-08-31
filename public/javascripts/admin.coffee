$('#new-article-tabs a').on 'click' (e) ->
  e.preventDefault()
  $(@).tab 'show'
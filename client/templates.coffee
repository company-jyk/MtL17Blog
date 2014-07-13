isViewing = (viewName...) ->
    #unless Session.get('currentView') is v for v in viewName
   if Session.get 'currentView' is v for v in viewName then true else false

Template.main.events
	'click a[href^= "/" ]' : (e,t) ->
		pn = e.currentTarget.pathname
		console.log  pn
		Backbone.history.navigate encodeURI(pn), true
		e.preventDefault() #with reload the whole page

Template.header.adminLoggedIn = =>
	adminLoggedIn()

Template.header.events
	'click button': ->
		Backbone.history.navigate '/new', true # 新页面

Template.newPostForm.show = ->
	isViewing "newPostForm"

slug = (t)-> t.find("#slug")
Template.newPostForm.events
	'keyup #title': (e,t)->
		slug(t).value = t.find("#title").value.toLowerCase().split(' ').join('-')

	'click button': (e,t)->
		Meteor.call "post",
			t.find("#content").value
			t.find("#title").value
			slug(t).value
			(err,id)->
				Backbone.history.navigate '/' + slug(t).value, true

Template.posts.show = ->
	isViewing("posts") or isViewing("post")

Template.posts.posts = =>
	if isViewing "post"
		@Posts.find slug: Session.get "currentPost"
	else
		@Posts.find {}, sort: {createdOn: -1}

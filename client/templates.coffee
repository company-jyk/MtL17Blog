isViewing = (viewName)->
	Session.get('currentView') is viewName

Template.main.events 
	'click a[href^= "/" ]' : (e,t) ->
		pn = e.currentTarget.pathname
		console.log  pn
		Backbone.history.navigate encodeURI(pn), true
		e.preventDefault()

Template.header.adminLoggedIn = =>
	@adminLoggedIn()

Template.header.events
	'click button': -> 
		Backbone.history.navigate '/new', true # 新页面

Template.newPostForm.show = -> 
	isViewing "newPostForm"

Template.newPostForm.events
	slug = t.find("#slug")
	'keyup #title': (e,t)->
		slug.value = t.find("#title").value.toLowerCase().split(' ').join('-')

	'click button': (e,t)->
		Meteor.call "post",
			t.find("#content").value
			t.find("#title").value
			slug.value
			(err,id)-> 
				Backbone.history.navigate '/' + slug, true

Template.posts.show = ->
	isViewing("posts") or isViewing("post")

Template.posts.posts = =>
	if isViewing "post"
		@Posts.find slug: Session.get "currentPost"
	else
		@Posts.find {}, sort: {createdOn: -1}

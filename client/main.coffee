Meteor.subscribe "postsChannel"
BlogRouter = Backbone.Router.extend
	routes: 
		"": "main"
		"new": "newPost"
		":slug": "post"
	main: ->
		Session.set "currentView","posts"	
	newPost: -> 
		Session.set "currentView", "newPostForm"
	post:(slug) ->
		Session.set "currentView","post"
		Session.set "currentPost", slug

Meteor.startup -> # 开始历史记录
	new BlogRouter
	Backbone.history.start pushState: true
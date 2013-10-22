Meteor.publish "postsChannel" , => 
		@Posts.find()

Meteor.methods
	post: (content, title, slug) => # return 是insert所return,即Mongodb的 _id
		if @adminLoggedIn
			@Posts.insert {# <- 必须用大括号才能简写以下代码
				content#:content
				title#:	title
				slug#:	slug
				createdOn: new Date}# <- 必须用大括号才能简写
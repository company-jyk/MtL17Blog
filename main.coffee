@Posts = new Meteor.Collection "posts"
admins = ['j@k.com','h@l.com']
@adminLoggedIn = -> admins.indexOf(Meteor.user()?.emails?[0].address) >-1
 #is "j@k.com"

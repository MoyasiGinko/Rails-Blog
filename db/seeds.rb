# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.create([{id: 1, name: 'Tom', photo: 'https://media.istockphoto.com/id/1386479313/photo/happy-millennial-afro-american-business-woman-posing-isolated-on-white.jpg?s=1024x1024&w=is&k=20&c=5OK7djfD3cnNmQ-DR0iQzF-vmA-iTNN1TbuEyCG1DfA=', bio: 'Teacher from Mexico.'}, 
    {id: 2, name: 'Lilly', photo: 'https://media.istockphoto.com/id/1388253782/photo/positive-successful-millennial-business-professional-man-head-shot-portrait.jpg?s=1024x1024&w=is&k=20&c=v0FzN5RD19wlMvrkpUE6QKHaFTt5rlDSqoUV1vrFbN4=', bio: 'Teacher from Poland.'}])
Post.create([{author_id: 1, title: 'Hello', text: 'This is my first post'}, {author_id: 1, title: 'Hello', text: 'This is my first post'}])
Comment.create([{post_id: 1, author_id: 2, text: 'Hi Tom!' }, {post_id: 1, author_id: 2, text: 'Hello Tom!' }])
Like.create([{author_id:2, post_id:1},{author_id:2, post_id:1},{author_id:2, post_id:2}])
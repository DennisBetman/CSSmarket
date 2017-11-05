User.destroy_all
Post.destroy_all
Order.destroy_all

User.create!(id: 1, name: "admin", email: "admin@example.com", password: "admin", password_confirmation: "admin", level: 100)
User.create!(id: 2, name: "user", email: "user@example.com", password: "user", password_confirmation: "user", level: 0)

Post.create!(id: 1, title: "Sample Post", nice_url: "sample-post", content: "Sample Content", categories: "menus", user_id: 2, price: "14", description: "This is a short description", image: "http://placehold.it/600x400", file: "http://www.colorado.edu/conflict/peace/download/peace.zip", license: "Standard license", status: 1)
Post.create!(id: 2, title: "Another Post", nice_url: "another-post", content: "Post 2", categories: "buttons", user_id: 1, price: "20", description: "This is a short description", image: "http://placehold.it/600x400", file: "http://www.colorado.edu/conflict/peace/download/peace.zip", license: "Standard license", status: 0)

Order.create!(amount: 20, description: "Sample Post", customer_id: "1", source: "1", post_id: 2, user_id: 2, created_at: "2016-09-08 14:13:29.985816", updated_at: "2016-09-08 14:13:29.985816")
Order.create!(amount: 14, description: "Sample Post", customer_id: "1", source: "1", post_id: 2, user_id: 3, created_at: "2017-09-08 14:13:29.985816", updated_at: "2017-09-08 14:13:29.985816")

User.destroy_all
Post.destroy_all

User.create!(name: "admin", email: "admin@example.com", password: "admin", password_confirmation: "admin", level: 100)
User.create!(name: "user", email: "user@example.com", password: "user", password_confirmation: "user", level: 0)

Post.create!(title: "Sample Post", content: "Sample Content", categories: "menus", user_id: 2, price: "14", description: "This is a short description", image: "http://placehold.it/600x400", file: "http://www.colorado.edu/conflict/peace/download/peace.zip", license: "Standard license")
Post.create!(title: "Another Post", content: "Post 2", categories: "buttons", user_id: 1, price: "20", description: "This is a short description", image: "http://placehold.it/600x400", file: "http://www.colorado.edu/conflict/peace/download/peace.zip", license: "Standard license")

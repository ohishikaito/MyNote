User.create!(nickname: "ゲスト",email: "guest@user", password: "adaadaada", password_confirmation: "adaadaada")
User.create!(nickname:  "管理者",
             email: "admin@user",
             password:  "adaadaada",
             password_confirmation: "adaadaada",
             admin: true)
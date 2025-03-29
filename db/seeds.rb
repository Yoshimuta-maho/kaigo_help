# デフォルトのユーザーを作成
if User.find_by(email: 'test@test').nil?
  User.create!(
    email: 'test@test',
    password: '000000',
    password_confirmation: '000000',
    name: '山田花子',  # 任意のカラム（例: name）を設定
    # 他に必要なカラムがあれば追加
  )
end

if Admin.find_by(email: 'test@admin').nil?
  admin = Admin.new(email: 'test@admin', password: 'password', password_confirmation: 'password')
  admin.save!
end

if Genre.find_by(genre_name: '悩み').nil?
  Genre.new(genre_name:"悩み").save
end

if Genre.find_by(genre_name: '方法').nil?
  Genre.new(genre_name:"方法").save
end
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

if Admin.find_by(email: 'test@test').nil?
  admin = Admin.new(email: 'test@test', password: 'password', password_confirmation: 'password')
  admin.save!
end


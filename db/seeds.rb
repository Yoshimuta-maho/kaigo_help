# デフォルトのユーザーを作成
User.create!(
  email: 'test@test',
  password: '000000',  # 強力なパスワードにすることを推奨
  password_confirmation: '000000',
  name: '山田花子',  # 任意のカラム（例: name）を設定
  # 他に必要なカラムがあれば追加
)


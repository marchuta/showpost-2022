FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end
    birthday { Faker::Date.backward }
    nickname { Faker::Name.last_name }
    email { Faker::Internet.free_email }
    password { Faker::Internet.password(min_length: 100) }
    password_confirmation { password }
    first_name_kanji { person.first.kanji }
    last_name_kanji { person.last.kanji }
    first_name_katakana { person.first.katakana }
    last_name_katakana { person.last.katakana }
  end
end

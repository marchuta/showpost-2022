# README

## users table 
| Column                 | Type  | Options     |
| -----------------------| ------| ----------- |
| nickname               | string| null: false |
| email                  | string| null: false, unique: true |
| encrypted_password     | string| null: false |
| last_name_kanji        | string| null: false |
| first_name_kanji       | string| null: false |
| last_name_katakana     | string| null: false |
| first_name_katakana    | string| null: false |
| birthday               | date  | null: false |

###  Association

- has_many :posts
- has_many :auctions, through: :user_auctions


## posts table
| Column                 | Type  | Options     |
| -----------------------| ------| ----------- |
| sentence               | string| null: false |
| user               | references| null: false, foreign_key: true |

###  Association
- belongs_to :user
- has_many :auctions


## auctions table
| Column                 | Type  | Options     |
| -----------------------| ------| ----------- |
| price              | integer | null: false |
| user               | references| null: false, foreign_key: true |
| post               | references| null: false, foreign_key: true |

###  Association
- belongs_to :post
- has_many :users, through: :user_auctions


## user_auction table
| Column             | Type      | Options                        |
| ----------------   | ----------| ------------------------------ |
| user               | references| null: false, foreign_key: true |
| auction            | references| null: false, foreign_key: true |

### Association
- belongs_to :auction
- belongs_to :user

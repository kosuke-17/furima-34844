# テーブル設計

## users  テーブル

| Colum              | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| name               | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| family_name        | string  | null: false               |
| first_name         | string  | null: false               |
| family_name_kana   | string  | null: false               |
| first_name_kana    | string  | null: false               |
| birth_day          | date    | null: false               |

### Association

- has_many :items
- has_many :purchases

## items  テーブル

| Colum              | Type    | Options         |
| ------------------ | ------- | --------------- |
| name          | string     | null: false       |
| price         | integer    | null: false       |
| description   | text       | null: false       |
| category_id   | integer    | null: false       |
| status_id     | integer    | null: false       |
| cost_id       | integer    | null: false       |
| ship_date_id  | integer    | null: false       |
| prefecture_id | integer    | null: false       |
| user          | references | foreign_key: true |

### Association

- belong_to :user
- has_one   :purchase

## purchases  テーブル

| colum       | Type                | Option            |
| ----------- | ------------------- | ----------------- |
| user        | references          | foreign_key: true |
| item        | references          | foreign_key: true |

### Association

- belong_to :user
- belong_to :item
- has_one   :destination


## destinations  テーブル

| Colum         | Type       | Options           |
| ------------- | ---------- | ----------------- |
| post_code     | string     | null: false       |
| prefecture_id | integer    | null: false       |
| city          | string     | null: false       |
| address       | string     | null: false       |
| building_name | string     | null: false       |
| phone_number  | string     | null: false       |
| purchase      | references | foreign_key: true |

### Association

- belongs_to   :purchase

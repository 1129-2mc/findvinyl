![vinyllog](./app/assets/images/vinyllog.png)
# [VinylLog](https://vinyllog.jp/)

## サービス概要
アナログレコードを集めている人向けの、所有しているレコード・欲しいレコードのリスト作成、聴いたレコードの記録、レコードショップの検索が可能なサービスです。  
<br>

## メイン機能

| ショップ検索 | ショップブックマーク | ショップレビュー |
|------------|------------|------------|
| ![demo](https://raw.github.com/wiki/1129-2mc/findvinyl/images/Gif/shop_search.gif) | ![demo](https://raw.github.com/wiki/1129-2mc/findvinyl/images/Gif/bookmark.gif) | ![demo](https://raw.github.com/wiki/1129-2mc/findvinyl/images/Gif/review.gif) |
| Mapから近くのレコードショッ<br>プを探すことができます。店名・<br>住所での検索も可能です。 | ショップをブックマークをするこ<br>とができます。ブックマークした<br>ショップ一覧の閲覧も可能です。 | ショップのレビューを投稿できま<br>す。未ログインだとレビューの閲<br>覧のみ可能です。 |

| リスト作成 | アーティスト検索 | リリース検索 |
|------------|------------|------------|
| ![demo](https://raw.github.com/wiki/1129-2mc/findvinyl/images/Gif/item_create.gif) | ![demo](https://raw.github.com/wiki/1129-2mc/findvinyl/images/Gif/artist_search.gif) | ![demo](https://raw.github.com/wiki/1129-2mc/findvinyl/images/Gif/release_search.gif) |
| 持っているレコード・欲しいレコ<br>ードのリストを作成できます。フ<br>ォーマットやプレス国などの詳細<br>情報も保存できます。 | アーティスト検索ができます。詳<br>細ページからリリースタイトルを<br>選択し、「コレクションに追加」<br>または「欲しいものに追加」ボタ<br>ンからリストに追加することも可<br>能です。 | リリースタイトル検索ができます<br>。詳細ページの「コレクションに<br>追加」または「欲しいものに追加<br>」ボタンからリストに追加するこ<br>とも可能です。 |

| レコード記録 | レポート | レコードランダム表示 |
|------------|------------|------------|
| ![demo](https://raw.github.com/wiki/1129-2mc/findvinyl/images/Gif/record.gif) | ![demo](https://raw.github.com/wiki/1129-2mc/findvinyl/images/Gif/report.gif) | ![demo](https://raw.github.com/wiki/1129-2mc/findvinyl/images/Gif/mypage.gif) |
| 聴いたレコードの記録をすること<br>ができます。リストに追加したレ<br>コードのみ記録可能です。 | 聴いたレコードの１ヶ月間の集計<br>を閲覧できます。よく聴いたアー<br>ティストやレコードなどが集計さ<br>れます。 | マイページにコレクションリスト<br>のレコードがランダムに表示され<br>ます。 |

## 機能一覧
- アカウント登録・削除機能
- ログイン・ログアウト機能
- アカウント詳細機能
- アカウント情報(ユーザー名・アバター)編集機能
- メールアドレス変更機能
- パスワードリセット機能
- マイページ機能
- コレクションランダム表示機能
- アーティスト検索機能
- アーティスト詳細機能
- リリースタイトル検索機能
- リリース詳細機能
- コレクション登録機能
- コレクションリスト内検索機能
- コレクションリスト内タグ絞り込み機能
- 欲しいもの登録機能
- 欲しいものリスト内検索機能
- 欲しいものリスト内タグ絞り込み機能
- 欲しいものからコレクションに移動する機能
- 聴いたレコードを記録する機能
- 聴いたレコードの記録一覧機能
- 聴いたレコードの集計機能
- レコードショップの検索機能
- レコードショップのブックマーク機能
- ブックマークしたショップ一覧機能
- ショップレビュー機能
- レビューしたショップ一覧機能
<br>

## 使用技術

| カテゴリー | 使用技術 |
|------------|------------|
| フロントエンド | TailWind CSS(daisyUI)<br>Hotwire(Turbo, Stimulus) |
| バックエンド | Ruby on Rails 7.1.2<br>Ruby 3.2.2 |
| API | MusicBrainz API<br>Google Maps JavaScript API<br>Google Places API<br>Geolocation API |
| データベース | PostgreSQL |
| インフラ | Heroku<br>AmazonS3 |
| 開発環境 | Docker |

## 画面遷移図(未修正)
https://www.figma.com/file/TZELZVG8E9e6JrvN6ppkJ8/%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3?type=design&node-id=0%3A1&mode=design&t=E16sPwSsSS5nkWbD-1

## ER図

[![Image from Gyazo](https://i.gyazo.com/393dc9c707ed8b10e71f7dab1d5ce8c9.png)](https://gyazo.com/393dc9c707ed8b10e71f7dab1d5ce8c9)

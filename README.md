# VinylLog

## サービス概要
アナログレコードを集めている人向けの、所有しているレコード・欲しいレコードのリスト作成、聴いたレコードの記録が可能なサービスです。デジタル媒体に比べ管理が困難なレコードの情報を整理し、ユーザーのコレクション管理や過去に聴いた作品の振り返りを通じて、より音楽体験を豊かにすることを目指します。  
<br>

## このサービスへの思い・作りたい理由
私は音楽を聴くことが好きで、レコード特有の厚みと立体感のある音や、デジタルですぐに音楽を聴くことができる時代に、手間と時間をかけて音楽を再生する文化に興味を持ち、レコードの収集を始めました。まだコレクターと呼べる程のコレクション数や、レコードに関する造詣はありませんが、レコードで音楽を聴いて楽しんでいます。レコードを収集し鑑賞する過程で、以下のような課題を感じ、これらを解決するサービスを開発したいと考えました。  

1. 所有するレコードの把握が難しい  
所有するレコードが増えるにつれて、何を持っているか把握するのが難しくなり、結果的に持っているが聴いていないレコードが出てきてしまう。  

2. ショッピングをする際に、欲しいと思っていたレコードの詳細を参照できるものがない  
レコードの特性上、型番・発売国・付属品の有無等、欲しいレコードの条件が複雑になりがちで、いざお店に行った時に全てを思い出すことが難しい。  

3. 過去に聴いていた作品を振り返ることが難しい  
デジタルの音楽配信サービスでは、１年間の間によく聴いたアーティストや曲が集計され、自分が聴いていた音楽を振り返ることができるが、レコードでは履歴が残らないため、特定の時期に聴いていた音楽を振り返ることが困難である。  

以上の課題を解決するサービスを提供することで、レコードが好きな人のアナログ音楽を楽しむ生活をより充実させるサポートがしたいと考えています。  
<br>

## サービスの利用イメージ
- 所有しているレコードリストの作成  
ユーザーはオンラインで自分が持っているレコードのリストを作成し、作品タイトル・アーティスト名・型番・発売国・付属品の有無・メモ等の詳細情報を記録できます。これによりコレクション全体の把握を容易にし、外出先でも参照できるようになります。  

- 所有しているレコードのランダム表示  
所有しているコレクション内からランダムにレコードを表示することで、長い間聴いていないレコードを再発見できます。コレクション全体をより活用し、忘れ去られがちなレコードを再度楽しむきっかけになります。  

- 欲しいレコードリストの作成  
欲しいレコードのタイトル・条件等をリストアップし、ショッピング時に簡単に参照できます。店頭やオンラインでレコードを探す際、何を買おうと思っていたかを明確にし、購入機会を逃さず、重複購入を避けることができます。  

- 聴いたレコードの記録  
聴いたレコードや、レコードについての感想等を記録できます。これにより、特定の時期にどのレコードを聴いていたかを振り返ることが可能になります。  

- 聴いていたレコードのリマインド  
一定期間後に過去に聴いていたレコードをリマインドします。また、月末にはその月に最も聴いたレコードの集計結果を提示します。過去に聴いていた音楽を振り返ることで、ユーザーの音楽の嗜好の変化や変遷、その時代の感情や出来事を思い出す手助けをします。  
<br>

## 想定されるユーザー層
- レコードを収集している人  
- 聴いたレコードの記録を残したい人  
<br>

## ユーザーの獲得について
X・Instagramでの宣伝  
<br>

## サービスの差別化ポイント・推しポイント
所有しているレコード・欲しいレコードのリストを作成できるWebサービスとして、Discogsが挙げられますが、ユーザーが聴いた音楽を記録する機能、リマインド機能は現状備わっていないので、その部分で差別化を図りたいと考えています。
<br>

## 機能候補
### MVP
- アカウント登録機能
- ログイン機能
- プロフィール機能
- マイページ機能
- レコード検索機能
- おすすめのレコード表示機能
- コレクション登録機能
- コレクション検索機能
- コレクションランダム表示機能
- ほしい物リスト登録機能
- ほしい物リスト検索機能
- 聴いたレコードを記録する機能

### 本リリース
- 聴いたレコードのリマインド機能
- 聴いたレコードの集計機能
- 検索オートコンプリート機能
- タグ付け機能

### 可能であれば
- レコードショップ/レコードが聴ける飲食店等の検索機能
- レコードショップ等のブックマーク機能
- ショップレビュー機能
<br>

## 機能の実装方針予定
### フロントエンド
- JavaScript
- TailWind CSS

### バックエンド
- Ruby on Rails 7.0.8
- Ruby 3.2.2
- gem
  - sorcery
  - kaminari
  - ransack
- API  
  - MusicBrainz API  
  ※ショップ検索機能を実装する場合
  - Google Maps JavaScript API
  - Google Places API
  - Google Geolocation API

### RDS
- PostgreSQL(MusicBrainzのDBをダウンロードし軽量化・最適化して使用する予定です)

### インフラ
- Fly.io
- AmazonS3
<br>

## ER図

[![](https://mermaid.ink/img/pako:eNrFWE1P4zAQ_StWzlTac28rAdIKxO5q6a2S5cZDapHEkT2hVG3_-zpx0iZxPlw2sOUAtZ_HM8_zPGMOQSg5BMsA1K1gkWLJOiXmk2tQmhyPi4U8EIGQaLIk68D8uNMKQqn4KOBNwG4EoLcyoxspXxOmXvtwB_ul-GxEJFIkgpNfD5dRjUqkEUlZAmbx089n8rR6fKyNNBCQMBE3IDdk9fTj9-quBxqqfYbAaca03pkIHYBmMV4GjVcQgSJKxoUPt3f331ePz-TbDRlxh70xZMoZVqABzxtTlK-QGpuuq5whoDBB962g8J4JM0EZTq8oiaEaUmzB66hYGILWNJS5AaCkndUZi8A9DdhZsy61Mn0RKmEoZOoTXQvv-HiBKWDFifVO5hlvTZ7Wqf3Dpncj1ymyqJ2FLsTyIZWAEaRVBnX1Y0dOcrE4HgkKjGFknikUGmmR2yOoTJ3PZ8CpCmhYVOKdpnmyKaQ1iDOcc1EQPoJREAPTQF9kcTh9wEnlVqOFzqmZun8Y0G-FK8nyATZY84E36dvbBQ6mxdwA5szawHybsS4I4b2iIpUIH71barRGhrmexvfoZ4CsHjH1IM_KqjL7g7d392o-m20JYm7jXR3Nbb8jP2_zJd5ng4ZufY2bus-9nO_q_R_rcsOubSGm7s0aN9utUgrOMIampnyBIFqB-QZRL5q-xMrKNIb7tMCKDm6032sBRvo9i5uv38ukuQVjWnS5bvPFeSF2d81WplAp1JmUGaTmN93KXLlLd7ChWqC7VxmySFptEofQjMQkNn0N5nwokjNMptEYrvY-ZmFZ8r44BepTn7viW-Y8Nfw_8r6RyV8ae_dWtvI6HkgCXOTOzVlhTsdmU2n4MMViADoZTZ6bgWgw1aZF2u7VrDPT8XZ8r6JuG3G75c6quUqXNXulF5_NbT9Vvh3TVafiLpg8vzo_q1S0X3vfEDXSv1Ta_sTD2dauzT684-bsvU75uBx9bZYDc_edl618yZzsJuonGYs8NNt4L_u8o5vjn0LFVRtcyUhtez_GCyHBTZCASS7Bg2VQ-rAOcAsJrIOCCm5KSoE_GRzLUf7Zp2GwRJXDTaBkHm2D5QuLtflma1X1D7xq9PQXyIkTZw?type=png)](https://mermaid-js.github.io/mermaid-live-editor/edit#pako:eNrFWE1P4zAQ_StWzlTac28rAdIKxO5q6a2S5cZDapHEkT2hVG3_-zpx0iZxPlw2sOUAtZ_HM8_zPGMOQSg5BMsA1K1gkWLJOiXmk2tQmhyPi4U8EIGQaLIk68D8uNMKQqn4KOBNwG4EoLcyoxspXxOmXvtwB_ul-GxEJFIkgpNfD5dRjUqkEUlZAmbx089n8rR6fKyNNBCQMBE3IDdk9fTj9-quBxqqfYbAaca03pkIHYBmMV4GjVcQgSJKxoUPt3f331ePz-TbDRlxh70xZMoZVqABzxtTlK-QGpuuq5whoDBB962g8J4JM0EZTq8oiaEaUmzB66hYGILWNJS5AaCkndUZi8A9DdhZsy61Mn0RKmEoZOoTXQvv-HiBKWDFifVO5hlvTZ7Wqf3Dpncj1ymyqJ2FLsTyIZWAEaRVBnX1Y0dOcrE4HgkKjGFknikUGmmR2yOoTJ3PZ8CpCmhYVOKdpnmyKaQ1iDOcc1EQPoJREAPTQF9kcTh9wEnlVqOFzqmZun8Y0G-FK8nyATZY84E36dvbBQ6mxdwA5szawHybsS4I4b2iIpUIH71barRGhrmexvfoZ4CsHjH1IM_KqjL7g7d392o-m20JYm7jXR3Nbb8jP2_zJd5ng4ZufY2bus-9nO_q_R_rcsOubSGm7s0aN9utUgrOMIampnyBIFqB-QZRL5q-xMrKNIb7tMCKDm6032sBRvo9i5uv38ukuQVjWnS5bvPFeSF2d81WplAp1JmUGaTmN93KXLlLd7ChWqC7VxmySFptEofQjMQkNn0N5nwokjNMptEYrvY-ZmFZ8r44BepTn7viW-Y8Nfw_8r6RyV8ae_dWtvI6HkgCXOTOzVlhTsdmU2n4MMViADoZTZ6bgWgw1aZF2u7VrDPT8XZ8r6JuG3G75c6quUqXNXulF5_NbT9Vvh3TVafiLpg8vzo_q1S0X3vfEDXSv1Ta_sTD2dauzT684-bsvU75uBx9bZYDc_edl618yZzsJuonGYs8NNt4L_u8o5vjn0LFVRtcyUhtez_GCyHBTZCASS7Bg2VQ-rAOcAsJrIOCCm5KSoE_GRzLUf7Zp2GwRJXDTaBkHm2D5QuLtflma1X1D7xq9PQXyIkTZw)

## 画面遷移図
https://www.figma.com/file/TZELZVG8E9e6JrvN6ppkJ8/%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3?type=design&node-id=0%3A1&mode=design&t=E16sPwSsSS5nkWbD-1
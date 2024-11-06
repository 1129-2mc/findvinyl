![vinyllog](./app/assets/images/vinyllog.png)
# [VinylLog](https://vinyllog.jp/)

## サービス概要
アナログレコードを集めている人向けの、所有しているレコード・欲しいレコードのリスト作成、聴いたレコードの記録、レコードショップの検索が可能なサービスです。  
<br>

## メイン機能
<br>

## 機能一覧
- アカウント登録機能
- ログイン機能
- プロフィール機能
- マイページ機能
- レコード検索機能
- コレクション登録機能
- コレクション検索機能
- コレクションランダム表示機能
- ほしい物リスト登録機能
- ほしい物リスト検索機能
- 聴いたレコードを記録する機能
- 聴いたレコードの集計機能
- レコードショップの検索機能
- レコードショップのブックマーク機能
- ショップレビュー機能
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

[![](https://mermaid.ink/img/pako:eNrFWE1P4zAQ_StWzlTac28rAdIKxO5q6a2S5cZDapHEkT2hVG3_-zpx0iZxPlw2sOUAtZ_HM8_zPGMOQSg5BMsA1K1gkWLJOiXmk2tQmhyPi4U8EIGQaLIk68D8uNMKQqn4KOBNwG4EoLcyoxspXxOmXvtwB_ul-GxEJFIkgpNfD5dRjUqkEUlZAmbx089n8rR6fKyNNBCQMBE3IDdk9fTj9-quBxqqfYbAaca03pkIHYBmMV4GjVcQgSJKxoUPt3f331ePz-TbDRlxh70xZMoZVqABzxtTlK-QGpuuq5whoDBB962g8J4JM0EZTq8oiaEaUmzB66hYGILWNJS5AaCkndUZi8A9DdhZsy61Mn0RKmEoZOoTXQvv-HiBKWDFifVO5hlvTZ7Wqf3Dpncj1ymyqJ2FLsTyIZWAEaRVBnX1Y0dOcrE4HgkKjGFknikUGmmR2yOoTJ3PZ8CpCmhYVOKdpnmyKaQ1iDOcc1EQPoJREAPTQF9kcTh9wEnlVqOFzqmZun8Y0G-FK8nyATZY84E36dvbBQ6mxdwA5szawHybsS4I4b2iIpUIH71barRGhrmexvfoZ4CsHjH1IM_KqjL7g7d392o-m20JYm7jXR3Nbb8jP2_zJd5ng4ZufY2bus-9nO_q_R_rcsOubSGm7s0aN9utUgrOMIampnyBIFqB-QZRL5q-xMrKNIb7tMCKDm6032sBRvo9i5uv38ukuQVjWnS5bvPFeSF2d81WplAp1JmUGaTmN93KXLlLd7ChWqC7VxmySFptEofQjMQkNn0N5nwokjNMptEYrvY-ZmFZ8r44BepTn7viW-Y8Nfw_8r6RyV8ae_dWtvI6HkgCXOTOzVlhTsdmU2n4MMViADoZTZ6bgWgw1aZF2u7VrDPT8XZ8r6JuG3G75c6quUqXNXulF5_NbT9Vvh3TVafiLpg8vzo_q1S0X3vfEDXSv1Ta_sTD2dauzT684-bsvU75uBx9bZYDc_edl618yZzsJuonGYs8NNt4L_u8o5vjn0LFVRtcyUhtez_GCyHBTZCASS7Bg2VQ-rAOcAsJrIOCCm5KSoE_GRzLUf7Zp2GwRJXDTaBkHm2D5QuLtflma1X1D7xq9PQXyIkTZw?type=png)](https://mermaid-js.github.io/mermaid-live-editor/edit#pako:eNrFWE1P4zAQ_StWzlTac28rAdIKxO5q6a2S5cZDapHEkT2hVG3_-zpx0iZxPlw2sOUAtZ_HM8_zPGMOQSg5BMsA1K1gkWLJOiXmk2tQmhyPi4U8EIGQaLIk68D8uNMKQqn4KOBNwG4EoLcyoxspXxOmXvtwB_ul-GxEJFIkgpNfD5dRjUqkEUlZAmbx089n8rR6fKyNNBCQMBE3IDdk9fTj9-quBxqqfYbAaca03pkIHYBmMV4GjVcQgSJKxoUPt3f331ePz-TbDRlxh70xZMoZVqABzxtTlK-QGpuuq5whoDBB962g8J4JM0EZTq8oiaEaUmzB66hYGILWNJS5AaCkndUZi8A9DdhZsy61Mn0RKmEoZOoTXQvv-HiBKWDFifVO5hlvTZ7Wqf3Dpncj1ymyqJ2FLsTyIZWAEaRVBnX1Y0dOcrE4HgkKjGFknikUGmmR2yOoTJ3PZ8CpCmhYVOKdpnmyKaQ1iDOcc1EQPoJREAPTQF9kcTh9wEnlVqOFzqmZun8Y0G-FK8nyATZY84E36dvbBQ6mxdwA5szawHybsS4I4b2iIpUIH71barRGhrmexvfoZ4CsHjH1IM_KqjL7g7d392o-m20JYm7jXR3Nbb8jP2_zJd5ng4ZufY2bus-9nO_q_R_rcsOubSGm7s0aN9utUgrOMIampnyBIFqB-QZRL5q-xMrKNIb7tMCKDm6032sBRvo9i5uv38ukuQVjWnS5bvPFeSF2d81WplAp1JmUGaTmN93KXLlLd7ChWqC7VxmySFptEofQjMQkNn0N5nwokjNMptEYrvY-ZmFZ8r44BepTn7viW-Y8Nfw_8r6RyV8ae_dWtvI6HkgCXOTOzVlhTsdmU2n4MMViADoZTZ6bgWgw1aZF2u7VrDPT8XZ8r6JuG3G75c6quUqXNXulF5_NbT9Vvh3TVafiLpg8vzo_q1S0X3vfEDXSv1Ta_sTD2dauzT684-bsvU75uBx9bZYDc_edl618yZzsJuonGYs8NNt4L_u8o5vjn0LFVRtcyUhtez_GCyHBTZCASS7Bg2VQ-rAOcAsJrIOCCm5KSoE_GRzLUf7Zp2GwRJXDTaBkHm2D5QuLtflma1X1D7xq9PQXyIkTZw)

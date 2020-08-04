require 'rails_helper'

RSpec.describe "FoodEnquetes", type: :request do
  describe '正常' do
    context "アンケートに回答する" do
     it "回答できること" do
       #アンケートページにアクセスする
       get '/food_enquetes/new'
       #正常に応答することを確認する
       expect(response).to have_http_status(200)

       #正常な入力値を送信する
       post "/food_enquetes",params: { food_enquete: FactoryBot.attributes_for(:food_enquete_tanaka) }
       #リダイレクト先に移動する
       follow_redirect!
       #回答完了のメッセージが含まれることを検証する
       expect(response.body).to include "ご回答ありがとうございました"

     end
    end
  end

  describe '異常' do
    context "アンケートに回答する" do
      it "エラーメッセージが表示されること" do
        get "/food_enquetes/new"
        expect(response).to have_http_status(200)

        #異常な入力値を送信する
        post "/food_enquetes", params: { food_enquete: { name:''} }
        #回答完了のメッセージが含まれないことを検証する
        expect(response.body).not_to include "ご回答ありがとうございました"
      end
    end
  end
end

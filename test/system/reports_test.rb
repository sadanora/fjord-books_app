# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end

  test 'creating a Report' do
    visit reports_url
    assert_no_selector 'td', text: '今日は晴れ'
    assert_no_selector 'td', text: 'alice'
    assert_no_selector 'td', text: Time.zone.today.strftime('%Y/%m/%d')

    click_on '新規作成'

    fill_in 'タイトル', with: '今日は晴れ'
    fill_in '内容', with: '公園に行った'
    click_on '登録する'
    assert_text '日報が作成されました。'

    visit reports_url
    assert_selector 'td', text: '今日は晴れ'
    assert_selector 'td', text: 'alice'
    assert_selector 'td', text: Time.zone.today.strftime('%Y/%m/%d')
  end

  test 'visiting the index' do
    visit reports_url
    assert_selector 'h1', text: '日報'
    assert_selector 'th', text: 'タイトル'
    assert_selector 'th', text: '作成者'
    assert_selector 'th', text: '作成日'
    assert_selector 'td', text: '今日は晴れ'
    assert_selector 'td', text: 'alice'
    assert_selector 'td', text: Time.zone.today.strftime('%Y/%m/%d')
  end

  test 'updating a Report' do
    visit reports_url
    assert_no_selector 'td', text: '今日は雨'
    click_on '詳細'
    click_on '編集'

    fill_in 'タイトル', with: '今日は雨'
    fill_in '内容', with: '家で過ごした'
    click_on '更新する'

    assert_text '日報が更新されました。'

    visit reports_url
    assert_selector 'td', text: '今日は雨'
    assert_selector 'td', text: 'alice'
    assert_selector 'td', text: Time.zone.today.strftime('%Y/%m/%d')
  end

  test 'destroying a Report' do
    visit reports_url
    assert_selector 'td', text: '今日は晴れ'
    page.accept_confirm do
      click_on '削除'
    end

    assert_text '日報が削除されました。'
    assert_no_selector 'td', text: '今日は晴れ'
  end
end

# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  setup do
    @book = books(:cherry_book)
    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end

  test 'creating a Book' do
    visit books_url
    assert_no_selector 'td', text: 'チェリー本'
    assert_no_selector 'td', text: 'とてもわかりやすい'
    assert_no_selector 'td', text: '伊藤淳一'

    click_on '新規作成'

    fill_in 'メモ', with: @book.memo
    fill_in 'タイトル', with: @book.title
    click_on '登録する'

    assert_text '本が作成されました。'

    visit books_url
    assert_selector 'td', text: 'チェリー本'
    assert_selector 'td', text: 'とてもわかりやすい'
    assert_selector 'td', text: '伊藤淳一'
  end

  test 'visiting the index' do
    visit books_url
    assert_selector 'h1', text: '本'
    assert_selector 'th', text: 'タイトル'
    assert_selector 'th', text: 'メモ'
    assert_selector 'th', text: '著者'
    assert_selector 'th', text: '画像'
    assert_selector 'td', text: 'チェリー本'
    assert_selector 'td', text: 'とてもわかりやすい'
    assert_selector 'td', text: '伊藤淳一'
  end

  test 'updating a Book' do
    visit books_url
    click_on '詳細'
    assert_no_text 'めっちゃわかりやすい'
    click_on '編集'

    fill_in 'メモ', with: 'めっちゃわかりやすい'
    fill_in 'タイトル', with: 'チェリー本'
    fill_in '著者', with: '伊藤淳一'
    click_on '更新する'

    assert_text '本が更新されました。'

    visit books_url
    assert_text 'めっちゃわかりやすい'
  end

  test 'destroying a Book' do
    visit books_url
    assert_text 'チェリー本'
    page.accept_confirm do
      click_on '削除'
    end

    assert_text '本が削除されました。'
    assert_no_text 'チェリー本'
  end
end

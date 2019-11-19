# frozen_string_literal: true

require 'test_helper'

class AuthorsControllerTest < ActionDispatch::IntegrationTest
  test 'should get first_name:string' do
    get authors_first_name: string_url
    assert_response :success
  end

  test 'should get last_name:string' do
    get authors_last_name: string_url
    assert_response :success
  end

  test 'should get gender:string' do
    get authors_gender: string_url
    assert_response :success
  end

  test 'should get birthday:date' do
    get authors_birthday: date_url
    assert_response :success
  end
end

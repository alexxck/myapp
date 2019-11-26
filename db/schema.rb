# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_191_126_171_219) do
  create_table 'active_storage_attachments', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.integer 'record_id', null: false
    t.integer 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness', unique: true
  end

  create_table 'active_storage_blobs', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.bigint 'byte_size', null: false
    t.string 'checksum', null: false
    t.datetime 'created_at', null: false
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'authors', force: :cascade do |t|
    t.string 'first_name'
    t.string 'last_name'
    t.string 'gender'
    t.date 'birthday'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'email'
    t.string 'password_digest'
    t.boolean 'admin', default: false
    t.index ['email'], name: 'index_authors_on_email', unique: true
  end

  create_table 'comments', force: :cascade do |t|
    t.text 'body'
    t.integer 'post_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'author_id'
    t.index ['author_id'], name: 'index_comments_on_author_id'
    t.index ['post_id'], name: 'index_comments_on_post_id'
  end

  create_table 'impressions', force: :cascade do |t|
    t.string 'impressionable_type'
    t.integer 'impressionable_id'
    t.integer 'user_id'
    t.string 'controller_name'
    t.string 'action_name'
    t.string 'view_name'
    t.string 'request_hash'
    t.string 'ip_address'
    t.string 'session_hash'
    t.text 'message'
    t.text 'referrer'
    t.text 'params'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[controller_name action_name ip_address], name: 'controlleraction_ip_index'
    t.index %w[controller_name action_name request_hash], name: 'controlleraction_request_index'
    t.index %w[controller_name action_name session_hash], name: 'controlleraction_session_index'
    t.index %w[impressionable_type impressionable_id ip_address], name: 'poly_ip_index'
    t.index %w[impressionable_type impressionable_id params], name: 'poly_params_request_index'
    t.index %w[impressionable_type impressionable_id request_hash], name: 'poly_request_index'
    t.index %w[impressionable_type impressionable_id session_hash], name: 'poly_session_index'
    t.index %w[impressionable_type message impressionable_id], name: 'impressionable_type_message_index'
    t.index ['user_id'], name: 'index_impressions_on_user_id'
  end

  create_table 'posts', force: :cascade do |t|
    t.string 'title'
    t.text 'content'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'author_id'
    t.string 'image'
    t.index ['author_id'], name: 'index_posts_on_author_id'
  end

  add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'comments', 'posts'
end

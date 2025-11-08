#!/bin/bash

# Home page
cat > app/views/static_pages/home.html.erb << 'ERB'
<div class="px-4 py-5 my-5 text-center">
  <h1 class="display-5 fw-bold">Rails Blog Application</h1>
  <div class="col-lg-6 mx-auto">
    <p class="lead mb-4">大学生向けのシンプルなブログプラットフォーム</p>
    <div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
      <%= link_to "新規登録", new_user_registration_path, class: "btn btn-primary btn-lg px-4 gap-3" %>
      <%= link_to "ログイン", new_user_session_path, class: "btn btn-outline-secondary btn-lg px-4" %>
      <%= link_to "記事を見る", posts_path, class: "btn btn-outline-primary btn-lg px-4" %>
    </div>
  </div>
</div>
ERB

# Dashboard
cat > app/views/dashboard/show.html.erb << 'ERB'
<h1>ダッシュボード</h1>
<p class="lead">フォロー中のユーザーの投稿</p>

<% if @posts.any? %>
  <% @posts.each do |post| %>
    <div class="card mb-3">
      <div class="card-body">
        <h5 class="card-title"><%= link_to post.title, post %></h5>
        <p class="card-text"><%= truncate(post.content, length: 200) %></p>
        <p class="card-text">
          <small class="text-muted">
            <%= link_to post.user.name, user_path(post.user) %> - 
            <%= time_ago_in_words(post.created_at) %>前
          </small>
        </p>
      </div>
    </div>
  <% end %>
  <%== pagy_bootstrap_nav(@pagy) if @pagy.pages > 1 %>
<% else %>
  <p>フォロー中のユーザーの投稿がありません。</p>
<% end %>
ERB

# Posts index
cat > app/views/posts/index.html.erb << 'ERB'
<div class="d-flex justify-content-between align-items-center mb-4">
  <h1>記事一覧</h1>
  <% if user_signed_in? %>
    <%= link_to "新規投稿", new_post_path, class: "btn btn-primary" %>
  <% end %>
</div>

<% @posts.each do |post| %>
  <div class="card mb-3">
    <div class="card-body">
      <h5 class="card-title"><%= link_to post.title, post %></h5>
      <p class="card-text"><%= truncate(post.content, length: 200) %></p>
      <p class="card-text">
        <small class="text-muted">
          <%= link_to post.user.name, user_path(post.user) %> - 
          <%= time_ago_in_words(post.created_at) %>前
        </small>
      </p>
    </div>
  </div>
<% end %>

<%== pagy_bootstrap_nav(@pagy) if @pagy.pages > 1 %>
ERB

# Posts show
cat > app/views/posts/show.html.erb << 'ERB'
<div class="row">
  <div class="col-lg-8 mx-auto">
    <h1><%= @post.title %></h1>
    
    <div class="d-flex justify-content-between align-items-center mb-3">
      <div>
        <%= link_to @post.user.name, user_path(@post.user), class: "text-decoration-none" %>
        <small class="text-muted">- <%= time_ago_in_words(@post.created_at) %>前</small>
      </div>
      
      <% if user_signed_in? && (@post.user == current_user || current_user.admin?) %>
        <div>
          <%= link_to "編集", edit_post_path(@post), class: "btn btn-sm btn-outline-primary" %>
          <%= button_to "削除", @post, method: :delete, data: { confirm: "本当に削除しますか?" }, class: "btn btn-sm btn-outline-danger" %>
        </div>
      <% end %>
    </div>
    
    <div class="card">
      <div class="card-body">
        <div class="post-content"><%= simple_format(@post.content) %></div>
      </div>
    </div>
  </div>
</div>
ERB

# Posts form
cat > app/views/posts/_form.html.erb << 'ERB'
<%= form_with(model: post, local: true) do |f| %>
  <% if post.errors.any? %>
    <div class="alert alert-danger">
      <h4><%= pluralize(post.errors.count, "error") %> prohibited this post from being saved:</h4>
      <ul>
        <% post.errors.full_messages.each do |message| %>
          <li><%= message %></li>
        <% end %>
      </ul>
    </div>
  <% end %>

  <div class="mb-3">
    <%= f.label :title, "タイトル", class: "form-label" %>
    <%= f.text_field :title, class: "form-control", placeholder: "記事のタイトルを入力（140文字以内）" %>
  </div>

  <div class="mb-3">
    <%= f.label :content, "本文", class: "form-label" %>
    <%= f.text_area :content, rows: 10, class: "form-control", placeholder: "記事の本文を入力" %>
  </div>

  <div class="mb-3">
    <%= f.submit class: "btn btn-primary" %>
    <%= link_to "キャンセル", :back, class: "btn btn-secondary" %>
  </div>
<% end %>
ERB

# Posts new
cat > app/views/posts/new.html.erb << 'ERB'
<h1>新規投稿</h1>
<%= render "form", post: @post %>
ERB

# Posts edit
cat > app/views/posts/edit.html.erb << 'ERB'
<h1>記事を編集</h1>
<%= render "form", post: @post %>
ERB

echo "Views created successfully"

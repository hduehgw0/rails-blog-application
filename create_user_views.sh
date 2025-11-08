#!/bin/bash

# Users show
cat > app/views/users/show.html.erb << 'ERB'
<div class="row">
  <div class="col-md-4">
    <div class="card">
      <div class="card-body">
        <h4><%= @user.name %></h4>
        <p class="text-muted"><%= @user.email %></p>
        <% if @user.introduction.present? %>
          <p><%= @user.introduction %></p>
        <% end %>
        
        <div class="mb-3">
          <strong>投稿数:</strong> <%= @user.posts.count %><br>
          <%= link_to "フォロー中: #{@user.following.count}", following_user_path(@user) %><br>
          <%= link_to "フォロワー: #{@user.followers.count}", followers_user_path(@user) %>
        </div>
        
        <% if user_signed_in? && @user != current_user %>
          <% if current_user.following?(@user) %>
            <% relationship = current_user.active_relationships.find_by(following_id: @user.id) %>
            <%= button_to "フォロー解除", relationship_path(relationship), method: :delete, class: "btn btn-outline-primary w-100" %>
          <% else %>
            <%= button_to "フォローする", relationships_path, params: { following_id: @user.id }, class: "btn btn-primary w-100" %>
          <% end %>
        <% end %>
        
        <% if user_signed_in? && @user == current_user %>
          <%= link_to "プロフィール編集", edit_user_registration_path, class: "btn btn-outline-secondary w-100" %>
        <% end %>
      </div>
    </div>
  </div>
  
  <div class="col-md-8">
    <h4>投稿一覧</h4>
    <% @posts.each do |post| %>
      <div class="card mb-3">
        <div class="card-body">
          <h5 class="card-title"><%= link_to post.title, post %></h5>
          <p class="card-text"><%= truncate(post.content, length: 200) %></p>
          <p class="card-text">
            <small class="text-muted"><%= time_ago_in_words(post.created_at) %>前</small>
          </p>
        </div>
      </div>
    <% end %>
    <%== pagy_bootstrap_nav(@pagy) if @pagy.pages > 1 %>
  </div>
</div>
ERB

# Users following
cat > app/views/users/following.html.erb << 'ERB'
<h1><%= @user.name %> のフォロー中</h1>

<div class="row">
  <% @users.each do |user| %>
    <div class="col-md-6 mb-3">
      <div class="card">
        <div class="card-body">
          <h5><%= link_to user.name, user_path(user) %></h5>
          <p class="text-muted"><%= truncate(user.introduction, length: 100) if user.introduction %></p>
          <small>投稿数: <%= user.posts.count %></small>
        </div>
      </div>
    </div>
  <% end %>
</div>

<%== pagy_bootstrap_nav(@pagy) if @pagy.pages > 1 %>
ERB

# Users followers
cat > app/views/users/followers.html.erb << 'ERB'
<h1><%= @user.name %> のフォロワー</h1>

<div class="row">
  <% @users.each do |user| %>
    <div class="col-md-6 mb-3">
      <div class="card">
        <div class="card-body">
          <h5><%= link_to user.name, user_path(user) %></h5>
          <p class="text-muted"><%= truncate(user.introduction, length: 100) if user.introduction %></p>
          <small>投稿数: <%= user.posts.count %></small>
        </div>
      </div>
    </div>
  <% end %>
</div>

<%== pagy_bootstrap_nav(@pagy) if @pagy.pages > 1 %>
ERB

echo "User views created successfully"

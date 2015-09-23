---
layout: default
title: Blog
categories: blog
permalink: /blog/
---


  <h1 class="page-heading">Posts</h1>

  <ul class="post-list">
    {% for post in site.posts %}
      {% if post.categories contains 'blog'  %}
        {% include post_listitem.html param="post" variable-param=post %}
      {% endif %}
    {% endfor %}
  </ul>

  <p class="rss-subscribe">subscribe <a href="{{ "/feed.xml" | prepend: site.baseurl }}">via RSS</a></p>
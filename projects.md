---
layout: default
title: Projects
categories: projects
permalink: /projects/
---

<h2>My projects</h2>

<ul class="post-list">
{% for post in site.posts %}
    {% if post.categories contains 'projects'  %}
        {% include project_listitem.html param="post" variable-param=post %}
    {% endif %}
{% endfor %}
</ul>
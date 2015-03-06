---
layout: page
title: All Parties
permalink: /parties/
---


<ul>
{% for party in site.data.parties %}
    <li>
        <a href="/parties/{{ party.party_id }}/{{ party.party_name|slugify }}">{{ party.party_name }}</a>
    </li>
{% endfor %}
</ul>
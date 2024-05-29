{% for counter in range (10) %}
    select {{counter}} as num {% if not loop.last %} union all {% endif %}
{% endfor %}
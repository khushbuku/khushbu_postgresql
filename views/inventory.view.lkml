# The name of this view in Looker is "Inventory"
view: inventory {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: public.inventory ;;
  drill_fields: [inventory_id]

  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: inventory_id {
    primary_key: yes
    type: number
    sql: ${TABLE}."inventory_id" ;;
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Film ID" in Explore.

  dimension: film_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."film_id" ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: last_update {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year, hour]
    sql: ${TABLE}."last_update" ;;
  }

  parameter: dynamic_last_update_date_selection {
    type: string
    allowed_value: {value: "Last Update Month"}
    allowed_value: {value: "Last Update Date"}
    allowed_value: {value: "Last Update Hour"}
  }

  dimension: dynamic_last_update_date_dimension {
    type: string
    label_from_parameter: dynamic_last_update_date_selection
    sql:
    {% if dynamic_last_update_date_selection._parameter_value == "'Last Update Month'" %} ${last_update_month}
    {% elsif dynamic_last_update_date_selection._parameter_value == "'Last Update Hour'" %} ${last_update_hour}
    {% else %} ${last_update_date} {% endif %}

      ;;
  }

  dimension: store_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."store_id" ;;
  }
  measure: count {
    type: count
    drill_fields: [inventory_id, store.store_id, film.film_id, rental.count]
  }
}

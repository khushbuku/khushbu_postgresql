# The name of this view in Looker is "Customer"
view: customer {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: public.customer ;;
  drill_fields: [customer_id]

  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: customer_id {
    primary_key: yes
    type: number
    sql: ${TABLE}."customer_id" ;;
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Active" in Explore.

  dimension: active {
    type: number
    sql: ${TABLE}."active" ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_active {
    type: sum
    sql: ${active} ;;  }
  measure: average_active {
    type: average
    sql: ${active} ;;  }

  dimension: activebool {
    type: yesno
    sql: ${TABLE}."activebool" ;;
  }

  dimension: address_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."address_id" ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: create {
    type: time
    timeframes: [raw, date, week, month, quarter, year, hour]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."create_date" ;;
  }

  parameter: dynamic_create_date_selection {
    type: string
    allowed_value: {value: "Created Month"}
    allowed_value: {value: "Created Date"}
    allowed_value: {value: "Created Hour"}
  }

  dimension: dynamic_create_date_dimension {
    type: string
    label_from_parameter: dynamic_create_date_selection
    sql:
    {% if dynamic_create_date_selection._parameter_value == "'Created Month'" %} ${create_month}
    {% elsif dynamic_create_date_selection._parameter_value == "'Created Hour'" %} ${create_hour}
    {% else %} ${create_date} {% endif %}

      ;;
  }




  dimension: email {
    type: string
    sql: ${TABLE}."email" ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}."first_name" ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}."last_name" ;;
  }

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

  parameter: currency_parameter {
    label: "Currency"
    type: unquoted
    allowed_value: {
      label: "Euro"
      value: "EURO"
    }
    allowed_value: {
      label: "Local Currency"
      value: "LOCAL"
    }
  }


  measure: test {
    type: sum
    sql: ${store_id} ;;
   # html: {{rendered_value}} @{currency_html};;
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  customer_id,
  first_name,
  last_name,
  address.address_id,
  store.store_id,
  payment.count,
  rental.count
  ]
  }

}

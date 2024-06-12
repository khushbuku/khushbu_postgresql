# The name of this view in Looker is "Actor Info"
view: actor_info {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: public.actor_info ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Actor ID" in Explore.

  dimension: actor_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."actor_id" ;;
  }

  dimension: film_info {
    type: string
    sql: ${TABLE}."film_info" ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}."first_name" ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}."last_name" ;;
  }
  measure: count {
    type: count
    drill_fields: [last_name, first_name, actor.last_name, actor.actor_id, actor.first_name]
  }
}

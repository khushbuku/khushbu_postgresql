# Define the database connection to be used for this model.
connection: "dvdrental"

# include all the views
include: "/views/**/*.view.lkml"

# Datagroups define a caching policy for an Explore. To learn more,
# use the Quick Help panel on the right to see documentation.

datagroup: khushbu_postgresql_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: khushbu_postgresql_default_datagroup

# Explores allow you to join together different views (database tables) based on the
# relationships between fields. By joining a view into an Explore, you make those
# fields available to users for data analysis.
# Explores should be purpose-built for specific use cases.

# To see the Explore you’re building, navigate to the Explore menu and select an Explore under "Khushbu Postgresql"

# To create more sophisticated Explores that involve multiple views, you can use the join parameter.
# Typically, join parameters require that you define the join type, join relationship, and a sql_on clause.
# Each joined view also needs to define a primary key.

explore: actor {}


explore: actor_info {
  join: actor {
    type: left_outer
    sql_on: ${actor_info.actor_id} = ${actor.actor_id} ;;
    relationship: many_to_one
  }
}

explore: address {
  join: city {
    type: left_outer
    sql_on: ${address.city_id} = ${city.city_id} ;;
    relationship: many_to_one
  }

  join: country {
    type: left_outer
    sql_on: ${city.country_id} = ${country.country_id} ;;
    relationship: many_to_one
  }
}

explore: category {}

explore: city {
  join: country {
    type: left_outer
    sql_on: ${city.country_id} = ${country.country_id} ;;
    relationship: many_to_one
  }
}

explore: country {}

explore: customer {
  always_filter: {
    filters: [customer.date_selector: "2024-06-14", customer.dynamic_last_update_date_selection: "Last Update Month"]
  }
  join: address {
    type: left_outer
    sql_on: ${customer.address_id} = ${address.address_id} ;;
    relationship: many_to_one
  }

  join: store {
    type: left_outer
    sql_on: ${customer.store_id} = ${store.store_id} ;;
    relationship: many_to_one
  }

  join: city {
    type: left_outer
    sql_on: ${address.city_id} = ${city.city_id} ;;
    relationship: many_to_one
  }

  join: country {
    type: left_outer
    sql_on: ${city.country_id} = ${country.country_id} ;;
    relationship: many_to_one
  }
}

explore: customer_list {}

explore: film {
  join: language {
    type: left_outer
    sql_on: ${film.language_id} = ${language.language_id} ;;
    relationship: many_to_one
  }
}

explore: film_actor {
  join: actor {
    type: left_outer
    sql_on: ${film_actor.actor_id} = ${actor.actor_id} ;;
    relationship: many_to_one
  }

  join: film {
    type: left_outer
    sql_on: ${film_actor.film_id} = ${film.film_id} ;;
    relationship: many_to_one
  }

  join: language {
    type: left_outer
    sql_on: ${film.language_id} = ${language.language_id} ;;
    relationship: many_to_one
  }
}

explore: film_category {
  join: film {
    type: left_outer
    sql_on: ${film_category.film_id} = ${film.film_id} ;;
    relationship: many_to_one
  }

  join: category {
    type: left_outer
    sql_on: ${film_category.category_id} = ${category.category_id} ;;
    relationship: many_to_one
  }

  join: language {
    type: left_outer
    sql_on: ${film.language_id} = ${language.language_id} ;;
    relationship: many_to_one
  }
}

explore: film_list {}

explore: inventory {
  join: store {
    type: left_outer
    sql_on: ${inventory.store_id} = ${store.store_id} ;;
    relationship: many_to_one
  }

  join: film {
    type: left_outer
    sql_on: ${inventory.film_id} = ${film.film_id} ;;
    relationship: many_to_one
  }

  join: address {
    type: left_outer
    sql_on: ${store.address_id} = ${address.address_id} ;;
    relationship: many_to_one
  }

  join: city {
    type: left_outer
    sql_on: ${address.city_id} = ${city.city_id} ;;
    relationship: many_to_one
  }

  join: country {
    type: left_outer
    sql_on: ${city.country_id} = ${country.country_id} ;;
    relationship: many_to_one
  }

  join: language {
    type: left_outer
    sql_on: ${film.language_id} = ${language.language_id} ;;
    relationship: many_to_one
  }
}

explore: language {}

explore: nicer_but_slower_film_list {}

explore: payment {
  join: staff {
    type: left_outer
    sql_on: ${payment.staff_id} = ${staff.staff_id} ;;
    relationship: many_to_one
  }

  join: customer {
    type: left_outer
    sql_on: ${payment.customer_id} = ${customer.customer_id} ;;
    relationship: many_to_one
  }

  join: rental {
    type: left_outer
    sql_on: ${payment.rental_id} = ${rental.rental_id} ;;
    relationship: many_to_one
  }

  join: store {
    type: left_outer
    sql_on: ${staff.store_id} = ${store.store_id} ;;
    relationship: many_to_one
  }

  join: address {
    type: left_outer
    sql_on: ${staff.address_id} = ${address.address_id} ;;
    relationship: many_to_one
  }

  join: city {
    type: left_outer
    sql_on: ${address.city_id} = ${city.city_id} ;;
    relationship: many_to_one
  }

  join: country {
    type: left_outer
    sql_on: ${city.country_id} = ${country.country_id} ;;
    relationship: many_to_one
  }

  join: inventory {
    type: left_outer
    sql_on: ${rental.inventory_id} = ${inventory.inventory_id} ;;
    relationship: many_to_one
  }

  join: film {
    type: left_outer
    sql_on: ${inventory.film_id} = ${film.film_id} ;;
    relationship: many_to_one
  }

  join: language {
    type: left_outer
    sql_on: ${film.language_id} = ${language.language_id} ;;
    relationship: many_to_one
  }
}

explore: pivot_test {}

explore: rental {
  join: inventory {
    type: left_outer
    sql_on: ${rental.inventory_id} = ${inventory.inventory_id} ;;
    relationship: many_to_one
  }

  join: staff {
    type: left_outer
    sql_on: ${rental.staff_id} = ${staff.staff_id} ;;
    relationship: many_to_one
  }

  join: customer {
    type: left_outer
    sql_on: ${rental.customer_id} = ${customer.customer_id} ;;
    relationship: many_to_one
  }

  join: store {
    type: left_outer
    sql_on: ${inventory.store_id} = ${store.store_id} ;;
    relationship: many_to_one
  }

  join: film {
    type: left_outer
    sql_on: ${inventory.film_id} = ${film.film_id} ;;
    relationship: many_to_one
  }

  join: address {
    type: left_outer
    sql_on: ${store.address_id} = ${address.address_id} ;;
    relationship: many_to_one
  }

  join: city {
    type: left_outer
    sql_on: ${address.city_id} = ${city.city_id} ;;
    relationship: many_to_one
  }

  join: country {
    type: left_outer
    sql_on: ${city.country_id} = ${country.country_id} ;;
    relationship: many_to_one
  }

  join: language {
    type: left_outer
    sql_on: ${film.language_id} = ${language.language_id} ;;
    relationship: many_to_one
  }
}

explore: sales_by_film_category {}

explore: sales_by_store {}

explore: staff {
  join: store {
    type: left_outer
    sql_on: ${staff.store_id} = ${store.store_id} ;;
    relationship: many_to_one
  }

  join: address {
    type: left_outer
    sql_on: ${staff.address_id} = ${address.address_id} ;;
    relationship: many_to_one
  }

  join: city {
    type: left_outer
    sql_on: ${address.city_id} = ${city.city_id} ;;
    relationship: many_to_one
  }

  join: country {
    type: left_outer
    sql_on: ${city.country_id} = ${country.country_id} ;;
    relationship: many_to_one
  }
}

explore: staff_list {}

explore: store {
  join: address {
    type: left_outer
    sql_on: ${store.address_id} = ${address.address_id} ;;
    relationship: many_to_one
  }

  join: city {
    type: left_outer
    sql_on: ${address.city_id} = ${city.city_id} ;;
    relationship: many_to_one
  }

  join: country {
    type: left_outer
    sql_on: ${city.country_id} = ${country.country_id} ;;
    relationship: many_to_one
  }
}

explore: test1 {}

explore: test2 {}

explore: test3 {}

connection: "htf2024"

# include all the views
include: "/views/**/*.view.lkml"



explore: discovery_facility {
  join: discovery_telescope {
    relationship: one_to_many
    sql_on: ${discovery_facility.facility_id} =${discovery_telescope.facility_id} ;;
  }
}

explore: planet {
  join: star {
    type: left_outer
    relationship: many_to_one
    sql_on: ${planet.host_id} = ${star.host_id} ;;

  }
  join: discovery_facility {
    type: left_outer
    relationship: one_to_one
    sql_on: ${discovery_facility.facility_id} = ${planet.facility_id} ;;
  }
  join: discovery_telescope {
    type: left_outer
    relationship: one_to_many
    sql_on: ${discovery_facility.facility_id} = ${discovery_telescope.facility_id} ;;
  }
}

explore: discovery_telescope {
}

explore: raw_planets {}

explore: star {}

view: planet {
  sql_table_name: `planets_dataset.planet` ;;
  drill_fields: [planet_id]

  dimension: planet_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.planet_id ;;
  }
  dimension: dec_deg {
    type: number
    sql: ${TABLE}.dec_deg ;;
  }
  dimension: dec_sexagesimal {
    type: string
    sql: ${TABLE}.dec_sexagesimal ;;
  }
  dimension: eccentricity {
    type: number
    sql: ${TABLE}.eccentricity ;;
  }
  dimension: equilibrium_temperature_k {
    type: number
    sql: ${TABLE}.equilibrium_temperature_k ;;
  }
  dimension: facility_id {
    type: number
    sql: ${TABLE}.facility_id ;;
  }
  dimension: gaia_magnitude {
    type: number
    sql: ${TABLE}.gaia_magnitude ;;
  }
  dimension: gaia_magnitude_lower_unc {
    type: number
    sql: ${TABLE}.gaia_magnitude_lower_unc ;;
  }
  dimension: gaia_magnitude_upper_unc {
    type: number
    sql: ${TABLE}.gaia_magnitude_upper_unc ;;
  }
  dimension: host_id {
    type: number
    sql: ${TABLE}.host_id ;;
  }
  dimension: impact_parameter {
    type: number
    sql: ${TABLE}.impact_parameter ;;
  }
  dimension: inclination_deg {
    type: number
    sql: ${TABLE}.inclination_deg ;;
  }
  dimension: insolation_flux_earth {
    type: number
    sql: ${TABLE}.insolation_flux_earth ;;
  }
  dimension: ks_2mass_magnitude {
    type: number
    sql: ${TABLE}.ks_2mass_magnitude ;;
  }
  dimension: orbit_semi_major_axis_au {
    type: number
    sql: ${TABLE}.orbit_semi_major_axis_au ;;
  }
  dimension: orbital_period_days {
    type: number
    sql: ${TABLE}.orbital_period_days ;;
  }
  dimension: planet_density {
    type: number
    sql: ${TABLE}.planet_density ;;
  }
  dimension: planet_mass_earth {
    type: number
    sql: ${TABLE}.planet_mass_earth ;;
  }
  dimension: planet_mass_jupiter {
    type: number
    sql: ${TABLE}.planet_mass_jupiter ;;
  }
  dimension: planet_mass_provenance {
    type: string
    sql: ${TABLE}.planet_mass_provenance ;;
  }
  dimension: planet_name {
    type: string
    sql: ${TABLE}.planet_name ;;
  }
  dimension: planet_radius_earth {
    type: number
    sql: ${TABLE}.planet_radius_earth ;;
  }
  dimension: planet_radius_jupiter {
    type: number
    sql: ${TABLE}.planet_radius_jupiter ;;
  }
  dimension: ra_deg {
    type: number
    sql: ${TABLE}.ra_deg ;;
  }
  dimension: ra_sexagesimal {
    type: string
    sql: ${TABLE}.ra_sexagesimal ;;
  }
  dimension: spectral_type {
    type: string
    sql: ${TABLE}.spectral_type ;;
  }
  dimension: v_johnson_magnitude {
    type: number
    sql: ${TABLE}.v_johnson_magnitude ;;
  }
  measure: count {
    type: count
    drill_fields: [planet_id, planet_name]
  }
  dimension: is_habitable {
    type: yesno
    sql:
    CASE
      WHEN ${planet_mass_earth} > 0.1 AND ${planet_mass_earth} < 10
        AND ${planet_radius_earth} > 0.5 AND ${planet_radius_earth} < 2.5
        AND ${equilibrium_temperature_k} > 175 AND ${equilibrium_temperature_k} < 274
        AND ${planet_density} > 1
        AND ${eccentricity} < 0.2 THEN TRUE
      ELSE FALSE
    END ;;
  }
  measure: habitable_planets {
    type: count
    filters: [is_habitable: "Yes"]
  }

  measure: stellar_flux {
    type: average
    sql:
    CASE
      WHEN ${impact_parameter} IS NOT NULL AND ${impact_parameter} > 0 THEN
      ROUND(
        (${star.stellar_luminosity} / (4 * 3.14159265 * POWER(${impact_parameter}, 2))),3)
    END ;;
  }
  dimension: dim_stellar_flux {
    type: number
    sql:
    CASE
      WHEN ${impact_parameter} IS NOT NULL AND ${impact_parameter} > 0 THEN
      ROUND(
        (${star.stellar_luminosity} / (4 * 3.14159265 * POWER(${impact_parameter}, 2))),3)
    END ;;
  }
}

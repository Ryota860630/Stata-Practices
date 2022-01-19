/*_//_//_//_//_//_//_//_//_//_//_//_//
  APP 2022
  Data Collection
  Fleet DNA: Commercial Fleet Vehicle Operating Data
//_//_//_//_//_//_//_//_//_//_//_//_*/

clear all
cap log close
set more off

cd "C:\Users\rabe8\OneDrive\ドキュメント\留学全般\14. APP\2) WINTER 298B-C Applied Policy Project Ⅱ\Data Collection\Vehicle Data\Freet DNA"


// Delivery Vans Data //
quietly import delimited using "https://www.nrel.gov/transportation/assets/docs/data_for_fleet_dna_delivery_vans.csv", clear

keep class_id absolute_time_duration_hrs speed_data_duration_hrs driving_data_duration_hrs non_recorded_time_hrs total_average_speed total_stops stops_per_mile average_stop_duration
quietly save "Delivery_Vans_Data", replace

// Delivery Trucks Data //
quietly import delimited using "https://www.nrel.gov/transportation/assets/docs/data_for_fleet_dna_delivery_trucks.csv", clear

keep class_id absolute_time_duration_hrs speed_data_duration_hrs driving_data_duration_hrs non_recorded_time_hrs total_average_speed total_stops stops_per_mile average_stop_duration
quietly save "Delivery_Trucks_Data", replace

// Service Vans Data //
quietly import delimited using "https://www.nrel.gov/transportation/assets/docs/data_for_fleet_dna_service_vans.csv", clear

keep class_id absolute_time_duration_hrs speed_data_duration_hrs driving_data_duration_hrs non_recorded_time_hrs total_average_speed total_stops stops_per_mile average_stop_duration
quietly save "Service_Vans_Data", replace
append using "Delivery_Vans_Data"
append using "Delivery_Trucks_Data"

local myLocal class_id absolute_time_duration_hrs speed_data_duration_hrs
mean `myLocal' if class_id == 1
forvalues i = 2/5{
mean `myLocal' if class_id == `i'
display r(table)[1,1] ", " r(table)[1,2] ", "  r(table)[2,2]  ", " r(table)[1,3] ", "  r(table)[2,3]  ", " ///
r(table)[1,4] ", "  r(table)[2,4]  ", " r(table)[1,5] ", "  r(table)[2,5]  ", " ///
r(table)[1,6] ", "  r(table)[2,6]  ", " r(table)[1,7] ", "  r(table)[2,7]  ", " ///
r(table)[1,8] ", "  r(table)[2,8]  ", " r(table)[1,9] ", "  r(table)[2,9] 
}

/*
forvalues i = 1/5{
	qui summarize absolute_time_duration_hrs if class_id ==  `i'
	display `i' ",  " r(N) ",  " r(mean) ",  " r(sd)
}
*/

/*
forvalues i = 1/5{
	qui summarize speed_data_duration_hrs if class_id ==  `i'
	display `i' ", " r(N) ", " r(mean) ", " r(sd)
}
*/

export delimited using "Driving Characteristics of Last Mile Trucks", replace

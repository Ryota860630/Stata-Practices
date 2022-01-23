/*_//_//_//_//_//_//_//_//_//_//_//_//
  APP 2022
  Data Collection
  EV Stock: IEA datavbase - global-ev-data-explorer
//_//_//_//_//_//_//_//_//_//_//_//_*/

clear all
cap log close
set more off

cd "C:\Users\rabe8\OneDrive\ドキュメント\留学全般\14. APP\2) WINTER 298B-C Applied Policy Project Ⅱ\Data Collection\Vehicle Data\EV Stock World"

// Vans
// https://api.iea.org/evs/?parameter=EV%20stock&mode=Vans&category=Projection-STEPS&csv=true

// Trucks
// https://api.iea.org/evs/?parameter=EV%20stock&mode=Trucks&category=Projection-STEPS&csv=true

// Delivery Vans Data //
quietly import delimited using "https://api.iea.org/evs/?parameter=EV%20stock&mode=Vans&category=Historical&csv=true", clear
quietly save "Vans_Data", replace

// Delivery Trucks Data //
quietly import delimited using "https://api.iea.org/evs/?parameter=EV%20stock&mode=Trucks&category=Historical&csv=true", clear
quietly save "Trucks_Data", replace

append using "Vans_Data"
export delimited using "World Share of EV ", replace


/* -------
2020 Share by country
------- */ 
drop if year != 2020
bysort region: egen total = total(value)
bysort region: gen first = (_n == 1)
drop if first != 1
drop if region == "World"
gsort - total
graph pie total, over(region)

log close
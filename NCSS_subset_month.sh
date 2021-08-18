#!/bin/bash
# This is an example script to subset and download Daymet gridded daily data utilizing the netCDF Subset Service RESTful API 
# available through the ORNL DAAC THREDDS Data Server
#
# Daymet data and an interactive netCDF Subset Service GUI are available from the THREDDS web interface:
# https://thredds.daac.ornl.gov/thredds/catalogs/ornldaac/Regional_and_Global_Data/DAYMET_COLLECTIONS/DAYMET_COLLECTIONS.html
#
# Usage:  This is a sample script and not intended to run without user updates.
# Update the inputs under each section of "VARIABLES" for temporal, spatial, and Daymet weather variables.
# More information on Daymet NCSS gridded subset web service is found at:  https://daymet.ornl.gov/web_services
#
# The current Daymet NCSS has a size limit of 6GB for each single subset request. 
#
# Daymet dataset information including citation is available at:
# https://daymet.ornl.gov/
#
# Michele Thornton
# ORNL DAAC
# November 5, 2018
#
#################################################################################
# VARIABLES - Temporal subset - This example is set to subset the 31 days of January for each years 1980, 1981, and 1982
# Note:  The Daymet calendar is based on a standard calendar year. All Daymet years have 1 - 365 days, including leap years. For leap years, 
# the Daymet database includes leap day. Values for December 31 are discarded from leap years to maintain a 365-day year.
# Time should be in the form yyyy mm dd
startyr=1980
startmn=01
startday=01

endyr=1982 
endmn=01
endday=31

# VARIABLES - Region - na is used a example. The complete list of regions is: na (North America), hi(Hawaii), pr(Puerto Rico)
region="na"

# VARIABLES - Daymet variables - tmin and tmax are used as examples, variables should be space separated. 
# The complete list of Daymet variables is: tmin, tmax, prcp, srad, vp, swe, dayl
var="tmin tmax"

# VARIABLES - Spatial subset - bounding box in decimal degrees.  
north=36.61
west=-85.37
east=-81.29
south=33.57
################################################################################

for ((i=startyr;i<=endyr;i++)); do
echo $startyr
echo $i
	for par in $var; do
	echo $par
		
		wget -O ${par}_${i}_${startmn}subset.nc "http://thredds.daac.ornl.gov/thredds/ncss/grid/ornldaac/1840/daymet_v4_daily_${region}_${par}_${i}.nc?var=lat&var=lon&var=${par}&north=${north}&west=${west}&east=${east}&south=${south}&horizStride=1&time_start=${i}-${startmn}-${startday}T12:00:00Z&time_end=${i}-${endmn}-${endday}T12:00:00Z&timeStride=1&accept=netcdf"
			# An example using cURL
			# curl -o ${par}_${i}_${startmn}subset.nc "http://thredds.daac.ornl.gov/thredds/ncss/grid/ornldaac/1840/daymet_v4_daily_${region}_${par}_${i}.nc?var=lat&var=lon&var=${par}&north=${north}&west=${west}&east=${east}&south=${south}&horizStride=1&time_start=${i}-${startmn}-${startday}T12:00:00Z&time_end=${i}-${endmn}-${endday}T12:00:00Z&timeStride=1&accept=netcdf"
		
	done;
done

echo Downloads Complete
